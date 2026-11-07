<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admindashbord.aspx.cs" Inherits="DataBase.Admin.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Admin Dashboard - MobileHub</title>
    <link href="../style.css/StyleSheet1.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <header class="mh-header">
            <nav class="mh-navbar">
                <a href="../Login.aspx" class="mh-logo">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                    <span>Mobile</span>Hub Admin
                </a>
                <div class="mh-nav-menu">
                    <a href="admindashbord.aspx" class="mh-nav-link active"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                    <a href="ManageCompanies.aspx" class="mh-nav-link"><i class="fa-solid fa-building"></i> Companies</a>
                    <a href="Manageproduct.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Products</a>
                    <a href="ManageEmplooyee.aspx" class="mh-nav-link"><i class="fa-solid fa-users"></i> Employees</a>
                    <a href="Manageorder.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Orders</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div style="text-align: right; margin-bottom: 10px;">
                <asp:Label ID="lblWelcome" runat="server" CssClass="mh-alert-info"></asp:Label>
            </div>

            <h1 class="mh-page-title"><i class="fa-solid fa-gauge"></i> Admin Dashboard</h1>
            <p class="mh-subtitle">Overview of your MobileHub system</p>

            <div style="display: flex; gap: 24px; flex-wrap: wrap; justify-content: center; margin-top: 30px;">

                <div class="mh-card" style="min-width: 200px; text-align: center; padding: 30px 40px;">
                    <i class="fa-solid fa-building" style="font-size: 36px; color: #2563eb;"></i>
                    <h2 style="font-size: 42px; font-weight: 800; color: #0f172a; margin: 10px 0 4px 0;">
                        <asp:Label ID="lblCompanyCount" runat="server" Text="0"></asp:Label>
                    </h2>
                    <p style="color: #64748b; font-size: 16px; margin: 0;">Companies</p>
                    <a href="ManageCompanies.aspx" class="action-link" style="display: inline-block; margin-top: 14px; padding: 8px 18px;">Manage</a>
                </div>

                <div class="mh-card" style="min-width: 200px; text-align: center; padding: 30px 40px;">
                    <i class="fa-solid fa-mobile" style="font-size: 36px; color: #16a34a;"></i>
                    <h2 style="font-size: 42px; font-weight: 800; color: #0f172a; margin: 10px 0 4px 0;">
                        <asp:Label ID="lblProductCount" runat="server" Text="0"></asp:Label>
                    </h2>
                    <p style="color: #64748b; font-size: 16px; margin: 0;">Products</p>
                    <a href="Manageproduct.aspx" class="action-link" style="display: inline-block; margin-top: 14px; padding: 8px 18px;">Manage</a>
                </div>

                <div class="mh-card" style="min-width: 200px; text-align: center; padding: 30px 40px;">
                    <i class="fa-solid fa-users" style="font-size: 36px; color: #7c3aed;"></i>
                    <h2 style="font-size: 42px; font-weight: 800; color: #0f172a; margin: 10px 0 4px 0;">
                        <asp:Label ID="lblEmployeeCount" runat="server" Text="0"></asp:Label>
                    </h2>
                    <p style="color: #64748b; font-size: 16px; margin: 0;">Employees</p>
                    <a href="ManageEmplooyee.aspx" class="action-link" style="display: inline-block; margin-top: 14px; padding: 8px 18px;">Manage</a>
                </div>

                <div class="mh-card" style="min-width: 200px; text-align: center; padding: 30px 40px;">
                    <i class="fa-solid fa-cart-shopping" style="font-size: 36px; color: #dc2626;"></i>
                    <h2 style="font-size: 42px; font-weight: 800; color: #0f172a; margin: 10px 0 4px 0;">
                        <asp:Label ID="lblOrderCount" runat="server" Text="0"></asp:Label>
                    </h2>
                    <p style="color: #64748b; font-size: 16px; margin: 0;">Orders</p>
                    <a href="Manageorder.aspx" class="action-link" style="display: inline-block; margin-top: 14px; padding: 8px 18px;">Manage</a>
                </div>

            </div>
        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Admin Panel. All rights reserved.
        </footer>
    </form>
</body>
</html>

