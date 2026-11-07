<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="DataBase.User.OrderConfirmation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Order Confirmation - MobileHub</title>
    <link href="../style.css/StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f0f4ff; min-height: 100vh; }

        .oc-hero {
            background: linear-gradient(135deg, #1e40af 0%, #6d28d9 100%);
            border-radius: 18px;
            padding: 30px 36px;
            margin-top: 24px;
            display: flex;
            align-items: center;
            gap: 18px;
            color: #fff;
        }
        .oc-hero i  { font-size: 44px; opacity: 0.9; }
        .oc-hero h1 { font-size: 26px; font-weight: 800; margin-bottom: 4px; }
        .oc-hero p  { font-size: 14px; opacity: 0.85; }

        .oc-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            padding: 28px 24px;
            margin-top: 24px;
            margin-bottom: 24px;
            overflow-x: auto;
        }

        .oc-grid { width: 100%; border-collapse: collapse; min-width: 600px; }
        .oc-grid th {
            background: linear-gradient(135deg, #1e40af, #6d28d9);
            color: #fff;
            padding: 13px 16px;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-align: left;
        }
        .oc-grid th:first-child { border-radius: 10px 0 0 0; }
        .oc-grid th:last-child  { border-radius: 0 10px 0 0; }
        .oc-grid td {
            padding: 13px 16px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            color: #334155;
            vertical-align: middle;
        }
        .oc-grid tr:last-child td { border-bottom: none; }
        .oc-grid tr:nth-child(even) td { background: #f8faff; }
        .oc-grid tr:hover td { background: #eff6ff; }
        .oc-grid .prod-img {
            width: 54px; height: 54px;
            border-radius: 10px;
            object-fit: contain;
            border: 1px solid #e2e8f0;
            background: #f8faff;
            padding: 4px;
        }
        .oc-grid .prod-name  { font-weight: 700; color: #0f172a; }
        .oc-grid .prod-price { font-weight: 700; color: #2563eb; }
        .oc-grid .qty-badge  {
            display: inline-block;
            padding: 3px 12px;
            background: #eff6ff;
            color: #2563eb;
            border-radius: 20px;
            font-weight: 700;
            font-size: 13px;
        }
        .oc-grid .subtotal-cell { font-weight: 800; color: #16a34a; }

        /* Bill Summary */
        .bill-table { width: 100%; font-size: 15px; border-collapse: collapse; }
        .bill-table td { padding: 10px 8px; }
        .bill-divider { border: 1px dashed #e2e8f0; margin: 4px 0; }
        .bill-grand { font-size: 20px; font-weight: 900; color: #16a34a; }

        /* Place Order button */
        .btn-place-order {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 36px;
            background: linear-gradient(135deg, #16a34a, #15803d);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 800;
            cursor: pointer;
            transition: opacity 0.15s, transform 0.15s;
            text-decoration: none;
        }
        .btn-place-order:hover { opacity: 0.9; transform: translateY(-2px); }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: opacity 0.15s;
        }
        .btn-back:hover { opacity: 0.88; color: #fff; text-decoration: none; }

        .oc-welcome-chip {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #eff6ff;
            color: #1d4ed8;
            border-radius: 50px;
            padding: 6px 18px;
            font-weight: 700;
            font-size: 13px;
            margin-bottom: 4px;
        }

        .payment-section label {
            font-weight: 600;
            color: #334155;
            font-size: 14px;
            margin-left: 8px;
        }
        .payment-section { margin-bottom: 16px; }
        .payment-section .pay-opt { margin-right: 28px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- HEADER -->
        <header class="mh-header">
            <nav class="mh-navbar">
                <a href="../Login.aspx" class="mh-logo">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                    <span>Mobile</span>Hub
                </a>
                <div class="mh-nav-menu">
                    <a href="UserDashboard.aspx" class="mh-nav-link"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                    <a href="ShowProducts.aspx"   class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Products</a>
                    <a href="addtocart.aspx"       class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
                    <a href="Order details.aspx"  class="mh-nav-link"><i class="fa-solid fa-receipt"></i> My Orders</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <main class="mh-container">

            <!-- Welcome chip -->
            <div style="margin-top: 20px;">
                <asp:Label ID="lblWelcome" runat="server" CssClass="oc-welcome-chip">
                    <i class="fa-solid fa-circle-check"></i>
                </asp:Label>
            </div>

            <!-- Hero -->
            <div class="oc-hero">
                <i class="fa-solid fa-clipboard-check"></i>
                <div>
                    <h1>Order Confirmation</h1>
                    <p>Review your items and place your order</p>
                </div>
            </div>

            <!-- Cart Items Table -->
            <div class="oc-card">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:18px; flex-wrap:wrap; gap:12px;">
                    <h2 style="font-size:18px; font-weight:800; color:#0f172a;">
                        <i class="fa-solid fa-bag-shopping" style="color:#2563eb; margin-right:8px;"></i>
                        Your Cart Items
                    </h2>
                    <a href="addtocart.aspx" class="btn-back">
                        <i class="fa-solid fa-arrow-left"></i> Back to Cart
                    </a>
                </div>

                <asp:GridView ID="GridView1" runat="server"
                    AutoGenerateColumns="False"
                    CssClass="oc-grid"
                    GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderText="Product Image">
                            <ItemTemplate>
                                <asp:Image ID="imgProd" runat="server"
                                    ImageUrl='<%# Eval("Prod_Img") %>'
                                    CssClass="prod-img"
                                    AlternateText="Product" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <span class="prod-name"><%# Eval("Prod_Name") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit Price">
                            <ItemTemplate>
                                <span class="prod-price">&#8377; <%# Eval("Prod_Price") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <span class="qty-badge"><%# Eval("Quantity") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Subtotal">
                            <ItemTemplate>
                                <span class="subtotal-cell">
                                    &#8377; <%# String.Format("{0:N0}", Convert.ToDecimal(Eval("Prod_Price")) * Convert.ToInt32(Eval("Quantity"))) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align:center; padding:40px; color:#94a3b8;">
                            <i class="fa-solid fa-cart-xmark" style="font-size:48px; opacity:0.4; display:block; margin-bottom:12px;"></i>
                            <p style="font-size:16px; font-weight:600;">Cart is empty</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

            <!-- Payment + Bill -->
            <div style="display:flex; gap:24px; flex-wrap:wrap; margin-bottom:32px;">

                <!-- Payment Method -->
                <div class="oc-card" style="flex:1; min-width:260px;">
                    <h3 style="font-size:16px; font-weight:800; color:#1e40af; margin-bottom:18px;">
                        <i class="fa-solid fa-credit-card" style="margin-right:8px;"></i>Payment Method
                    </h3>
                    <div class="payment-section">
                        <span class="pay-opt">
                            <asp:RadioButton ID="rbCOD" runat="server" GroupName="PayMethod" Text="Cash on Delivery" Checked="true" />
                        </span>
                        <span class="pay-opt">
                            <asp:RadioButton ID="rbOnline" runat="server" GroupName="PayMethod" Text="Online Payment" />
                        </span>
                        <span class="pay-opt">
                            <asp:RadioButton ID="rbUPI" runat="server" GroupName="PayMethod" Text="UPI" />
                        </span>
                    </div>

                    <h3 style="font-size:16px; font-weight:800; color:#1e40af; margin-bottom:12px; margin-top:18px;">
                        <i class="fa-solid fa-location-dot" style="margin-right:8px;"></i>Delivery Info
                    </h3>
                    <table style="width:100%; font-size:14px; border-collapse:collapse;">
                        <tr>
                            <td style="padding:6px 0; color:#64748b; width:90px; font-weight:600;">Name</td>
                            <td style="padding:6px 0; font-weight:700; color:#0f172a;">
                                <asp:Label ID="lblName" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding:6px 0; color:#64748b; font-weight:600;">Mobile</td>
                            <td style="padding:6px 0; color:#0f172a;">
                                <asp:Label ID="lblMobile" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding:6px 0; color:#64748b; font-weight:600;">Address</td>
                            <td style="padding:6px 0; color:#0f172a;">
                                <asp:Label ID="lblAddress" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Bill Summary -->
                <div class="oc-card" style="flex:1; min-width:260px;">
                    <h3 style="font-size:16px; font-weight:800; color:#16a34a; margin-bottom:18px;">
                        <i class="fa-solid fa-receipt" style="margin-right:8px;"></i>Bill Summary
                    </h3>
                    <table class="bill-table">
                        <tr>
                            <td style="color:#334155; font-weight:600;">Subtotal</td>
                            <td style="text-align:right; color:#2563eb; font-weight:700;">
                                <asp:Label ID="lblSubtotal" runat="server" Text="&#8377; 0.00"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background:#f8faff;">
                            <td style="color:#334155; font-weight:600;">
                                <i class="fa-solid fa-truck" style="color:#f59e0b; margin-right:6px;"></i>Delivery
                            </td>
                            <td style="text-align:right; color:#f59e0b; font-weight:700;">
                                <asp:Label ID="lblDelivery" runat="server" Text="&#8377; 200.00"></asp:Label>
                            </td>
                        </tr>
                        <tr><td colspan="2"><hr class="bill-divider" /></td></tr>
                        <tr>
                            <td style="color:#064e3b; font-size:17px; font-weight:800;">Grand Total</td>
                            <td style="text-align:right;">
                                <asp:Label ID="lblGrandTotal" runat="server" CssClass="bill-grand" Text="&#8377; 0.00"></asp:Label>
                            </td>
                        </tr>
                    </table>

                    <div style="margin-top:28px; text-align:center;">
                        <asp:Button ID="btnPlaceOrder" runat="server"
                            Text="Place Order"
                            CssClass="btn-place-order"
                            OnClick="btnPlaceOrder_Click" />
                    </div>

                    <asp:Label ID="lblMsg" runat="server"
                        Style="display:block; margin-top:14px; text-align:center; font-weight:700; font-size:15px;">
                    </asp:Label>
                </div>

            </div>

        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Store. All rights reserved.
        </footer>

    </form>
</body>
</html>
