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
    }
}
