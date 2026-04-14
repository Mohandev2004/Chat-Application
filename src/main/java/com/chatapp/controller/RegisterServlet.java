package com.chatapp.controller;

import com.chatapp.dao.UserDAO;
import com.chatapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles user registration.
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userRaw = request.getParameter("username");
        String pass = request.getParameter("password");
        
        if (userRaw != null && pass != null && !userRaw.trim().isEmpty() && !pass.trim().isEmpty()) {
            String username = userRaw.trim();
            
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(pass);
            
            boolean success = userDAO.registerUser(newUser);
            
            if (success) {
                request.setAttribute("successMessage", "Registration successful! You can now log in.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed. Username might already exist.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Please provide a valid username and password.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
