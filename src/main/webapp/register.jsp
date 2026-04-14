<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Java Chat App</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <link rel="stylesheet" href="css/style.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
</head>

<body class="bg-light d-flex align-items-center min-vh-100">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">

                <div class="card shadow-sm border-0 p-4">

                    <h3 class="text-center mb-4 fw-semibold">
                        Create Account
                    </h3>

                    <!-- Error Message -->
                    <% String error = (String) request.getAttribute("errorMessage"); %>
                    <% if (error != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= error %>
                        </div>
                    <% } %>

                    <!-- Register Form -->
                    <form action="RegisterServlet" method="POST" novalidate>

                        <div class="mb-3">
                            <label for="username" class="form-label fw-medium">
                                Username
                            </label>
                            <input 
                                type="text"
                                id="username"
                                name="username"
                                class="form-control"
                                placeholder="Choose a username"
                                autocomplete="username"
                                required
                            >
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label fw-medium">
                                Password
                            </label>
                            <input 
                                type="password"
                                id="password"
                                name="password"
                                class="form-control"
                                placeholder="Create a password"
                                autocomplete="new-password"
                                required
                            >
                        </div>

                        <button type="submit" class="btn btn-success w-100">
                            Register
                        </button>

                    </form>

                    <!-- Login Redirect -->
                    <div class="text-center mt-3">
                        <small>
                            Already have an account?
                            <a href="login.jsp" class="text-decoration-none">
                                Login here
                            </a>
                        </small>
                    </div>

                </div>

            </div>
        </div>
    </div>

</body>
</html>