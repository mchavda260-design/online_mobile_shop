<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewdetails.aspx.cs" Inherits="DataBase.User.viewdetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Product Details - MobileHub</title>
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
                    <a href="ShowProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Show Products</a>
                    <a href="addtocart.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <h1 class="mh-page-title">Product Details</h1>

            <div style="text-align: center;">
                <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
            </div>

            <div style="display: flex; justify-content: center; margin-top: 20px;">
                <asp:DataList ID="DataList1" runat="server" RepeatDirection="Horizontal" CssClass="mh-datalist-table" OnItemDataBound="DataList1_ItemDataBound">
                    <ItemTemplate>
                        <div class="mh-card" style="max-width: 750px; display: flex; flex-wrap: wrap; gap: 30px; align-items: center; padding: 40px;">
                            <div style="flex: 1; min-width: 250px; text-align: center;">
                                <asp:Image ID="Image1" runat="server" style="max-width: 100%; max-height: 280px; object-fit: contain; border-radius: 16px; box-shadow: 0 8px 24px rgba(0,0,0,0.06);" />
                            </div>
                            <div style="flex: 1.2; min-width: 280px;">
                                <h2 style="font-size: 24px; font-weight: 800; color: #0f172a; margin-bottom: 12px;">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Prod_Name") %>'></asp:Label>
                                </h2>
                                
                                <div style="font-size: 24px; font-weight: 800; color: #2563eb; margin-bottom: 18px;">
                                    &#8377; <asp:Label ID="Label3" runat="server" Text='<%# Eval("Prod_Price") %>'></asp:Label>
                                </div>

                                <div style="margin-bottom: 14px; padding: 12px; background: #f8f5ff; border-radius: 10px; border: 1px solid #e0d9f5;">
                                    <strong style="color: #7c6fa5; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; display: block; margin-bottom: 4px;">Specification / Config:</strong>
                                    <span style="font-size: 14px; font-weight: 600; color: #0f172a;">
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("Prod_Config") %>'></asp:Label>
                                    </span>
                                </div>

                                <div style="margin-bottom: 24px;">
                                    <strong style="color: #7c6fa5; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; display: block; margin-bottom: 4px;">Description:</strong>
                                    <p style="font-size: 14px; color: #7c6fa5; line-height: 1.6;">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Prod_Desc") %>'></asp:Label>
                                    </p>
                                </div>

                                <div>
                                    <a href="ShowProducts.aspx" class="btn-secondary" style="display: inline-flex; align-items: center; gap: 8px; padding: 10px 20px; font-size: 14px;">
                                        <i class="fa-solid fa-arrow-left"></i> Back to Products
                                    </a>
                                </div>
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
