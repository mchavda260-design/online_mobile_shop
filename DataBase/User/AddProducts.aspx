<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddProducts.aspx.cs" Inherits="DataBase.User.AddProducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Add Product - MobileHub</title>
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
                    <a href="AddCompany.aspx" class="mh-nav-link"><i class="fa-solid fa-building-circle-plus"></i> Add Company</a>
                    <a href="AddProducts.aspx" class="mh-nav-link active"><i class="fa-solid fa-box-archive"></i> Add Products</a>
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

                <h1 class="mh-page-title">Add New Product</h1>
                <p class="mh-subtitle">Add a mobile product to the store inventory</p>

                <table class="form-table">
                    <tr>
                        <td>Select Company:</td>
                        <td>
                            <asp:DropDownList ID="drpcid" runat="server">
                                <asp:ListItem Text="-- Select Company --" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Product Name:</td>
                        <td>
                            <asp:TextBox ID="pnm" runat="server" Placeholder="e.g. iPhone 15 Pro"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Product Model:</td>
                        <td>
                            <asp:TextBox ID="pmdl" runat="server" Placeholder="e.g. A3106"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Description:</td>
                        <td>
                            <asp:TextBox ID="pdecs" runat="server" TextMode="MultiLine" Rows="3" Placeholder="Product features & summary"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Weight:</td>
                        <td>
                            <asp:TextBox ID="twgt" runat="server" Placeholder="e.g. 187g"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Configuration:</td>
                        <td>
                            <asp:TextBox ID="pconfi" runat="server" Placeholder="e.g. 8GB RAM, 256GB Storage"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Price (&#8377;):</td>
                        <td>
                            <asp:TextBox ID="pprice" runat="server" Placeholder="e.g. 129999"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Product Image:</td>
                        <td>
                            <asp:FileUpload ID="fuProductImage" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-top: 15px;">
                            <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" OnClick="btnAddProduct_Click" CssClass="asp-button" />
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
