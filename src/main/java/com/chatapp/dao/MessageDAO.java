package com.chatapp.dao;

import com.chatapp.model.Message;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Handles database operations for chat messages.
 */
public class MessageDAO {

    /**
     * Saves a new message to the database.
     */
    public boolean saveMessage(Message msg) {
        String query = "INSERT INTO messages (sender, receiver, message) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, msg.getSender());
            pstmt.setString(2, msg.getReceiver());
            pstmt.setString(3, msg.getMessage());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves recent private messages between two users.
     */
    public List<Message> getMessagesBetween(String userA, String userB) {
        List<Message> messages = new ArrayList<>();
        String query = "SELECT * FROM (SELECT * FROM messages WHERE (sender=? AND receiver=?) OR (sender=? AND receiver=?) ORDER BY timestamp DESC LIMIT 50) sub ORDER BY timestamp ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, userA);
            pstmt.setString(2, userB);
            pstmt.setString(3, userB);
            pstmt.setString(4, userA);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Message msg = new Message();
                    msg.setId(rs.getInt("id"));
                    msg.setSender(rs.getString("sender"));
                    msg.setReceiver(rs.getString("receiver"));
                    msg.setMessage(rs.getString("message"));
                    msg.setTimestamp(rs.getTimestamp("timestamp"));
                    messages.add(msg);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }
}
