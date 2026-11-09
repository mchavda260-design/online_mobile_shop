using System;
using System.Collections.Generic;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
 // for connection string
using System.Data; // for dataset
using System.Data.SqlClient; // for connecting to sql server
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataBase.Admin
{
    public partial class ManageOrders : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string nm;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter(
                "select c.Cart_Id, e.Name as User_Name, p.Prod_Name, p.Prod_Price, c.Quantity, c.AddedDate " +
                "from cart_tbl c " +
                "INNER JOIN Add_Products_tbl p ON p.Prod_Id = c.Cart_Prod_Id " +
                "INNER JOIN emp_tbl e ON e.Emp_Id = c.Cart_User_Id", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                getcon();

                da = new SqlDataAdapter("Select * from emp_tbl where Email = '" + Session["Admin"] + "' or Name = '" + Session["Admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Name"].ToString();
                    lblWelcome.Text = "Welcome : " + nm;
                }

                if (!IsPostBack)
                {
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cartid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            getcon();
            cmd = new SqlCommand("delete from cart_tbl where Cart_Id='" + cartid + "'", con);
            cmd.ExecuteNonQuery();

            fillgrid();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["Admin"] = null;
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

        protected void btnOrdersPDF_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;
            SqlConnection con2 = new SqlConnection(connStr);
            con2.Open();
            SqlDataAdapter da2 = new SqlDataAdapter(
                "select e.Name as User_Name, p.Prod_Name, p.Prod_Price, c.Quantity, " +
                "(p.Prod_Price * c.Quantity) as Total, c.AddedDate " +
                "from cart_tbl c " +
                "INNER JOIN Add_Products_tbl p ON p.Prod_Id = c.Cart_Prod_Id " +
                "INNER JOIN emp_tbl e ON e.Emp_Id = c.Cart_User_Id", con2);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            Document doc = new Document(PageSize.A4.Rotate(), 30, 30, 50, 30);
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(doc, ms);
            doc.Open();

            Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 18, new BaseColor(75, 0, 130));
            Font headFont  = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
            Font bodyFont  = FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.BLACK);
            Font totalFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12, new BaseColor(22, 163, 74));

            Paragraph title = new Paragraph("MobileHub Admin -- Orders Report", titleFont);
            title.Alignment = Element.ALIGN_CENTER;
            doc.Add(title);
            doc.Add(new Paragraph("Total Orders: " + ds2.Tables[0].Rows.Count + "   |   Generated: " + DateTime.Now.ToString("dd-MM-yyyy HH:mm"),
                FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.GRAY)));
            doc.Add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(6);
            table.WidthPercentage = 100;
            table.SetWidths(new float[] { 2f, 2.5f, 1.5f, 1f, 1.5f, 1.5f });
            BaseColor purple = new BaseColor(107, 63, 160);
            foreach (string h in new[] { "User Name", "Product", "Price (Rs.)", "Qty", "Total (Rs.)", "Date" })
            {
                PdfPCell cell = new PdfPCell(new Phrase(h, headFont));
                cell.BackgroundColor = purple; cell.Padding = 6;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                table.AddCell(cell);
            }
            decimal grandTotal = 0;
            bool alt = false;
            BaseColor light = new BaseColor(243, 240, 255);
            foreach (DataRow row in ds2.Tables[0].Rows)
            {
                decimal total = row["Total"] != DBNull.Value ? Convert.ToDecimal(row["Total"]) : 0;
                grandTotal += total;
                string dateStr = row["AddedDate"] != DBNull.Value ? Convert.ToDateTime(row["AddedDate"]).ToString("dd-MM-yyyy") : "";
                BaseColor bg = alt ? light : BaseColor.WHITE; alt = !alt;
                string[] vals = { row["User_Name"].ToString(), row["Prod_Name"].ToString(),
                    row["Prod_Price"].ToString(), row["Quantity"].ToString(), total.ToString("0.00"), dateStr };
                foreach (string v in vals)
                    table.AddCell(new PdfPCell(new Phrase(v, bodyFont)) { BackgroundColor = bg, Padding = 4 });
            }
            doc.Add(table);
            doc.Add(Chunk.NEWLINE);
            doc.Add(new Paragraph("Grand Total Revenue: Rs." + grandTotal.ToString("0.00"), totalFont));
            doc.Close();

            byte[] bytes = ms.ToArray();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=OrdersReport.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}