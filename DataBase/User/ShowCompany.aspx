<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowCompany.aspx.cs" Inherits="DataBase.User.ShowCompany" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Mobile Brands &amp; Companies - MobileHub</title>
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
                    <a href="AddProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-box-archive"></i> Add Products</a>
                    <a href="ShowCompany.aspx" class="mh-nav-link active"><i class="fa-solid fa-store"></i> Show Companies</a>
                    <a href="ShowProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Show Products</a>
                    <a href="addtocart.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <h1 class="mh-page-title">Mobile Companies</h1>
            <p class="mh-subtitle">Select a brand to view available smartphones and accessories</p>

            <div style="display: flex; justify-content: center; width: 100%;">
                <asp:DataList ID="DataList1" runat="server" OnSelectedIndexChanged="DataList1_SelectedIndexChanged" RepeatDirection="Horizontal" RepeatColumns="3" OnItemCommand="DataList1_ItemCommand1" CssClass="mh-datalist-table">
                    <ItemTemplate>
                        <div class="mh-item-card" style="width: 260px; margin: 10px;">
                            <a href='ShowProducts.aspx?cid=<%# Eval("Comp_Id") %>' style="display: block; text-align: center;">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Comp_Cover_img") %>' style="max-width: 140px; max-height: 140px; object-fit: contain; border-radius: 12px; margin-bottom: 14px;" />
                            </a>
                            <a href='ShowProducts.aspx?cid=<%# Eval("Comp_Id") %>' class="item-title" style="font-size: 18px; font-weight: 700; color: #0f172a; text-decoration: none;">
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Comp_Name") %>'></asp:Label>
                            </a>
                            <div style="margin-top: 14px;">
                                <a href='ShowProducts.aspx?cid=<%# Eval("Comp_Id") %>' class="action-link" style="padding: 8px 18px; font-size: 14px;">
                                    View Products <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Store. All rights reserved.
        </footer>
    </form>
</body>
</html>
