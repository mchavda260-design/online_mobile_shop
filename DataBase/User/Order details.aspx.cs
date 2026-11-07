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
    public partial class Order_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        int uid = 1;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        void Getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                Getcon();

                // Get user info from emp_tbl (notes: select * from emp_tbl where Email = Session["admin"] + '' + '')
                da = new SqlDataAdapter("select * from emp_tbl where Email = '" +
                    Session["Admin"].ToString() + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string nm = ds.Tables[0].Rows[0]["Name"].ToString();
                    uid = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);

                    lblWelcome.Text = "Welcome, " + nm + "  ✔";

                    // Set user labels
                    lblname.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                    lblmobile.Text = ds.Tables[0].Rows[0]["Mobile"].ToString();
                    lbladdress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                    lblemail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                    lblorderdate.Text = DateTime.Now.ToString("dd MMM yyyy");
                }

                fillordergrid();
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        void fillordergrid()
        {
            Getcon();

            // Get User Id first
            SqlDataAdapter da2 = new SqlDataAdapter("select * from emp_tbl" +
                " where Email = '" + Session["Admin"].ToString() + "'", con);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            if (ds2.Tables[0].Rows.Count > 0)
            {
                uid = Convert.ToInt32(ds2.Tables[0].Rows[0]["Id"]);
            }

            
            da = new SqlDataAdapter(
                "Select p.Prod_Name, p.Prod_Price, p.Prod_Img, c.Quantity," +
                " (p.Prod_Price * c.Quantity) as Total" +
                " from Add_Products_tbl p INNER" +
                " JOIN cart_tbl c ON" +
                " p.Prod_Id = c.Cart_Prod_Id" +
                " Where c.Cart_User_Id = '" + uid + "'" +
                " ", con);
            ds = new DataSet();
            da.Fill(ds);

            GridView1.DataSource = ds;  
            GridView1.DataBind();       

            decimal subtotal = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                subtotal += Convert.ToDecimal(row["Total"]);
            }
            lblsubtotal.Text = "₹" + subtotal.ToString("0.00");

            
            decimal delivery = 200;
            lbldelivery.Text = "₹" + delivery.ToString("0.00");

            decimal grandtotal = subtotal + delivery;
            lblBillGrandTotal.Text = "₹" + grandtotal.ToString("0.00");

            // Summary card stats
            int totalItems = ds.Tables[0].Rows.Count;
            lblTotalItems.Text = totalItems.ToString();
            lblGrandTotal.Text = "₹" + grandtotal.ToString("0.00");

            if (totalItems > 0)
            {
                lblLatestDate.Text = DateTime.Now.ToString("dd MMM");
                pnlTotal.Visible = true;
            }
            else
            {
                pnlTotal.Visible = false;
                lblLatestDate.Text = "—";
            }

            lblTotalAmount.Text = "₹" + grandtotal.ToString("0.00");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}