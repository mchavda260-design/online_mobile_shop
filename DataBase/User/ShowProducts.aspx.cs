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
    public partial class ShowProducts : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        int uid;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        void Getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        
        void LoadUserId()
        {
            if (Session["Admin"] != null)
            {
                Getcon();
                da = new SqlDataAdapter(
                    "Select * from emp_tbl where Email = '" + Session["Admin"] +
                    "' or Name = '" + Session["Admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    uid = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            LoadUserId();

            if (!IsPostBack)
            {
                filldatalist();
            }
        }

        void filldatalist()
        {
            Getcon();
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                da = new SqlDataAdapter("select * from Add_Products_tbl where Prod_Comp_Id='" + Request.QueryString["cid"] + "'", con);
            }
            else
            {
                da = new SqlDataAdapter("select * from Add_Products_tbl", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            DataListProducts.DataSource = ds;
            DataListProducts.DataBind();
        }

        protected void Datalist_ItemCommand(object source, DataListCommandEventArgs e)
        {
            
            if (Session["Admin"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            
            LoadUserId();

            if (e.CommandName == "cmd_vdtl")
            {
                int pid = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("viewdetails.aspx?pid=" + pid);
            }
            else if (e.CommandName == "cmd_cart")
            {
                int prodId = Convert.ToInt32(e.CommandArgument);
                int quantity = 1;

                
                Getcon();
                SqlCommand checkCmd = new SqlCommand(
                    "select COUNT(*) from cart_tbl where Cart_User_Id=" + uid +
                    " AND Cart_Prod_Id=" + prodId, con);
                int exists = (int)checkCmd.ExecuteScalar();

                if (exists > 0)
                {
                    
                    cmd = new SqlCommand(
                        "update cart_tbl set Quantity = Quantity + 1 where Cart_User_Id=" +
                        uid + " AND Cart_Prod_Id=" + prodId, con);
                }
                else
                {
                    
                    cmd = new SqlCommand(
                        "insert into cart_tbl(Cart_User_Id, Cart_Prod_Id, Quantity, AddedDate) values(" +
                        uid + "," + prodId + "," + quantity + ", Getdate())", con);
                }

                cmd.ExecuteNonQuery();
                Response.Redirect("addtocart.aspx");
            }
        }

        protected void DataListProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

       
        protected void DataListProducts_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
                e.Item.ItemType == ListItemType.AlternatingItem)
            {
                System.Web.UI.WebControls.Image imgProduct =
                    (System.Web.UI.WebControls.Image)e.Item.FindControl("imgProduct");

                if (imgProduct != null)
                {
                    DataRowView drv = (DataRowView)e.Item.DataItem;
                    string imgPath = drv["Prod_Img"].ToString();

                    if (!string.IsNullOrEmpty(imgPath))
                    {
                        
                        imgProduct.ImageUrl = ResolveUrl(imgPath);
                    }
                    else
                    {
                        imgProduct.ImageUrl = ResolveUrl("~/Product_Images/default.png");
                    }
                }
            }
        }

        protected void btnProductPDF_Click(object sender, EventArgs e)
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

            Paragraph title = new Paragraph("MobileHub -- Products List", titleFont);
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
            Response.AddHeader("content-disposition", "attachment;filename=ProductsList.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}