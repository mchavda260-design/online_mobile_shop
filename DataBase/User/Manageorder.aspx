<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manageorder.aspx.cs" Inherits="DataBase.Admin.ManageOrders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Manage Orders - MobileHub Admin</title>
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
                    <a href="ManageEmplooyee.aspx" class="mh-nav-link"><i class="fa-solid fa-users"></i> Employees</a>
                    <a href="Manageorder.aspx" class="mh-nav-link active"><i class="fa-solid fa-cart-shopping"></i> Orders</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div style="text-align: right; margin-bottom: 10px;">
                <asp:Label ID="lblWelcome" runat="server" CssClass="mh-alert-info"></asp:Label>
            </div>

            <h1 class="mh-page-title"><i class="fa-solid fa-cart-shopping"></i> Manage Orders</h1>
            <p class="mh-subtitle">View and manage all customer orders</p>

            <div class="mh-card">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="Order_Id"
                    OnRowDeleting="GridView1_RowDeleting"
                    CssClass="mh-gridview">
                    <Columns>
                        <asp:BoundField DataField="Order_Id"    HeaderText="Order ID"        ReadOnly="True" />
                        <asp:BoundField DataField="User_Name"   HeaderText="User Name"       ReadOnly="True" />
                        <asp:BoundField DataField="Prod_Name"   HeaderText="Product Name"    ReadOnly="True" />
                        <asp:BoundField DataField="Quantity"    HeaderText="Quantity"        ReadOnly="True" />
                        <asp:BoundField DataField="Order_Date"  HeaderText="Order Date"      ReadOnly="True" DataFormatString="{0:dd MMM yyyy}" />
                        <asp:BoundField DataField="Pay_Method"  HeaderText="Payment Method"  ReadOnly="True" />
                        <asp:BoundField DataField="Pay_Status"  HeaderText="Payment Status"  ReadOnly="True" />
                        <asp:BoundField DataField="Ship_Address" HeaderText="Address"        ReadOnly="True" />
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

