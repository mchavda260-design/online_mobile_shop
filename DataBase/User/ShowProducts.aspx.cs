using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

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

        // Session માંથી real user ID fetch કરો
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
            // Session expire check
            if (Session["Admin"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // uid reload (PostBack વખતે)
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

                // Already in cart check
                Getcon();
                SqlCommand checkCmd = new SqlCommand(
                    "select COUNT(*) from cart_tbl where Cart_User_Id=" + uid +
                    " AND Cart_Prod_Id=" + prodId, con);
                int exists = (int)checkCmd.ExecuteScalar();

                if (exists > 0)
                {
                    // Already in cart — quantity update
                    cmd = new SqlCommand(
                        "update cart_tbl set Quantity = Quantity + 1 where Cart_User_Id=" +
                        uid + " AND Cart_Prod_Id=" + prodId, con);
                }
                else
                {
                    // New item insert
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

        // ✅ Image path fix — ~/  ને proper URL માં convert કરો
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
                        // ~/Product_Images/xxx.jpg  →  /Product_Images/xxx.jpg
                        imgProduct.ImageUrl = ResolveUrl(imgPath);
                    }
                    else
                    {
                        imgProduct.ImageUrl = ResolveUrl("~/Product_Images/default.png");
                    }
                }
            }
        }
    }
}
