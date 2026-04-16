<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Chat App</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #4f46e5, #9333ea);
        }

        .card {
            border-radius: 16px;
            backdrop-filter: blur(10px);
        }

        .form-control {
            border-radius: 10px;
            padding: 10px;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #6c63ff;
        }

        .btn-custom {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border: none;
            border-radius: 10px;
            padding: 10px;
            font-weight: 500;
            transition: 0.3s;
        }

        .btn-custom:hover {
            opacity: 0.9;
        }

        .title {
            font-weight: 600;
            color: #333;
        }

        .card-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            padding: 30px;
        }

        a {
            color: #6c63ff;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body class="d-flex align-items-center justify-content-center min-vh-100">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">

                <div class="card-container shadow-lg">

                    <h3 class="text-center mb-4 title">
                        Create Account
                    </h3>

                    <% String error = (String) request.getAttribute("errorMessage"); %>
                    <% if (error != null) { %>
                        <div class="alert alert-danger text-center">
                            <%= error %>
                        </div>
                    <% } %>

                    <form action="RegisterServlet" method="POST">

                        <div class="mb-3">
                            <label class="form-label fw-medium">Username</label>
                            <input type="text" name="username" class="form-control" placeholder="Enter username" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-medium">Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                        </div>

                        <button type="submit" class="btn btn-custom w-100 text-white">
                            Create Account
                        </button>

                    </form>

                    <div class="text-center mt-4">
                        <small>
                            Already have an account?
                            <a href="login.jsp">Login</a>
                        </small>
                    </div>

                </div>

            </div>
        </div>
    </div>

</body>
</html>