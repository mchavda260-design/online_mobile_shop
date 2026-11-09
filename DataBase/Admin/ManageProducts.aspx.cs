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
    public partial class ManageProducts : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Add_Products_tbl", con);
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

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            fillgrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            fillgrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int pid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            GridViewRow row = GridView1.Rows[e.RowIndex];

            string prodName   = ((TextBox)row.Cells[1].Controls[0]).Text;
            string prodModel  = ((TextBox)row.Cells[2].Controls[0]).Text;
            string prodDesc   = ((TextBox)row.Cells[3].Controls[0]).Text;
            string prodWeight = ((TextBox)row.Cells[4].Controls[0]).Text;
            string prodConfig = ((TextBox)row.Cells[5].Controls[0]).Text;
            string prodPrice  = ((TextBox)row.Cells[6].Controls[0]).Text;

            getcon();
            cmd = new SqlCommand("update Add_Products_tbl set Prod_Name='" + prodName + "', Prod_Model='" + prodModel + "', Prod_Desc='" + prodDesc + "', Prod_Weight='" + prodWeight + "', Prod_Config='" + prodConfig + "', Prod_Price='" + prodPrice + "' where Prod_Id='" + pid + "'", con);
            cmd.ExecuteNonQuery();

            GridView1.EditIndex = -1;
            fillgrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int pid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            getcon();
            cmd = new SqlCommand("delete from Add_Products_tbl where Prod_Id='" + pid + "'", con);
            cmd.ExecuteNonQuery();

            fillgrid();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["Admin"] = null;
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

        protected void btnProdPDF_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;
            SqlConnection con2 = new SqlConnection(connStr);
            con2.Open();
            SqlDataAdapter da2 = new SqlDataAdapter(
                "select p.Prod_Name, p.Prod_Model, p.Prod_Price, p.Prod_Weight, p.Prod_Config, c.Comp_Name " +
                "from Add_Products_tbl p LEFT JOIN Add_Company_tbl c ON p.Prod_Comp_Id = c.Comp_Id", con2);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            Document doc = new Document(PageSize.A4.Rotate(), 30, 30, 50, 30);
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(doc, ms);
            doc.Open();

            Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 18, new BaseColor(75, 0, 130));
            Font headFont  = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
            Font bodyFont  = FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.BLACK);

            Paragraph title = new Paragraph("MobileHub Admin -- Products Report", titleFont);
            title.Alignment = Element.ALIGN_CENTER;
            doc.Add(title);
            doc.Add(new Paragraph("Total: " + ds2.Tables[0].Rows.Count + " products   |   " + DateTime.Now.ToString("dd-MM-yyyy"),
                FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.GRAY)));
            doc.Add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(6);
            table.WidthPercentage = 100;
            table.SetWidths(new float[] { 2.5f, 1.5f, 1.2f, 1f, 2.5f, 1.5f });
            BaseColor purple = new BaseColor(107, 63, 160);
            foreach (string h in new[] { "Product Name", "Model", "Price (Rs.)", "Weight", "Config", "Company" })
            {
                PdfPCell cell = new PdfPCell(new Phrase(h, headFont));
                cell.BackgroundColor = purple; cell.Padding = 6;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                table.AddCell(cell);
            }
            bool alt = false;
            BaseColor light = new BaseColor(243, 240, 255);
            foreach (DataRow row in ds2.Tables[0].Rows)
            {
                BaseColor bg = alt ? light : BaseColor.WHITE; alt = !alt;
                foreach (string col in new[] { "Prod_Name","Prod_Model","Prod_Price","Prod_Weight","Prod_Config","Comp_Name" })
                    table.AddCell(new PdfPCell(new Phrase(row[col].ToString(), bodyFont)) { BackgroundColor = bg, Padding = 4 });
            }
            doc.Add(table);
            doc.Close();

            byte[] bytes = ms.ToArray();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=AdminProducts.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}