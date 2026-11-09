<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCompanies.aspx.cs" Inherits="DataBase.Admin.ManageCompanies" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Manage Companies - MobileHub Admin</title>
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
                    <a href="ManageCompanies.aspx" class="mh-nav-link active"><i class="fa-solid fa-building"></i> Companies</a>
                    <a href="ManageProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Products</a>
                    <a href="ManageEmployees.aspx" class="mh-nav-link"><i class="fa-solid fa-users"></i> Employees</a>
                    <a href="ManageOrders.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Orders</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div style="text-align: right; margin-bottom: 10px;">
                <asp:Label ID="lblWelcome" runat="server" CssClass="mh-alert-info"></asp:Label>
            </div>

            <h1 class="mh-page-title"><i class="fa-solid fa-building"></i> Manage Companies</h1>
            <p class="mh-subtitle">Edit or Delete company records</p>

            <div class="mh-card">
                <div style="margin-bottom:14px;">
                    <asp:Button ID="btnCompPDF" runat="server" Text="📥 Download Companies PDF"
                        CssClass="asp-button" OnClick="btnCompPDF_Click" />
                </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="Comp_Id"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowUpdating="GridView1_RowUpdating"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowDeleting="GridView1_RowDeleting"
                    CssClass="mh-gridview">
                    <Columns>
                        <asp:BoundField DataField="Comp_Id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Comp_Name" HeaderText="Company Name" />
                        <asp:BoundField DataField="Comp_Owner_Name" HeaderText="Owner Name" />
                        <asp:BoundField DataField="Comp_Email" HeaderText="Email" />
                        <asp:BoundField DataField="Comp_address" HeaderText="Address" />
                        <asp:BoundField DataField="Comp_Cover_img" HeaderText="Image Path" ReadOnly="True" />
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
