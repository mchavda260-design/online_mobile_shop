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
    }
}