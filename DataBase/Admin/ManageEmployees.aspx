<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageEmployees.aspx.cs" Inherits="DataBase.Admin.ManageEmployees" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Manage Employees - MobileHub Admin</title>
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
                    <a href="AdminDashboard.aspx" class="mh-nav-link"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                    <a href="ManageCompanies.aspx" class="mh-nav-link"><i class="fa-solid fa-building"></i> Companies</a>
                    <a href="ManageProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Products</a>
                    <a href="ManageEmployees.aspx" class="mh-nav-link active"><i class="fa-solid fa-users"></i> Employees</a>
                    <a href="ManageOrders.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Orders</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div style="text-align: right; margin-bottom: 10px;">
                <asp:Label ID="lblWelcome" runat="server" CssClass="mh-alert-info"></asp:Label>
            </div>

            <h1 class="mh-page-title"><i class="fa-solid fa-users"></i> Manage Employees</h1>
            <p class="mh-subtitle">Add, Edit or Delete employee records</p>

            <%-- Add Employee Form --%>
            <div class="mh-card" style="margin-bottom: 30px;">
                <h2 style="font-size: 20px; font-weight: 700; color: #0f172a; margin-bottom: 18px;">Add New Employee</h2>
                <div style="display: flex; gap: 16px; flex-wrap: wrap;">
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="mh-input" placeholder="Employee Name"></asp:TextBox>
                    </div>
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="mh-input" placeholder="Email"></asp:TextBox>
                    </div>
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="mh-input" TextMode="Password" placeholder="Password"></asp:TextBox>
                    </div>
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Phone</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="mh-input" placeholder="Phone"></asp:TextBox>
                    </div>
                    <div style="display: flex; align-items: flex-end;">
                        <asp:Button ID="btnAdd" runat="server" Text="Add Employee" CssClass="asp-button" OnClick="btnAdd_Click" />
                    </div>
                </div>
            </div>

            <%-- Employee Grid --%>
            <div class="mh-card">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="Emp_Id"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowUpdating="GridView1_RowUpdating"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowDeleting="GridView1_RowDeleting"
                    CssClass="mh-gridview">
                    <Columns>
                        <asp:BoundField DataField="Emp_Id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Password" HeaderText="Password" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" />
                        <asp:CommandField HeaderText="Edit" ShowEditButton="True" ItemStyle-CssClass="action-link" ControlStyle-CssClass="action-link" />
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
