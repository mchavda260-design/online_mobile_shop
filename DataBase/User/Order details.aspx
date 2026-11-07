<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order details.aspx.cs" Inherits="DataBase.User.Order_details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Order Details - MobileHub</title>
    <link href="../style.css/StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background: #f0f4ff; min-height: 100vh; }

        /* ── Summary Cards ── */
        .od-summary {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin: 28px 0 24px 0;
            justify-content: center;
        }
        .od-stat-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(37,99,235,0.10);
            padding: 24px 36px;
            min-width: 200px;
            text-align: center;
            transition: transform 0.18s, box-shadow 0.18s;
            border: 1.5px solid #e0e7ff;
        }
        .od-stat-card:hover { transform: translateY(-4px); box-shadow: 0 8px 32px rgba(37,99,235,0.16); }
        .od-stat-card i { font-size: 32px; margin-bottom: 10px; }
        .od-stat-num {
            font-size: 40px;
            font-weight: 900;
            color: #0f172a;
            line-height: 1;
            margin-bottom: 6px;
        }
        .od-stat-label { color: #64748b; font-size: 14px; font-weight: 500; }

        /* ── Page Hero ── */
        .od-hero {
            background: linear-gradient(135deg, #1e40af 0%, #6d28d9 100%);
            border-radius: 18px;
            padding: 30px 36px;
            margin-top: 24px;
            display: flex;
            align-items: center;
            gap: 18px;
            color: #fff;
        }
        .od-hero i { font-size: 44px; opacity: 0.9; }
        .od-hero h1 { font-size: 26px; font-weight: 800; margin-bottom: 4px; }
        .od-hero p { font-size: 14px; opacity: 0.85; }

        /* ── Table card ── */
        .od-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            padding: 28px 24px;
            margin-bottom: 32px;
            overflow-x: auto;
        }

        /* ── GridView overrides ── */
        .od-grid { width: 100%; border-collapse: collapse; min-width: 700px; }
        .od-grid th {
            background: linear-gradient(135deg, #1e40af, #6d28d9);
            color: #fff;
            padding: 14px 16px;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-align: left;
        }
        .od-grid th:first-child { border-radius: 10px 0 0 0; }
        .od-grid th:last-child { border-radius: 0 10px 0 0; }
        .od-grid td {
            padding: 14px 16px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            color: #334155;
            vertical-align: middle;
        }
        .od-grid tr:last-child td { border-bottom: none; }
        .od-grid tr:nth-child(even) td { background: #f8faff; }
        .od-grid tr:hover td { background: #eff6ff; transition: background 0.15s; }

        /* Product image in grid */
        .od-grid .prod-img {
            width: 58px; height: 58px;
            border-radius: 10px;
            object-fit: contain;
            border: 1px solid #e2e8f0;
            background: #f8faff;
            padding: 4px;
        }
        .od-grid .prod-name { font-weight: 700; color: #0f172a; }
        .od-grid .prod-price { font-weight: 700; color: #2563eb; }
        .od-grid .qty-badge {
            display: inline-block;
            padding: 4px 14px;
            background: #eff6ff;
            color: #2563eb;
            border-radius: 20px;
            font-weight: 700;
            font-size: 13px;
        }
        .od-grid .subtotal-cell { font-weight: 800; color: #16a34a; font-size: 15px; }
        .od-grid .date-cell { color: #64748b; font-size: 13px; }
        .od-grid .orderid-cell {
            font-family: monospace;
            font-weight: 700;
            color: #6d28d9;
            background: #f5f3ff;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 13px;
        }

        /* ── Total footer bar ── */
        .od-total-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            padding: 18px 24px;
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            border-radius: 14px;
            border: 1.5px solid #bbf7d0;
            flex-wrap: wrap;
            gap: 12px;
        }
        .od-total-label { font-size: 16px; font-weight: 600; color: #064e3b; }
        .od-total-amount { font-size: 28px; font-weight: 900; color: #16a34a; }

        /* ── Empty state ── */
        .od-empty {
            text-align: center;
            padding: 60px 20px;
            color: #94a3b8;
        }
        .od-empty i { font-size: 64px; margin-bottom: 16px; display: block; opacity: 0.4; }
        .od-empty p { font-size: 17px; font-weight: 600; margin-bottom: 8px; color: #475569; }
        .od-empty span { font-size: 14px; }

        /* ── Back button ── */
        .od-back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 22px;
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: #fff;
            border-radius: 10px;
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            transition: opacity 0.15s, transform 0.15s;
            border: none;
            cursor: pointer;
        }
        .od-back-btn:hover { opacity: 0.9; transform: translateY(-1px); text-decoration: none; color: #fff; }

        /* Welcome chip */
        .od-welcome-chip {
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
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- ─── HEADER / NAV ─── -->
        <header class="mh-header">
            <nav class="mh-navbar">
                <a href="../Login.aspx" class="mh-logo">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                    <span>Mobile</span>Hub
                </a>
                <div class="mh-nav-menu">
                    <a href="UserDashboard.aspx" class="mh-nav-link"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                    <a href="ShowCompany.aspx" class="mh-nav-link"><i class="fa-solid fa-store"></i> Companies</a>
                    <a href="ShowProducts.aspx" class="mh-nav-link"><i class="fa-solid fa-mobile"></i> Products</a>
                    <a href="addtocart.aspx" class="mh-nav-link"><i class="fa-solid fa-cart-shopping"></i> Cart</a>
                    <a href="Order details.aspx" class="mh-nav-link active"><i class="fa-solid fa-receipt"></i> My Orders</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="asp-button" OnClick="btnLogout_Click" />
                </div>
            </nav>
        </header>

        <!-- ─── MAIN CONTENT ─── -->
        <main class="mh-container">

            <!-- Welcome chip -->
            <div style="margin-top: 20px;">
                <asp:Label ID="lblWelcome" runat="server" CssClass="od-welcome-chip">
                    <i class="fa-solid fa-circle-check"></i>
                </asp:Label>
            </div>

            <!-- Hero Banner -->
            <div class="od-hero">
                <i class="fa-solid fa-bag-shopping"></i>
                <div>
                    <h1>My Order Details</h1>
                    <p>View all your past and current orders placed through MobileHub</p>
                </div>
            </div>

            <!-- Summary Cards -->
            <div class="od-summary">
                <div class="od-stat-card">
                    <i class="fa-solid fa-box-open" style="color: #2563eb;"></i>
                    <div class="od-stat-num">
                        <asp:Label ID="lblTotalItems" runat="server" Text="0"></asp:Label>
                    </div>
                    <div class="od-stat-label">Total Items Ordered</div>
                </div>
                <div class="od-stat-card">
                    <i class="fa-solid fa-indian-rupee-sign" style="color: #16a34a;"></i>
                    <div class="od-stat-num">
                        <asp:Label ID="lblGrandTotal" runat="server" Text="0"></asp:Label>
                    </div>
                    <div class="od-stat-label">Grand Total Spent</div>
                </div>
                <div class="od-stat-card">
                    <i class="fa-solid fa-calendar-check" style="color: #7c3aed;"></i>
                    <div class="od-stat-num">
                        <asp:Label ID="lblLatestDate" runat="server" Text="—"></asp:Label>
                    </div>
                    <div class="od-stat-label">Latest Order Date</div>
                </div>
            </div>

            <!-- Orders Table -->
            <div class="od-card">

                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px; flex-wrap: wrap; gap: 12px;">
                    <h2 style="font-size: 18px; font-weight: 800; color: #0f172a;">
                        <i class="fa-solid fa-list-check" style="color: #2563eb; margin-right: 8px;"></i>
                        Order History
                    </h2>
                    <a href="addtocart.aspx" class="od-back-btn">
                        <i class="fa-solid fa-cart-plus"></i> Go to Cart
                    </a>
                </div>

                <!-- GridView -->
                <asp:GridView ID="GridView1" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="Cart_Id"
                    CssClass="od-grid"
                    GridLines="None"
                    EmptyDataText="">
                    <Columns>
                        <asp:TemplateField HeaderText="Order ID">
                            <ItemTemplate>
                                <span class="orderid-cell">#<%# Eval("Cart_Id") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Product Image">
                            <ItemTemplate>
                                <asp:Image ID="imgProduct" runat="server"
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

                        <asp:TemplateField HeaderText="Order Date">
                            <ItemTemplate>
                                <span class="date-cell">
                                    <i class="fa-regular fa-calendar" style="margin-right: 4px;"></i>
                                    <%# Eval("AddedDate") != DBNull.Value ? Convert.ToDateTime(Eval("AddedDate")).ToString("dd MMM yyyy") : "—" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="od-empty">
                            <i class="fa-solid fa-box-open"></i>
                            <p>No orders found</p>
                            <span>You haven't placed any orders yet. Browse products and add them to your cart!</span>
                            <br /><br />
                            <a href="ShowProducts.aspx" class="od-back-btn" style="margin-top: 12px;">
                                <i class="fa-solid fa-mobile"></i> Browse Products
                            </a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>

                <!-- Grand Total Bar -->
                <asp:Panel ID="pnlTotal" runat="server">
                    <div class="od-total-bar">
                        <div>
                            <div class="od-total-label">
                                <i class="fa-solid fa-circle-check" style="color: #16a34a; margin-right: 6px;"></i>
                                Grand Total for All Orders
                            </div>
                            <div style="font-size: 13px; color: #6b7280; margin-top: 2px;">
                                Including all quantities
                            </div>
                        </div>
                        <div class="od-total-amount">
                            <asp:Label ID="lblTotalAmount" runat="server" Text="&#8377; 0"></asp:Label>
                        </div>
                    </div>
                </asp:Panel>

            </div>
            <!-- /od-card -->

            <!-- ─── USER INFO + BILL SUMMARY ─── -->
            <div style="display:flex; gap:24px; flex-wrap:wrap; margin-bottom:32px;">

                <!-- User Details Card -->
                <div class="od-card" style="flex:1; min-width:260px;">
                    <h3 style="font-size:16px;font-weight:800;color:#1e40af;margin-bottom:16px;">
                        <i class="fa-solid fa-user-circle" style="margin-right:8px;"></i>Delivery Details
                    </h3>
                    <table style="width:100%;border-collapse:collapse;font-size:14px;">
                        <tr>
                            <td style="padding:8px 0;color:#64748b;font-weight:600;width:110px;"><i class="fa-solid fa-user" style="margin-right:6px;color:#2563eb;"></i>Name</td>
                            <td style="padding:8px 0;color:#0f172a;font-weight:700;">
                                <asp:Label ID="lblname" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background:#f8faff;">
                            <td style="padding:8px 6px;color:#64748b;font-weight:600;"><i class="fa-solid fa-envelope" style="margin-right:6px;color:#7c3aed;"></i>Email</td>
                            <td style="padding:8px 6px;color:#0f172a;">
                                <asp:Label ID="lblemail" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding:8px 0;color:#64748b;font-weight:600;"><i class="fa-solid fa-phone" style="margin-right:6px;color:#16a34a;"></i>Mobile</td>
                            <td style="padding:8px 0;color:#0f172a;">
                                <asp:Label ID="lblmobile" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background:#f8faff;">
                            <td style="padding:8px 6px;color:#64748b;font-weight:600;"><i class="fa-solid fa-location-dot" style="margin-right:6px;color:#ef4444;"></i>Address</td>
                            <td style="padding:8px 6px;color:#0f172a;">
                                <asp:Label ID="lbladdress" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding:8px 0;color:#64748b;font-weight:600;"><i class="fa-regular fa-calendar" style="margin-right:6px;color:#f59e0b;"></i>Order Date</td>
                            <td style="padding:8px 0;color:#0f172a;font-weight:700;">
                                <asp:Label ID="lblorderdate" runat="server" Text="—"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Bill Summary Card -->
                <div class="od-card" style="flex:1; min-width:260px;">
                    <h3 style="font-size:16px;font-weight:800;color:#16a34a;margin-bottom:16px;">
                        <i class="fa-solid fa-receipt" style="margin-right:8px;"></i>Bill Summary
                    </h3>
                    <table style="width:100%;border-collapse:collapse;font-size:15px;">
                        <tr>
                            <td style="padding:10px 0;color:#334155;font-weight:600;">Subtotal</td>
                            <td style="padding:10px 0;color:#2563eb;font-weight:700;text-align:right;">
                                <asp:Label ID="lblsubtotal" runat="server" Text="&#8377; 0.00"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background:#f8faff;">
                            <td style="padding:10px 6px;color:#334155;font-weight:600;">
                                <i class="fa-solid fa-truck" style="margin-right:6px;color:#f59e0b;"></i>Delivery Charges
                            </td>
                            <td style="padding:10px 6px;color:#f59e0b;font-weight:700;text-align:right;">
                                <asp:Label ID="lbldelivery" runat="server" Text="&#8377; 200.00"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><hr style="border:1px dashed #e2e8f0;margin:4px 0;"/></td>
                        </tr>
                        <tr>
                            <td style="padding:12px 0;color:#064e3b;font-size:17px;font-weight:800;">Grand Total</td>
                            <td style="padding:12px 0;color:#16a34a;font-size:20px;font-weight:900;text-align:right;">
                                <asp:Label ID="lblBillGrandTotal" runat="server" Text="&#8377; 0.00"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>

        </main>

        <!-- ─── FOOTER ─── -->
        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Store. All rights reserved.
        </footer>

    </form>
</body>
</html>
