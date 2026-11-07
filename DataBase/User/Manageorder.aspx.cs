using System;
using System.Collections.Generic;
using System.Configuration; // for connection string
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

        void fillOrderAdminGrid()
        {
            getcon();

            String q = @"SELECT o.Order_Id, o.Order_User_Id As User_Id,
                        e.Name As User_Name,
                        c.Cart_Id, c.Cart_Prod_Id, p.Prod_Name,
                        c.Quantity, o.Order_Date,
                        o.Pay_Method, o.Pay_Status,
                        o.Ship_Address
                        FROM Order_tbl o
                        INNER JOIN emp_tbl e ON o.Order_User_Id = e.Id
                        INNER JOIN cart_tbl c ON o.Order_User_Id = c.Cart_User_Id
                        INNER JOIN Add_Products_tbl p ON c.Cart_Prod_Id = p.Prod_Id
                        ORDER BY o.Order_Date DESC, o.Order_Id DESC";

            da = new SqlDataAdapter(q, con);
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
                    fillOrderAdminGrid();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int orderid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            getcon();
            cmd = new SqlCommand("delete from Order_tbl where Order_Id='" + orderid + "'", con);
            cmd.ExecuteNonQuery();

            fillOrderAdminGrid();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["Admin"] = null;
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
