# Java Chat Application 💬

A modern, WhatsApp-styled 1-to-1 private messaging application built using **Java (JSP & Servlets)** and **MySQL**. This project features a clean, responsive UI and real-time messaging capabilities powered by AJAX.

## 🚀 Key Features

- **User Authentication**: Secure Login and Registration system.
- **Private Messaging**: 1-to-1 chat functionality with dedicated message history.
- **Real-time Interaction**: Messages are refreshed automatically using AJAX without page reloads.
- **User Discovery**: A sidebar listing all registered users to start new conversations.
- **Premium UI**: Modern design with glassmorphism effects, interactive chat bubbles, and a responsive layout.
- **Secure Backend**: Uses JDBC Prepared Statements to prevent SQL injection.

## 🛠️ Tech Stack

- **Frontend**: JSP, HTML5, CSS3, JavaScript (AJAX)
- **Backend**: Java Servlets (MVC Architecture)
- **Database**: MySQL
- **Build Tool**: Maven
- **Libraries**:
  - `GSON`: For handling JSON data in AJAX requests.
  - `MySQL Connector`: For database connectivity.
  - `JSTL`: For dynamic content rendering in JSPs.

## 📂 Project Structure

```text
chatapplication/
├── src/main/java/com/chatapp/
│   ├── controller/      # Servlets (Login, Chat, UserList, etc.)
│   ├── dao/             # Data Access Objects (DB logic)
│   ├── model/           # POJO classes (User, Message)
├── src/main/webapp/
│   ├── css/             # Styling files
│   ├── chat.jsp         # Main Chat Interface
│   ├── login.jsp        # Login Page
│   ├── register.jsp     # Registration Page
│   └── index.jsp        # Landing Page
├── database.sql         # SQL script to setup database
└── pom.xml              # Maven dependencies and configuration
```

## ⚙️ Setup and Installation

### 1. Prerequisites
- **Java JDK 8 or higher**
- **Maven**
- **MySQL Server**
- **Apache Tomcat (Optional)**: Can be run via Maven plugin.

### 2. Database Setup
1. Open your MySQL terminal or Workbench.
2. Execute the commands in the `database.sql` file located in the root directory.
   ```sql
   SOURCE path/to/database.sql;
   ```

### 3. Configure Database Connection
1. Navigate to `src/main/java/com/chatapp/dao/DBConnection.java`.
2. Update the `USER` and `PASSWORD` fields with your MySQL credentials:
   ```java
   private static final String USER = "your_username";
   private static final String PASSWORD = "your_password";
   ```

### 4. Running the Application (via Maven)
You can run this project easily using the integrated Maven Tomcat plugin:
```bash
mvn tomcat7:run
```
Once started, open your browser and go to:
`http://localhost:8080/`

### 5. Running in Eclipse IDE
For those who prefer using Eclipse, follow these steps:

1.  **Import the Project**:
    - Open Eclipse IDE (Eclipse IDE for Enterprise Java and Web Developers is recommended).
    - Go to `File` -> `Import...`
    - Select `Maven` -> `Existing Maven Projects` and click `Next`.
    - Browse to the project folder and click `Finish`.
2.  **Configure Tomcat Server**:
    - If not already added, go to `Window` -> `Preferences` -> `Server` -> `Runtime Environments`.
    - Click `Add`, select your `Apache Tomcat` version, and point it to your Tomcat installation directory.
3.  **Run the Application**:
    - Right-click on the project in the Project Explorer.
    - Select `Run As` -> `Run on Server`.
    - Select your configured Tomcat server and click `Finish`.
4.  **Access the App**:
    - Eclipse will likely open its internal browser. You can also use:
      `http://localhost:8080/chatapp/` (Note: The context path might differ based on your server settings).

## 📸 Screenshots

*(Add screenshots here of the Login and Chat Interface)*

## 📄 License
This project was developed as a final-year demonstration project. Feel free to use and modify it for learning purposes.

---