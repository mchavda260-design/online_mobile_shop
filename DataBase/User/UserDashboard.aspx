<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="DataBase.User.UserDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Dashboard - MobileHub</title>
    <link href="../style.css/StyleSheet1.css" rel="stylesheet" type="text/css" />
    <style>
        .dash-grid {
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 30px;
        }
        /* Soft glass card on light bg */
        .dash-card {
            background: #ffffff;
            border: 1px solid #e0d9f5;
            border-radius: 18px;
            box-shadow: 0 4px 20px rgba(124,58,237,0.10);
            padding: 32px 40px;
            min-width: 200px;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
            position: relative;
            z-index: 10;
        }
        .dash-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 36px rgba(124,58,237,0.18);
            border-color: #c4b5fd;
        }
        .dash-card i {
            font-size: 38px;
            margin-bottom: 12px;
        }
        .dash-count {
            font-size: 46px;
            font-weight: 900;
            color: #0f172a;
            margin: 8px 0 4px 0;
            line-height: 1;
        }
        .dash-label {
            color: #7c6fa5;
            font-size: 16px;
            margin: 0 0 16px 0;
        }
        .quick-links {
            display: flex;
            gap: 18px;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 40px;
        }
        .quick-link-card {
            background: #ffffff;
            border: 1.5px solid #e0d9f5;
            border-radius: 14px;
            box-shadow: 0 2px 12px rgba(124,58,237,0.08);
            padding: 24px 30px;
            min-width: 170px;
            text-align: center;
            text-decoration: none;
            color: #0f172a;
            transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
            position: relative;
            z-index: 10;
        }
        .quick-link-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(124,58,237,0.18);
            border-color: #a78bfa;
            text-decoration: none;
            color: #7c3aed;
        }
        .quick-link-card i {
            font-size: 30px;
            margin-bottom: 10px;
            display: block;
        }
        .quick-link-card span {
            font-size: 15px;
            font-weight: 600;
        }
        .welcome-bar {
            background: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%);
            color: #fff;
            border-radius: 16px;
            padding: 28px 36px;
            margin-top: 20px;
            display: flex;
            align-items: center;
            gap: 18px;
            flex-wrap: wrap;
            box-shadow: 0 8px 32px rgba(124,58,237,0.25);
            position: relative;
            z-index: 10;
        }
        .welcome-bar i {
            font-size: 42px;
            opacity: 0.9;
        }
        .welcome-bar h2 {
            font-size: 24px;
            font-weight: 800;
            margin: 0 0 4px 0;
        }
        .welcome-bar p {
            font-size: 15px;
            margin: 0;
            opacity: 0.85;
        }
        .section-title {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            margin: 40px 0 0 0;
            text-align: center;
        }
        .section-sub {
            color: #7c6fa5;
            font-size: 14px;
            text-align: center;
            margin: 4px 0 0 0;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <header class="mh-header">
            <nav class="mh-navbar">
                <a href="../Login.aspx" class="mh-logo">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                    <span>Mobile</span>Hub
                </a>
                <div class="mh-nav-menu">
                    <a href="UserDashboard.aspx" class="mh-nav-link active"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                    <a href="AddCompany.aspx" class="mh-nav-link"><i class="fa-solid fa-building-circle-plus"></i> Add Company</a>
                    <a href="AddProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-box-archive"></i> Add Products</a>
                    <a href="ShowCompany.aspx" class="mh-nav-link"><i class="fa-solid fa-store"></i> Show Companies</a>
                    <a href="ShowProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Show Products</a>
                    <a href="addtocart.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <main class="mh-container">

            <%-- Welcome Bar --%>
            <div class="welcome-bar">
                <i class="fa-solid fa-user-tie"></i>
                <div>
                    <h2>
                        <asp:Label ID="lblWelcome" runat="server" Text="Welcome!"></asp:Label>
                    </h2>
                    <p>MobileHub Store Dashboard - Manage your companies, products and orders</p>
                </div>
            </div>

            <%-- Stats Cards --%>
            <h3 class="section-title"><i class="fa-solid fa-chart-bar"></i> Store Overview</h3>
            <p class="section-sub">Live counts from your database</p>

            <div class="dash-grid">

                <div class="dash-card">
                    <i class="fa-solid fa-building" style="color: #2563eb;"></i>
                    <div class="dash-count">
                        <asp:Label ID="lblCompanyCount" runat="server" Text="0"></asp:Label>
                    </div>
                    <p class="dash-label">Companies</p>
                    <a href="ShowCompany.aspx" class="action-link" style="padding: 8px 18px; display: inline-block;">View All</a>
                </div>

                <div class="dash-card">
                    <i class="fa-solid fa-mobile-screen-button" style="color: #16a34a;"></i>
                    <div class="dash-count">
                        <asp:Label ID="lblProductCount" runat="server" Text="0"></asp:Label>
                    </div>
                    <p class="dash-label">Products</p>
                    <a href="ShowProducts.aspx" class="action-link" style="padding: 8px 18px; display: inline-block;">View All</a>
                </div>

                <div class="dash-card">
                    <i class="fa-solid fa-cart-shopping" style="color: #dc2626;"></i>
                    <div class="dash-count">
                        <asp:Label ID="lblCartCount" runat="server" Text="0"></asp:Label>
                    </div>
                    <p class="dash-label">Cart Items</p>
                    <a href="addtocart.aspx" class="action-link" style="padding: 8px 18px; display: inline-block;">View Cart</a>
                </div>

                <div class="dash-card">
                    <i class="fa-solid fa-users" style="color: #7c3aed;"></i>
                    <div class="dash-count">
                        <asp:Label ID="lblEmployeeCount" runat="server" Text="0"></asp:Label>
                    </div>
                    <p class="dash-label">Employees</p>
                    <a href="ManageEmplooyee.aspx" class="action-link" style="padding: 8px 18px; display: inline-block;">Manage</a>
                </div>

            </div>

            <%-- Quick Links --%>
            <h3 class="section-title"><i class="fa-solid fa-bolt"></i> Quick Actions</h3>
            <p class="section-sub">Quickly navigate to key pages</p>

            <div class="quick-links">
                <a href="AddCompany.aspx" class="quick-link-card">
                    <i class="fa-solid fa-building-circle-plus" style="color: #2563eb;"></i>
                    <span>Add Company</span>
                </a>
                <a href="AddProducts.aspx" class="quick-link-card">
                    <i class="fa-solid fa-box-archive" style="color: #16a34a;"></i>
                    <span>Add Product</span>
                </a>
                <a href="ShowCompany.aspx" class="quick-link-card">
                    <i class="fa-solid fa-store" style="color: #0891b2;"></i>
                    <span>Show Companies</span>
                </a>
                <a href="ShowProducts.aspx" class="quick-link-card">
                    <i class="fa-solid fa-mobile" style="color: #7c3aed;"></i>
                    <span>Show Products</span>
                </a>
                <a href="Managecompanies.aspx" class="quick-link-card">
                    <i class="fa-solid fa-pen-to-square" style="color: #ea580c;"></i>
                    <span>Manage Companies</span>
                </a>
                <a href="Manageproduct.aspx" class="quick-link-card">
                    <i class="fa-solid fa-sliders" style="color: #dc2626;"></i>
                    <span>Manage Products</span>
                </a>
                <a href="Manageorder.aspx" class="quick-link-card">
                    <i class="fa-solid fa-receipt" style="color: #0f172a;"></i>
                    <span>Manage Orders</span>
                </a>
                <a href="addtocart.aspx" class="quick-link-card">
                    <i class="fa-solid fa-cart-shopping" style="color: #16a34a;"></i>
                    <span>My Cart</span>
                </a>
            </div>

        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Store. All rights reserved.
        </footer>
    </form>
</body>
</html>
