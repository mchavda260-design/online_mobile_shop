<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DataBase.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - MobileHub</title>
    <link href="style.css/StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <style>
        /* ── Same Light Aurora as all other pages ── */
        body {
            background: #f3f0ff;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Soft aurora blobs (light version) */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background:
                radial-gradient(ellipse 80% 60% at 20% 30%, rgba(120,40,200,0.12) 0%, transparent 60%),
                radial-gradient(ellipse 70% 50% at 80% 70%, rgba(0,180,255,0.10) 0%, transparent 55%),
                radial-gradient(ellipse 60% 70% at 50% 10%, rgba(236,72,153,0.08) 0%, transparent 50%),
                radial-gradient(ellipse 90% 40% at 10% 90%, rgba(0,200,150,0.07) 0%, transparent 55%);
            animation: auroraShiftLogin 12s ease-in-out infinite alternate;
            z-index: 0;
            pointer-events: none;
        }
        @keyframes auroraShiftLogin {
            0%   { filter: hue-rotate(0deg) brightness(1); }
            50%  { filter: hue-rotate(20deg) brightness(1.05); }
            100% { filter: hue-rotate(-15deg) brightness(0.97); }
        }

        /* Subtle purple shimmer dots */
        body::after {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                radial-gradient(1px 1px at 10% 15%, rgba(124,58,237,0.25) 0%, transparent 100%),
                radial-gradient(1px 1px at 25% 40%, rgba(139,92,246,0.20) 0%, transparent 100%),
                radial-gradient(1.5px 1.5px at 40% 8%, rgba(167,139,250,0.30) 0%, transparent 100%),
                radial-gradient(1px 1px at 55% 60%, rgba(124,58,237,0.15) 0%, transparent 100%),
                radial-gradient(1px 1px at 70% 25%, rgba(139,92,246,0.20) 0%, transparent 100%),
                radial-gradient(2px 2px at 80% 5%,  rgba(167,139,250,0.28) 0%, transparent 100%),
                radial-gradient(1px 1px at 90% 50%, rgba(124,58,237,0.18) 0%, transparent 100%),
                radial-gradient(1px 1px at 15% 75%, rgba(196,181,253,0.20) 0%, transparent 100%),
                radial-gradient(1.5px 1.5px at 60% 85%, rgba(167,139,250,0.22) 0%, transparent 100%),
                radial-gradient(1px 1px at 35% 90%, rgba(139,92,246,0.18) 0%, transparent 100%),
                radial-gradient(1px 1px at 5%  50%, rgba(124,58,237,0.12) 0%, transparent 100%),
                radial-gradient(2px 2px at 95% 80%, rgba(196,181,253,0.25) 0%, transparent 100%);
            animation: twinkleLogin 6s ease-in-out infinite alternate;
            z-index: 0;
            pointer-events: none;
        }
        @keyframes twinkleLogin {
            0%   { opacity: 0.4; }
            50%  { opacity: 0.9; }
            100% { opacity: 0.5; }
        }

        /* ── Container (center the card) ── */
        .mh-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 130px);
            padding: 32px 24px;
            position: relative;
            z-index: 10;
        }

        /* ── Login Card (white on light bg) ── */
        .mh-form-card {
            width: 100%;
            max-width: 470px;
            margin: 0;
            background: #ffffff;
            border: 1px solid #e0d9f5;
            border-radius: 28px;
            padding: 48px 44px;
            box-shadow:
                0 0 0 1px rgba(167,139,250,0.12),
                0 20px 60px rgba(124,58,237,0.14),
                inset 0 1px 0 rgba(255,255,255,0.90);
            position: relative;
            overflow: hidden;
        }

        /* Shimmer top border */
        .mh-form-card::before {
            content: '';
            position: absolute;
            top: 0; left: -100%; right: 0;
            height: 3px;
            background: linear-gradient(90deg,
                transparent,
                rgba(124,58,237,0.7),
                rgba(59,130,246,0.8),
                rgba(236,72,153,0.7),
                rgba(0,200,150,0.6),
                transparent);
            background-size: 300% 100%;
            animation: shimmerBorderLogin 3s linear infinite;
        }
        @keyframes shimmerBorderLogin {
            0%   { background-position: 200% 0; left: -100%; }
            100% { background-position: -200% 0; left: 100%; }
        }

        /* Inner top glow */
        .mh-form-card::after {
            content: '';
            position: absolute;
            top: -60px; left: 50%; transform: translateX(-50%);
            width: 220px; height: 220px;
            background: radial-gradient(circle, rgba(139,92,246,0.10) 0%, transparent 70%);
            pointer-events: none;
        }

        /* ── Page Title (dark on light bg) ── */
        .mh-form-card .mh-page-title {
            font-size: 27px;
            color: #0f172a !important;
            text-shadow: none;
        }
        .mh-form-card .mh-subtitle {
            color: #7c6fa5 !important;
        }

        /* ── Login Icon ── */
        .login-icon-wrap {
            width: 76px; height: 76px;
            background: linear-gradient(135deg, #7c3aed, #06b6d4, #ec4899);
            background-size: 200% 200%;
            animation: iconGlowLogin 4s ease infinite alternate;
            border-radius: 22px;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 24px;
            box-shadow:
                0 0 0 4px rgba(139,92,246,0.15),
                0 12px 36px rgba(124,58,237,0.30),
                0 0 40px rgba(6,182,212,0.15);
        }
        @keyframes iconGlowLogin {
            0%   { background-position: 0% 50%;   box-shadow: 0 0 0 4px rgba(139,92,246,0.18), 0 12px 36px rgba(124,58,237,0.30), 0 0 40px rgba(6,182,212,0.15); }
            50%  { background-position: 100% 50%;  box-shadow: 0 0 0 4px rgba(6,182,212,0.22),  0 12px 36px rgba(6,182,212,0.28),  0 0 40px rgba(236,72,153,0.18); }
            100% { background-position: 0% 50%;   box-shadow: 0 0 0 4px rgba(236,72,153,0.18), 0 12px 36px rgba(236,72,153,0.28), 0 0 40px rgba(139,92,246,0.18); }
        }
        .login-icon-wrap i { font-size: 32px; color: #fff; }

        /* ── Form labels ── */
        .form-table td:first-child {
            color: #475569;
            font-size: 13.5px;
            font-weight: 700;
            width: 115px;
            white-space: nowrap;
        }
        .form-table td:first-child i { margin-right: 6px; color: #7c3aed; }

        /* ── Inputs (light style) ── */
        .mh-form-card input[type="text"],
        .mh-form-card input[type="password"],
        .mh-form-card span input {
            background: #f8f5ff !important;
            border: 1.5px solid #d8cef0 !important;
            color: #0f172a !important;
            border-radius: 12px !important;
            transition: all 0.3s ease !important;
        }
        .mh-form-card input[type="text"]:focus,
        .mh-form-card input[type="password"]:focus,
        .mh-form-card span input:focus {
            border-color: #7c3aed !important;
            background: #ffffff !important;
            box-shadow: 0 0 0 4px rgba(124,58,237,0.12) !important;
        }
        .mh-form-card input::placeholder { color: #a78bfa !important; }

        /* ── Button ── */
        .mh-form-card input[type="submit"],
        .mh-form-card .asp-button {
            background: linear-gradient(135deg, #7c3aed, #06b6d4) !important;
            background-size: 200% 100% !important;
            box-shadow: 0 6px 20px rgba(124,58,237,0.35) !important;
            animation: btnPulseLogin 3s ease-in-out infinite;
            border-radius: 14px !important;
            font-size: 15px !important;
            letter-spacing: 0.5px;
        }
        @keyframes btnPulseLogin {
            0%, 100% { box-shadow: 0 6px 20px rgba(124,58,237,0.35); }
            50%       { box-shadow: 0 8px 28px rgba(124,58,237,0.50), 0 0 40px rgba(6,182,212,0.20); }
        }
        .mh-form-card input[type="submit"]:hover,
        .mh-form-card .asp-button:hover {
            transform: translateY(-3px) scale(1.02) !important;
            box-shadow: 0 12px 36px rgba(124,58,237,0.45) !important;
        }

        /* ── Register link ── */
        .register-link {
            display: block; text-align: center; margin-top: 22px;
            font-size: 14px; color: #7c6fa5; font-weight: 500;
        }
        .register-link a {
            color: #7c3aed;
            font-weight: 700;
            transition: all 0.3s;
        }
        .register-link a:hover {
            color: #6d28d9;
            text-decoration: underline;
        }

        /* ── Error box ── */
        .error-box {
            background: rgba(239,68,68,0.10);
            border: 1px solid rgba(239,68,68,0.30);
            border-radius: 10px; padding: 10px 16px;
            color: #dc2626; font-size: 14px; font-weight: 600;
            text-align: center;
        }

        /* ── Footer ── */
        .mh-footer {
            position: relative; z-index: 10;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="mh-header">
            <nav class="mh-navbar">
                <a href="Login.aspx" class="mh-logo">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                    <span>Mobile</span>Hub
                </a>
                <div class="mh-nav-menu">
                    <a href="Login.aspx" class="mh-nav-link active"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
                    <a href="WebForm1.aspx" class="mh-nav-link"><i class="fa-solid fa-user-plus"></i> Register</a>
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div class="mh-form-card">
                <div class="login-icon-wrap">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                </div>
                <h1 class="mh-page-title">Welcome Back!</h1>
                <p class="mh-subtitle">Login to your MobileHub account</p>

                <table class="form-table" style="margin-bottom: 8px;">
                    <tr>
                        <td><i class="fa-solid fa-user"></i> Username:</td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" Placeholder="Enter your username"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fa-solid fa-lock"></i> Password:</td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" Placeholder="Enter your password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-top: 18px;">
                            <asp:Button ID="Button1" runat="server" Text="🔑  Login Now" OnClick="Button1_Click" CssClass="asp-button" style="width:100%; font-size:15px;" />
                        </td>
                    </tr>
                </table>

                <asp:Label ID="Label6" runat="server" CssClass="error-box" style="display:none; margin-top:10px;"></asp:Label>

                <span class="register-link">
                    Don't have an account? <a href="WebForm1.aspx">Register here</a>
                </span>
            </div>
        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Store. All rights reserved.
        </footer>
    </form>
    <script>
        // Show error box only if it has text
        var errLabel = document.querySelector('.error-box');
        if (errLabel && errLabel.innerText.trim() !== '') {
            errLabel.style.display = 'block';
        }
    </script>
</body>
</html>
