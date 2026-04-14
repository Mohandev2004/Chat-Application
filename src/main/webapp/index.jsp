<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Java Chat - Intelligent Communication</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="landing-body">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-transparent pt-4 px-4 sticky-top">
        <div class="container-fluid max-w-1200">
            <a class="navbar-brand fw-bold fs-3 text-glow" href="#">ChatApp<span class="text-accent">Chat</span></a>
            <div class="d-flex gx-3">
                <% if (session.getAttribute("username") != null) { %>
                    <a href="chat.jsp" class="btn btn-accent rounded-pill px-4 fw-semibold shadow-sm">Enter Chat</a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-outline-light rounded-pill px-4 fw-semibold me-2">Log In</a>
                    <a href="register.jsp" class="btn btn-accent rounded-pill px-4 fw-semibold shadow-sm">Sign Up Free</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section text-center d-flex align-items-center justify-content-center">
        <div class="container hero-content">
            <div class="badge bg-glass px-3 py-2 rounded-pill mb-4 animated-fade-in-up">
                <span class="text-accent fw-bold px-2 py-1 bg-accent bg-opacity-25 rounded-pill me-2">NEW</span> 
                Real-time WebSocket Engine powered by Java
            </div>
            
            <h1 class="display-2 fw-bolder text-white mb-4 animated-fade-in-up delay-1 title-glow">
                Connect Instantly,<br>
                <span class="text-gradient">Communicate Brilliantly.</span>
            </h1>
            
            <p class="lead text-light-gray mb-5 mx-auto hero-subtitle animated-fade-in-up delay-2">
                Experience seamless, high-performance messaging built on robust Java Architecture. Simple, elegant, and blazingly fast.
            </p>
            
            <div class="action-buttons animated-fade-in-up delay-3">
                <% if (session.getAttribute("username") != null) { %>
                    <a href="chat.jsp" class="btn btn-accent btn-lg rounded-pill px-5 py-3 fw-bold shadow-lg interactive-hover">Start Chatting Now</a>
                <% } else { %>
                    <a href="register.jsp" class="btn btn-accent btn-lg rounded-pill px-5 py-3 fw-bold shadow-lg interactive-hover me-3">Get Started Today &rarr;</a>
                    <a href="login.jsp" class="btn btn-glass btn-lg rounded-pill px-5 py-3 fw-bold shadow-sm interactive-hover">Returning User</a>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Features Micro-cards -->
    <div class="features-wrapper pb-5">
        <div class="container max-w-1200">
            <div class="row g-4 mt-1 animated-fade-in-up delay-4">
                <div class="col-md-4">
                    <div class="glass-card p-4 rounded-4 text-white hover-lift">
                        <div class="icon-box bg-accent-glow text-accent mb-3 rounded-3 d-inline-flex align-items-center justify-content-center">
                            ⚡
                        </div>
                        <h4 class="fw-semibold">Real-Time Speed</h4>
                        <p class="text-light-gray mb-0">Powered by cutting edge AJAX polling to ensure zero message latency.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-card p-4 rounded-4 text-white hover-lift">
                        <div class="icon-box bg-accent-glow text-accent mb-3 rounded-3 d-inline-flex align-items-center justify-content-center">
                            🔒
                        </div>
                        <h4 class="fw-semibold">Secure Core</h4>
                        <p class="text-light-gray mb-0">Built on Java Servlets with prepared statements safeguarding database layers.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-card p-4 rounded-4 text-white hover-lift">
                        <div class="icon-box bg-accent-glow text-accent mb-3 rounded-3 d-inline-flex align-items-center justify-content-center">
                            🎨
                        </div>
                        <h4 class="fw-semibold">Premium Design</h4>
                        <p class="text-light-gray mb-0">A sleek, beautiful interface designed to keep you focused on conversations.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
