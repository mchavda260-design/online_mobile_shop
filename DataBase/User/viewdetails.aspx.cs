using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataBase.User
{
    public partial class viewdetails : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void filldatalist()
        {
            getcon();
            da = new SqlDataAdapter("select * from Add_products_tbl where Prod_Id=" + Request.QueryString["pid"] + " ", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                filldatalist();
            }
        }

        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;

                System.Web.UI.WebControls.Image imgControl = (System.Web.UI.WebControls.Image)e.Item.FindControl("Image1");
                if (imgControl != null)
                {
                    string imgPath = row["Prod_Img"] != DBNull.Value ? row["Prod_Img"].ToString() : "";
                    if (!string.IsNullOrEmpty(imgPath))
                    {
                        imgControl.ImageUrl = ResolveUrl(imgPath);
                    }
                    else
                    {
                        imgControl.ImageUrl = ResolveUrl("~/Product_Images/default.png");
                    }
                }
            }
        }
    }
}