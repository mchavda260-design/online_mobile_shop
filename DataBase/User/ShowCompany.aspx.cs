using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
 // for connection string
using System.Data; // for dataset
using System.Data.SqlClient; // for connecting to sql server

namespace DataBase.User
{
    public partial class ShowCompany : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
           
                filldatalist();
            
        }

        void Getcon()
        {
           
                con = new SqlConnection(s);
                con.Open();
            
        }

        void filldatalist()
        {
            Getcon();
            da = new SqlDataAdapter("select * from Add_Company_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_cmid")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("ShowProducts.aspx?cid=" + id);
            }
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DataList1_ItemCommand1(object source, DataListCommandEventArgs e)
        {

        }

        protected void btnCompanyPDF_Click(object sender, EventArgs e)
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

            Paragraph title = new Paragraph("MobileHub -- Companies List", titleFont);
            title.Alignment = Element.ALIGN_CENTER;
            doc.Add(title);
            doc.Add(new Paragraph("Total: " + ds2.Tables[0].Rows.Count + " companies   |   " + DateTime.Now.ToString("dd-MM-yyyy"),
                FontFactory.GetFont(FontFactory.HELVETICA, 9, BaseColor.GRAY)));
            doc.Add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(5);
            table.WidthPercentage = 100;
            table.SetWidths(new float[] { 0.7f, 2f, 2f, 2.5f, 2.5f });
            BaseColor purple = new BaseColor(107, 63, 160);
            foreach (string h in new[] { "ID", "Company Name", "Owner Name", "Email", "Address" })
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
            Response.AddHeader("content-disposition", "attachment;filename=CompaniesList.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}