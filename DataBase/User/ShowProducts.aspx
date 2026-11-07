<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowProducts.aspx.cs" Inherits="DataBase.User.ShowProducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Mobile Products - MobileHub</title>
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
                    <a href="ShowCompany.aspx" class="mh-nav-link"><i class="fa-solid fa-store"></i> Show Companies</a>
                    <a href="ShowProducts.aspx" class="mh-nav-link active"><i class="fa-solid fa-mobile"></i> Show Products</a>
                    <a href="addtocart.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <h1 class="mh-page-title">
                <asp:Label ID="lblTitle" runat="server" Text="Mobile Products &amp; Store"></asp:Label>
            </h1>
            <p class="mh-subtitle">Browse all products or filter by company</p>

            <div style="text-align: center;">
                <asp:Label ID="lblNoData" runat="server" Text="No products found for this company." Visible="false"></asp:Label>
            </div>

            <div style="display: flex; justify-content: center; width: 100%;">
                <asp:DataList ID="DataListProducts" runat="server" RepeatDirection="Horizontal" RepeatColumns="3" OnItemCommand="Datalist_ItemCommand" OnItemDataBound="DataListProducts_ItemDataBound" CssClass="mh-datalist-table">
                    <ItemTemplate>
                        <div class="mh-item-card" style="width: 270px; margin: 12px; height: calc(100% - 24px);">
                            <div style="text-align: center; margin-bottom: 12px;">
                                <asp:Image ID="imgProduct" runat="server" style="max-width: 200px; max-height: 180px; object-fit: contain; border-radius: 10px;" AlternateText="Product Image" />
                            </div>
                            <div class="item-title" style="font-size: 16px; font-weight: 700; color: #0f172a; margin-bottom: 12px;">
                                <asp:Label ID="lblProdName" runat="server" Text='<%# Eval("Prod_Name") %>'></asp:Label>
                            </div>
                            <div class="card-actions" style="width: 100%; display: flex; flex-direction: column; gap: 8px; margin-top: auto;">
                                <asp:LinkButton ID="btnViewDetail" runat="server" CommandName="cmd_vdtl" CommandArgument='<%# Eval("Prod_Id") %>' CssClass="action-link" style="justify-content: center; width: 100%; padding: 8px;">
                                    <i class="fa-solid fa-eye"></i> View Details
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnAddToCart" runat="server" CommandName="cmd_cart" CommandArgument='<%# Eval("Prod_Id") %>' CssClass="btn-primary" style="justify-content: center; width: 100%; padding: 9px; font-size: 13px;">
                                    <i class="fa-solid fa-cart-plus"></i> Add To Cart
                                </asp:LinkButton>
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
