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
    public partial class addtocart : System.Web.UI.Page
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

        void fillcartgrid()
        {
            Getcon();
            da = new SqlDataAdapter("select c.Cart_Id, p.Prod_Id, p.Prod_Name, " +
                "p.Prod_Price, " +
                "p.Prod_Img, c.Quantity " +
                "from Add_Products_tbl p " +
                "INNER JOIN cart_tbl c ON p.Prod_Id = c.Cart_Prod_Id " +
                "where c.Cart_User_Id = '" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

            decimal total = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                decimal Price = Convert.ToDecimal(row["Prod_Price"]);
                int Quantity = Convert.ToInt32(row["Quantity"]);
                total += Price * Quantity;
            }
            Label5.Text = "Total: \u20B9" + total;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                Getcon();

                da = new SqlDataAdapter("Select * from emp_tbl where Email = '" + Session["Admin"] + "' or Name = '" + Session["Admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Name"].ToString();
                    uid = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);
                    Label1.Text = "Welcome : " + nm;
                }

                if (!IsPostBack)
                {
                    fillcartgrid();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            fillcartgrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            fillcartgrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int cartid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            GridViewRow row = GridView1.Rows[e.RowIndex];
            DropDownList ddlqty = (DropDownList)row.FindControl("DropDownList1");
            int qty = int.Parse(ddlqty.SelectedValue);

            Getcon();
            cmd = new SqlCommand("Update cart_tbl set Quantity='" + qty + "' where Cart_Id='" + cartid + "' AND Cart_User_Id='" + uid + "'", con);
            cmd.ExecuteNonQuery();

            GridView1.EditIndex = -1;
            fillcartgrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cartid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            Getcon();
            cmd = new SqlCommand("delete from cart_tbl where Cart_Id='" + cartid + "' AND Cart_User_Id='" + uid + "'", con);
            cmd.ExecuteNonQuery();

            GridView1.EditIndex = -1;
            fillcartgrid();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/User/OrderConfirmation.aspx");
        }

        protected void btnCartPDF_Click(object sender, EventArgs e)
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
            Font totalFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 13, new BaseColor(37, 99, 235));

            Paragraph title = new Paragraph("MobileHub -- My Shopping Cart", titleFont);
            title.Alignment = Element.ALIGN_CENTER;
            doc.Add(title);
            doc.Add(new Paragraph("Date: " + DateTime.Now.ToString("dd-MM-yyyy"),
                FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.GRAY)));
            doc.Add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(4);
            table.WidthPercentage = 100;
            table.SetWidths(new float[] { 3f, 1.5f, 1f, 1.5f });
            BaseColor purple = new BaseColor(107, 63, 160);
            foreach (string h in new[] { "Product Name", "Unit Price (Rs.)", "Quantity", "Total (Rs.)" })
            {
                PdfPCell cell = new PdfPCell(new Phrase(h, headFont));
                cell.BackgroundColor = purple; cell.Padding = 7;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                table.AddCell(cell);
            }
            decimal grandTotal = 0;
            bool alt = false;
            BaseColor light = new BaseColor(243, 240, 255);
            foreach (DataRow row in ds2.Tables[0].Rows)
            {
                decimal price = Convert.ToDecimal(row["Prod_Price"]);
                int qty = Convert.ToInt32(row["Quantity"]);
                decimal sub = price * qty; grandTotal += sub;
                BaseColor bg = alt ? light : BaseColor.WHITE; alt = !alt;
                table.AddCell(new PdfPCell(new Phrase(row["Prod_Name"].ToString(), bodyFont)) { BackgroundColor = bg, Padding = 5 });
                table.AddCell(new PdfPCell(new Phrase(price.ToString(), bodyFont)) { BackgroundColor = bg, Padding = 5, HorizontalAlignment = Element.ALIGN_CENTER });
                table.AddCell(new PdfPCell(new Phrase(qty.ToString(), bodyFont)) { BackgroundColor = bg, Padding = 5, HorizontalAlignment = Element.ALIGN_CENTER });
                table.AddCell(new PdfPCell(new Phrase(sub.ToString(), bodyFont)) { BackgroundColor = bg, Padding = 5, HorizontalAlignment = Element.ALIGN_CENTER });
            }
            doc.Add(table);
            doc.Add(Chunk.NEWLINE);
            doc.Add(new Paragraph("Grand Total: Rs." + grandTotal, totalFont));
            doc.Close();

            byte[] bytes = ms.ToArray();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=MyCart.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}