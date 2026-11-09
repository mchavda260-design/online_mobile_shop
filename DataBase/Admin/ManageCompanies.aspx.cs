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
    public partial class ManageCompanies : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Add_Company_tbl", con);
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
            int cid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            GridViewRow row = GridView1.Rows[e.RowIndex];

            string compName   = ((TextBox)row.Cells[1].Controls[0]).Text;
            string ownerName  = ((TextBox)row.Cells[2].Controls[0]).Text;
            string compEmail  = ((TextBox)row.Cells[3].Controls[0]).Text;
            string compAddr   = ((TextBox)row.Cells[4].Controls[0]).Text;

            getcon();
            cmd = new SqlCommand("update Add_Company_tbl set Comp_Name='" + compName + "', Comp_Owner_Name='" + ownerName + "', Comp_Email='" + compEmail + "', Comp_address='" + compAddr + "' where Comp_Id='" + cid + "'", con);
            cmd.ExecuteNonQuery();

            GridView1.EditIndex = -1;
            fillgrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            getcon();
            cmd = new SqlCommand("delete from Add_Company_tbl where Comp_Id='" + cid + "'", con);
            cmd.ExecuteNonQuery();

            fillgrid();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["Admin"] = null;
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }

        protected void btnCompPDF_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;
            SqlConnection con2 = new SqlConnection(connStr);
            con2.Open();
            SqlDataAdapter da2 = new SqlDataAdapter(
                "select Comp_Id, Comp_Name, Comp_Owner_Name, Comp_Email, Comp_address from Add_Company_tbl", con2);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            Document doc = new Document(PageSize.A4, 40, 40, 60, 40);
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(doc, ms);
            doc.Open();

            Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 18, new BaseColor(75, 0, 130));
            Font headFont  = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 11, BaseColor.WHITE);
            Font bodyFont  = FontFactory.GetFont(FontFactory.HELVETICA, 10, BaseColor.BLACK);

            Paragraph title = new Paragraph("MobileHub Admin -- Companies Report", titleFont);
            title.Alignment = Element.ALIGN_CENTER;
            doc.Add(title);
            doc.Add(new Paragraph("Total: " + ds2.Tables[0].Rows.Count + " companies   |   " + DateTime.Now.ToString("dd-MM-yyyy"),
                FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.GRAY)));
            doc.Add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(5);
            table.WidthPercentage = 100;
            table.SetWidths(new float[] { 0.7f, 2f, 2f, 2.5f, 2.5f });
            BaseColor purple = new BaseColor(107, 63, 160);
            foreach (string h in new[] { "ID", "Company", "Owner", "Email", "Address" })
            {
                PdfPCell cell = new PdfPCell(new Phrase(h, headFont));
                cell.BackgroundColor = purple; cell.Padding = 7;
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                table.AddCell(cell);
            }
            bool alt = false;
            BaseColor light = new BaseColor(243, 240, 255);
            foreach (DataRow row in ds2.Tables[0].Rows)
            {
                BaseColor bg = alt ? light : BaseColor.WHITE; alt = !alt;
                foreach (string col in new[] { "Comp_Id","Comp_Name","Comp_Owner_Name","Comp_Email","Comp_address" })
                    table.AddCell(new PdfPCell(new Phrase(row[col].ToString(), bodyFont)) { BackgroundColor = bg, Padding = 5 });
            }
            doc.Add(table);
            doc.Close();

            byte[] bytes = ms.ToArray();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=AdminCompanies.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}