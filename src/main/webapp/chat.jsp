<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String currentUser = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="chat-app-body">
<div class="container-fluid h-100 p-0">
    <div class="row g-0 h-100 shadow-lg">
        
        <!-- Left Sidebar: Contacts list -->
        <div class="col-md-4 col-lg-3 bg-white border-end d-flex flex-column h-100 sidebar-container z-index-2">
            <div class="p-3 sidebar-header d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <div class="avatar bg-secondary text-white rounded-circle d-flex justify-content-center align-items-center me-2 fw-bold" style="width: 40px; height: 40px;"><%= currentUser.substring(0,1).toUpperCase() %></div>
                    <span class="fw-semibold text-dark"><%= currentUser %></span>
                </div>
                <a href="LogoutServlet" class="btn btn-sm text-secondary" title="Logout">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/><path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/></svg>
                </a>
            </div>
            <div class="p-2 search-container">
                <input type="text" id="searchUser" class="form-control rounded-pill border-0 px-3 py-1" placeholder="Search or start new chat">
            </div>
            <div class="flex-grow-1 overflow-auto bg-white" id="userList">
                <div class="text-center text-muted mt-5 spinner-border spinner-border-sm" role="status"></div>
            </div>
        </div>

        <!-- Right Side: Active Chat -->
        <div class="col-md-8 col-lg-9 d-flex flex-column h-100 chat-main-container bg-chat-pattern position-relative">
            <!-- Default Empty State -->
            <div id="emptyState" class="d-flex flex-column justify-content-center align-items-center h-100 w-100 text-center" style="background-color: #f0f2f5;">
                <img src="https://cdn-icons-png.flaticon.com/512/134/134914.png" width="200" alt="Chat">
                <h3 class="fw-light text-dark mb-3"> Chat for Web</h3>
                <p class="text-secondary mb-1">Send and receive messages without keeping your phone online.</p>
                <p class="text-secondary"><small><svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-lock-fill me-1" viewBox="0 0 16 16"><path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/></svg> End-to-end encrypted messaging.</small></p>
            </div>

            <!-- Active Chat State (Hidden by default) -->
            <div id="activeChat" class="d-flex flex-column h-100 d-none w-100 position-absolute" style="top:0; left:0;">
                <div class="px-3 py-2 chat-main-header shadow-sm d-flex align-items-center z-index-1">
                    <div class="avatar bg-primary text-white rounded-circle d-flex justify-content-center align-items-center me-3 fw-bold" style="width: 40px; height: 40px; font-size: 1.2rem;" id="chatHeaderAvatar">U</div>
                    <div>
                        <h6 class="mb-0 fw-semibold text-dark" id="chatHeaderName">User</h6>
                        <small class="text-muted" style="font-size: 12px;">click here for contact info</small>
                    </div>
                </div>
                
                <div class="flex-grow-1 p-3 overflow-auto chat-box" id="chatBox">
                    <!-- Messages go here -->
                </div>
                
                <div class="p-2 chat-input-area">
                    <form id="messageForm" class="d-flex gx-2 align-items-center w-100 px-2 py-1">
                        <button type="button" class="btn text-secondary px-2 border-0 shadow-none"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-emoji-smile" viewBox="0 0 16 16"><path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/><path d="M4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zm4 0c0 .828-.448 1.5-1 1.5s-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5z"/></svg></button>
                        <button type="button" class="btn text-secondary px-2 me-2 border-0 shadow-none"><svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16"><path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0V3z"/></svg></button>
                        
                        <input type="text" id="messageInput" class="form-control rounded-3 border-0 py-2 px-3 shadow-none flex-grow-1" placeholder="Type a message" autocomplete="off" required>
                        
                        <button type="submit" class="btn send-btn px-3 d-flex align-items-center justify-content-center shadow-none">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-send-fill" viewBox="0 0 16 16">
                                <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083l6-15Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const currentUser = '<%= currentUser %>';
    let selectedReceiver = null;
    let autoScroll = true;

    const userListContainer = document.getElementById('userList');
    const emptyState = document.getElementById('emptyState');
    const activeChat = document.getElementById('activeChat');
    const chatHeaderName = document.getElementById('chatHeaderName');
    const chatHeaderAvatar = document.getElementById('chatHeaderAvatar');
    const chatBox = document.getElementById('chatBox');
    const messageForm = document.getElementById('messageForm');
    const messageInput = document.getElementById('messageInput');

    function formatTime(timestampStr) {
        if (!timestampStr) return '';
        const date = new Date(timestampStr);
        return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }

    // Scroll control logic
    chatBox.addEventListener('scroll', () => {
        const isAtBottom = (chatBox.scrollHeight - chatBox.scrollTop - chatBox.clientHeight) < 10;
        autoScroll = isAtBottom;
    });

    // Populate the sidebar with users
    function fetchUsers() {
        fetch('UserListServlet')
            .then(res => res.json())
            .then(users => {
                userListContainer.innerHTML = '';
                if(users.length === 0) {
                    userListContainer.innerHTML = '<div class="p-4 text-muted text-center">No other users found.</div>';
                    return;
                }
                users.forEach(u => {
                    const div = document.createElement('div');
                    const isActive = selectedReceiver === u.username ? 'active-user' : '';
                    div.className = `user-list-item p-3 border-bottom d-flex align-items-center cursor-pointer \${isActive}`;
                    div.onclick = () => selectUser(u.username);
                    div.innerHTML = `
                        <div class="avatar text-white rounded-circle d-flex justify-content-center align-items-center me-3 fw-bold shadow-sm" style="width: 49px; height: 49px; background-color: #53bdeb; font-size: 1.1rem;">
                            \${u.username.charAt(0).toUpperCase()}
                        </div>
                        <div class="flex-grow-1 border-bottom-0 pb-1">
                            <h6 class="mb-1 fw-normal text-dark" style="font-size: 17px;">\${u.username}</h6>
                            <small class="text-muted d-block text-truncate" style="font-size: 13px;">Tap to chat...</small>
                        </div>
                    `;
                    userListContainer.appendChild(div);
                });
            }).catch(console.error);
    }

    // Select a user to chat with
    function selectUser(username) {
        selectedReceiver = username;
        emptyState.classList.add('d-none');
        activeChat.classList.remove('d-none');
        
        chatHeaderName.innerText = username;
        chatHeaderAvatar.innerText = username.charAt(0).toUpperCase();
        chatHeaderAvatar.className = 'avatar bg-primary text-white rounded-circle d-flex justify-content-center align-items-center me-3';
        
        // Re-render user list to show active state
        fetchUsers();
        
        chatBox.innerHTML = '<div class="text-center text-muted mt-5">Loading private messages...</div>';
        autoScroll = true;
        fetchMessages(true);
    }

    // Fetch messages for the active conversation
    function fetchMessages(forceScroll = false) {
        if (!selectedReceiver) return;
        
        fetch('ChatServlet?receiver=' + encodeURIComponent(selectedReceiver))
            .then(res => {
                if(res.status === 401) { window.location.href = 'login.jsp'; return null; }
                return res.json();
            })
            .then(messages => {
                if(!messages) return;
                
                chatBox.innerHTML = '';
                
                if(messages.length === 0) {
                    chatBox.innerHTML = '<div class="text-center text-muted mt-5">No messages yet. Say hi! 👋</div>';
                    return;
                }

                const dateOptions = { month: '2-digit', day: '2-digit', year: 'numeric' };
                let lastDate = "";

                messages.forEach(msg => {
                    const isMine = msg.sender === currentUser;
                    
                    // Optional: Date separation logic could go here
                    
                    const wrapper = document.createElement('div');
                    wrapper.className = 'd-flex w-100 msg-wrapper ' + (isMine ? 'justify-content-end' : 'justify-content-start');
                    
                    const bubble = document.createElement('div');
                    bubble.className = 'msg-bubble ' + (isMine ? 'mine' : 'theirs');
                    
                    const textContent = msg.message.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
                    const timeStr = formatTime(msg.timestamp);
                    
                    bubble.innerHTML = `
                        <span>\${textContent}</span>
                        <span class="msg-time">
                            \${timeStr} \${isMine ? '<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="#53bdeb" class="bi bi-check-all ms-1" viewBox="0 0 16 16"><path d="M8.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L2.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093L8.95 4.992a.252.252 0 0 1 .02-.022zm-.92 5.14.92.92a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 1 0-1.091-1.028L9.477 9.417l-.485-.486-.943 1.179z"/></svg>' : ''}
                        </span>
                    `;
                    
                    wrapper.appendChild(bubble);
                    chatBox.appendChild(wrapper);
                });
                
                if (autoScroll || forceScroll) {
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            }).catch(console.error);
    }

    messageForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const msgText = messageInput.value.trim();
        if (!msgText || !selectedReceiver) return;

        const formData = new URLSearchParams();
        formData.append('message', msgText);
        formData.append('receiver', selectedReceiver);

        fetch('ChatServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        }).then(res => {
            if(res.ok) {
                messageInput.value = '';
                autoScroll = true;
                fetchMessages(true);
            }
        });
    });

    // Initialize
    fetchUsers();
    setInterval(() => {
        fetchUsers();
        fetchMessages();
    }, 3000);
</script>
</body>
</html>
