<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCompany.aspx.cs" Inherits="DataBase.User.AddCompany" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Add Company - MobileHub</title>
    <link href="../style.css/StyleSheet1.css" rel="stylesheet" type="text/css" />
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
                    <a href="AddCompany.aspx" class="mh-nav-link active"><i class="fa-solid fa-building-circle-plus"></i> Add Company</a>
                    <a href="AddProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-box-archive"></i> Add Products</a>
                    <a href="ShowCompany.aspx" class="mh-nav-link"><i class="fa-solid fa-store"></i> Show Companies</a>
                    <a href="ShowProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Show Products</a>
                    <a href="addtocart.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div class="mh-form-card">
                <div style="text-align: right; margin-bottom: 10px;">
                    <asp:Label ID="Label1" runat="server" CssClass="mh-alert-info"></asp:Label>
                </div>

                <h1 class="mh-page-title">Add Company</h1>
                <p class="mh-subtitle">Register a new mobile brand/company</p>

                <table class="form-table">
                    <tr>
                        <td>Company Name:</td>
                        <td>
                            <asp:TextBox ID="txtnm" runat="server" Placeholder="Enter Company Name"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Owner Name:</td>
                        <td>
                            <asp:TextBox ID="txtonm" runat="server" Placeholder="Enter Owner Name"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Company Email:</td>
                        <td>
                            <asp:TextBox ID="txteml" runat="server" TextMode="Email" Placeholder="Enter Email Address"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Company Address:</td>
                        <td>
                            <asp:TextBox ID="txtadd" runat="server" TextMode="MultiLine" Rows="4" Placeholder="Enter Address"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Cover Image:</td>
                        <td>
                            <asp:FileUpload ID="fimg" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-top: 15px;">
                            <asp:Button ID="btnAddCompany" runat="server" Text="Add Company" OnClick="btnAddCompany_Click" CssClass="asp-button" />
                        </td>
                    </tr>
                </table>
            </div>
        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Store. All rights reserved.
        </footer>
    </form>
</body>
</html>
