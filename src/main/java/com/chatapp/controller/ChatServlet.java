package com.chatapp.controller;

import com.chatapp.dao.MessageDAO;
import com.chatapp.model.Message;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Handles sending and retrieving chat messages via AJAX.
 */
@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
    private MessageDAO messageDAO;
    private Gson gson;

    @Override
    public void init() {
        messageDAO = new MessageDAO();
        gson = new Gson();

        // --- AUTO DATABASE UPDATE ---
        // Since you don't have MySQL Workbench, we will force Java to update the
        // database
        // for you the moment this Servlet starts up.
        try (java.sql.Connection conn = com.chatapp.dao.DBConnection.getConnection();
                java.sql.Statement stmt = conn.createStatement()) {

            stmt.execute("DROP TABLE IF EXISTS messages");
            stmt.execute("CREATE TABLE messages (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "sender VARCHAR(50) NOT NULL, " +
                    "receiver VARCHAR(50) NOT NULL, " +
                    "message TEXT NOT NULL, " +
                    "timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

            System.out.println("========== DATABASE WAS SUCCESSFULLY UPDATED ==========");
        } catch (Exception e) {
            System.err.println("Database update heavily failed: " + e.getMessage());
            e.printStackTrace();
        }
        // -----------------------------
    }

    // Handles retrieving messages (AJAX GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String receiver = request.getParameter("receiver");
        if (receiver == null || receiver.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String currentUser = (String) session.getAttribute("username");
        List<Message> messages = messageDAO.getMessagesBetween(currentUser, receiver);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print(gson.toJson(messages));
        out.flush();
    }

    // Handles sending a new message (AJAX POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure user is logged in before allowing them to post
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String currentUser = (String) session.getAttribute("username");
        String messageText = request.getParameter("message");
        String receiver = request.getParameter("receiver");

        if (messageText != null && !messageText.trim().isEmpty() && receiver != null && !receiver.trim().isEmpty()) {
            Message msg = new Message();
            msg.setSender(currentUser);
            msg.setReceiver(receiver);
            msg.setMessage(messageText.trim());

            boolean success = messageDAO.saveMessage(msg);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            if (success) {
                out.print("{\"status\":\"success\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"status\":\"error\"}");
            }
            out.flush();
        }
    }
}
