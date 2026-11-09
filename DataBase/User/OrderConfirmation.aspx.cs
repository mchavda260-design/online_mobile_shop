using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;



namespace DataBase.User
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        int uid = 1;
        string nm;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        void Getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillCartGrid()
        {
            Getcon();
            da = new SqlDataAdapter(
                "select c.Cart_Id, p.Prod_Name, p.Prod_Price, p.Prod_Img, c.Quantity " +
                "from Add_Products_tbl p " +
                "INNER JOIN cart_tbl c ON p.Prod_Id = c.Cart_Prod_Id " +
                "where c.Cart_User_Id = '" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

            decimal subtotal = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                subtotal += Convert.ToDecimal(row["Prod_Price"]) * Convert.ToInt32(row["Quantity"]);
            }

            decimal delivery = 200;
            decimal grandtotal = subtotal + delivery;

            lblSubtotal.Text  = "₹" + subtotal.ToString("0.00");
            lblDelivery.Text  = "₹" + delivery.ToString("0.00");
            lblGrandTotal.Text = "₹" + grandtotal.ToString("0.00");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                Getcon();

                da = new SqlDataAdapter(
                    "Select * from emp_tbl where Email = '" + Session["Admin"] + "' or Name = '" + Session["Admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm  = ds.Tables[0].Rows[0]["Name"].ToString();
                    uid = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);

                    lblWelcome.Text = "Welcome, " + nm + "  ✔";
                    lblName.Text    = nm;
                    lblMobile.Text  = ds.Tables[0].Rows[0]["Mobile"].ToString();
                    lblAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                }

                if (!IsPostBack)
                {
                    fillCartGrid();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string payMethod = "Cash on Delivery";
            if (rbOnline.Checked) payMethod = "Online Payment";
            else if (rbUPI.Checked) payMethod = "UPI";

            string grandTotalStr = lblGrandTotal.Text.Replace("₹", "").Trim();
            decimal grandTotal = Convert.ToDecimal(grandTotalStr);

            
            Getcon();
            da = new SqlDataAdapter(
                "SELECT Cart_Prod_Id, Quantity FROM cart_tbl WHERE Cart_User_Id = '" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMsg.Text = "⚠️ Cart ખાલી છે! પહેલા product add કરો.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            
            cmd = new SqlCommand("SELECT ISNULL(MAX(Order_No), 0) + 1 FROM Order_tbl", con);
            int nextOrderNo = Convert.ToInt32(cmd.ExecuteScalar());

            string address = lblAddress.Text;
            string orderDate = DateTime.Now.ToString("yyyy-MM-dd");

            
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                int prodId   = Convert.ToInt32(row["Cart_Prod_Id"]);
                int quantity = Convert.ToInt32(row["Quantity"]);

                cmd = new SqlCommand(
                    "INSERT INTO Order_tbl (Order_No, Order_User_Id, Order_Prod_Id, Quantity, Pay_Method, Pay_Status, Ship_Address, Order_Date) " +
                    "VALUES ('" + nextOrderNo + "', '" + uid + "', '" + prodId + "', '" + quantity + "', '" + payMethod + "', 'Pending', '" + address + "', '" + orderDate + "')", con);
                cmd.ExecuteNonQuery();
            }

            
            cmd = new SqlCommand("DELETE FROM cart_tbl WHERE Cart_User_Id = '" + uid + "'", con);
            cmd.ExecuteNonQuery();

            lblMsg.Text      = "✅ Order Placed Successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;

            Response.AddHeader("Refresh", "2;URL=Order details.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

        protected void btnDownloadPDF_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;
            SqlConnection con2 = new SqlConnection(connStr);
            con2.Open();
            SqlDataAdapter da2 = new SqlDataAdapter(
                "select p.Prod_Name, p.Prod_Price, c.Quantity " +
                "from Add_Products_tbl p " +
                "INNER JOIN cart_tbl c ON p.Prod_Id = c.Cart_Prod_Id " +
                "where c.Cart_User_Id = '" + uid + "'", con2);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            Document doc = new Document(PageSize.A4, 40, 40, 60, 40);
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(doc, ms);
            doc.Open();

            Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 20, new BaseColor(75, 0, 130));
            Font headFont  = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.WHITE);
            Font bodyFont  = FontFactory.GetFont(FontFactory.HELVETICA, 10, BaseColor.BLACK);
            Font boldFont  = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.BLACK);
            Font totalFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 13, new BaseColor(22, 163, 74));

            Paragraph title = new Paragraph("MobileHub -- Order Receipt", titleFont);
            title.Alignment = Element.ALIGN_CENTER;
            doc.Add(title);
            doc.Add(new Paragraph("Generated: " + DateTime.Now.ToString("dd-MM-yyyy HH:mm"),
                FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.GRAY)));
            doc.Add(Chunk.NEWLINE);

            doc.Add(new Paragraph("Customer : " + lblName.Text, boldFont));
            doc.Add(new Paragraph("Mobile   : " + lblMobile.Text, bodyFont));
            doc.Add(new Paragraph("Address  : " + lblAddress.Text, bodyFont));
            string payMethod = rbCOD.Checked ? "Cash on Delivery" : rbUPI.Checked ? "UPI" : "Online Payment";
            doc.Add(new Paragraph("Payment  : " + payMethod, bodyFont));
            doc.Add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(4);
            table.WidthPercentage = 100;
            table.SetWidths(new float[] { 3f, 1.5f, 1f, 1.5f });
            BaseColor purple = new BaseColor(107, 63, 160);
            foreach (string h in new[] { "Product Name", "Unit Price", "Qty", "Subtotal" })
            {
                PdfPCell cell = new PdfPCell(new Phrase(h, headFont));
                cell.BackgroundColor = purple; cell.Padding = 7;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                table.AddCell(cell);
            }
            decimal subtotal = 0;
            bool alt = false;
            BaseColor light = new BaseColor(243, 240, 255);
            foreach (DataRow row in ds2.Tables[0].Rows)
            {
                decimal price = Convert.ToDecimal(row["Prod_Price"]);
                int qty = Convert.ToInt32(row["Quantity"]);
                decimal sub = price * qty; subtotal += sub;
                BaseColor bg = alt ? light : BaseColor.WHITE; alt = !alt;
                table.AddCell(new PdfPCell(new Phrase(row["Prod_Name"].ToString(), bodyFont)) { BackgroundColor = bg, Padding = 5 });
                table.AddCell(new PdfPCell(new Phrase("Rs." + price, bodyFont)) { BackgroundColor = bg, Padding = 5, HorizontalAlignment = Element.ALIGN_CENTER });
                table.AddCell(new PdfPCell(new Phrase(qty.ToString(), bodyFont)) { BackgroundColor = bg, Padding = 5, HorizontalAlignment = Element.ALIGN_CENTER });
                table.AddCell(new PdfPCell(new Phrase("Rs." + sub, bodyFont)) { BackgroundColor = bg, Padding = 5, HorizontalAlignment = Element.ALIGN_CENTER });
            }
            doc.Add(table);
            doc.Add(Chunk.NEWLINE);
            doc.Add(new Paragraph("Subtotal    : Rs." + subtotal, bodyFont));
            doc.Add(new Paragraph("Delivery    : Rs.200", bodyFont));
            doc.Add(new Paragraph("Grand Total : Rs." + (subtotal + 200), totalFont));
            doc.Add(Chunk.NEWLINE);
            doc.Add(new Paragraph("Thank you for shopping at MobileHub!",
                FontFactory.GetFont(FontFactory.HELVETICA_OBLIQUE, 10, new BaseColor(107, 63, 160))));
            doc.Close();

            byte[] bytes = ms.ToArray();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=OrderReceipt.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}