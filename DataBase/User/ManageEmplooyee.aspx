<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageEmplooyee.aspx.cs" Inherits="DataBase.Admin.ManageEmployees" %>

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
                    <a href="admindashbord.aspx" class="mh-nav-link"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                    <a href="Managecompanies.aspx" class="mh-nav-link"><i class="fa-solid fa-building"></i> Companies</a>
                    <a href="Manageproduct.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Products</a>
                    <a href="ManageEmplooyee.aspx" class="mh-nav-link active"><i class="fa-solid fa-users"></i> Employees</a>
                    <a href="Manageorder.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Orders</a>
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

            <%-- Message Label --%>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Green" Style="font-size:15px; font-weight:600;"></asp:Label>

            <%-- Add Employee Form --%>
            <div class="mh-card" style="margin-bottom: 30px;">
                <h2 style="font-size: 20px; font-weight: 700; color: #0f172a; margin-bottom: 18px;">Add New Employee</h2>
                <div style="display: flex; gap: 16px; flex-wrap: wrap;">
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="mh-input" placeholder="Employee Name"></asp:TextBox>
                    </div>
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Gender</label>
                        <asp:TextBox ID="txtGender" runat="server" CssClass="mh-input" placeholder="Gender"></asp:TextBox>
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
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Mobile</label>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="mh-input" placeholder="Mobile"></asp:TextBox>
                    </div>
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">City</label>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="mh-input" placeholder="City"></asp:TextBox>
                    </div>
                    <div>
                        <label style="display: block; font-weight: 600; margin-bottom: 6px; color: #374151;">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="mh-input" placeholder="Address"></asp:TextBox>
                    </div>
                    <div style="display: flex; align-items: flex-end;">
                        <asp:Button ID="btnAdd" runat="server" Text="Add Employee" CssClass="asp-button" OnClick="btnAdd_Click" />
                    </div>
                </div>
            </div>

            <%-- Employee Grid --%>
            <div class="mh-card">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="Id"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowUpdating="GridView1_RowUpdating"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowDeleting="GridView1_RowDeleting"
                    CssClass="mh-gridview">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                        <asp:BoundField DataField="City" HeaderText="City" />
                        <asp:BoundField DataField="Address" HeaderText="Address" />
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
