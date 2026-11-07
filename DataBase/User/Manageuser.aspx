<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="DataBase.Admin.ManageUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Manage Users - MobileHub Admin</title>
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
                    <a href="admindashbord.aspx" class="mh-nav-link"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                    <a href="ManageCompanies.aspx" class="mh-nav-link"><i class="fa-solid fa-building"></i> Companies</a>
                    <a href="Manageproduct.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Products</a>
                    <a href="ManageEmplooyee.aspx" class="mh-nav-link active"><i class="fa-solid fa-users"></i> Employees / Users</a>
                    <a href="Manageorder.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Orders</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div style="text-align: right; margin-bottom: 10px;">
                <asp:Label ID="lblWelcome" runat="server" CssClass="mh-alert-info"></asp:Label>
            </div>

            <h1 class="mh-page-title"><i class="fa-solid fa-user-group"></i> Manage Users</h1>
            <p class="mh-subtitle">View and delete registered user accounts</p>

            <div class="mh-card">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="Emp_Id"
                    OnRowDeleting="GridView1_RowDeleting"
                    CssClass="mh-gridview">
                    <Columns>
                        <asp:BoundField DataField="Emp_Id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" />
                        <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" ReadOnly="True" />
                        <asp:CommandField HeaderText="Delete" ShowDeleteButton="True" ItemStyle-CssClass="action-link" ControlStyle-CssClass="action-link" />
                    </Columns>
                </asp:GridView>
            </div>
        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Admin Panel. All rights reserved.
        </footer>
    </form>
</body>
</html>

