<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="DataBase.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Registration Form - MobileHub</title>
    <link href="style.css/StyleSheet1.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <header class="mh-header">
            <nav class="mh-navbar">
                <a href="Login.aspx" class="mh-logo">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                    <span>Mobile</span>Hub
                </a>
                <div class="mh-nav-menu">
                    <a href="Login.aspx" class="mh-nav-link"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
                    <a href="WebForm1.aspx" class="mh-nav-link active"><i class="fa-solid fa-user-plus"></i> Register</a>
                    <a href="User/ShowCompany.aspx" class="mh-nav-link"><i class="fa-solid fa-store"></i> Browse Store</a>
                </div>
            </nav>
        </header>

        <main class="mh-container">
            <div class="mh-form-card" style="max-width: 800px;">
                <h1 class="mh-page-title">Registration Form</h1>
                <p class="mh-subtitle">Fill in your details to create an account</p>

                <table class="form-table">
                    <tr>
                        <td>First Name:</td>
                        <td>
                            <asp:TextBox ID="txtnm" runat="server" Placeholder="Enter First Name"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Gender:</td>
                        <td>
                            <asp:RadioButtonList ID="rdbgen" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" CssClass="asp-radio-list">
                                <asp:ListItem>Male</asp:ListItem>
                                <asp:ListItem>Female</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>
                            <asp:TextBox ID="txtemil" runat="server" TextMode="Email" Placeholder="Enter Email Address"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td>
                            <asp:TextBox ID="txtpass" runat="server" TextMode="Password" Placeholder="Enter Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>City:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
                                <asp:ListItem>-- select city --</asp:ListItem>
                                <asp:ListItem>Rajkot</asp:ListItem>
                                <asp:ListItem>Ahmedabad</asp:ListItem>
                                <asp:ListItem>Surat</asp:ListItem>
                                <asp:ListItem>Vadodara</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Address:</td>
                        <td>
                            <asp:TextBox ID="txtadd" runat="server" TextMode="MultiLine" Rows="3" Placeholder="Enter Address"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Mobile:</td>
                        <td>
                            <asp:TextBox ID="txtmob" runat="server" Placeholder="Enter Mobile Number"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Profile Image:</td>
                        <td>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-top: 15px;">
                            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="btnsub_Click" CssClass="asp-button" />
                        </td>
                    </tr>
                </table>
            </div>

            <div class="mh-card" style="margin-top: 30px;">
                <h2 style="font-size: 20px; font-weight: 700; margin-bottom: 16px;"><i class="fa-solid fa-users"></i> Registered Users</h2>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" CssClass="mh-gridview">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gender">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Password">
                            <ItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="City">
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address">
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mobile">
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" Height="50px" Width="50px" ImageUrl='<%# Eval("Image") %>' style="border-radius: 8px; object-fit: cover;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="cmd_edt" CssClass="action-link"><i class="fa-solid fa-pen-to-square"></i> Edit</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="cmd_del" CssClass="action-link action-link-danger"><i class="fa-solid fa-trash"></i> Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </main>

        <footer class="mh-footer">
            &copy; <%: DateTime.Now.Year %> MobileHub Store. All rights reserved.
        </footer>
    </form>
</body>
</html>
