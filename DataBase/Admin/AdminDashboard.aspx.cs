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
    public partial class AdminDashboard : System.Web.UI.Page
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
                    fillcounts();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        void fillcounts()
        {
            // Company count
            getcon();
            cmd = new SqlCommand("select count(*) from Add_Company_tbl", con);
            lblCompanyCount.Text = cmd.ExecuteScalar().ToString();

            // Product count
            getcon();
            cmd = new SqlCommand("select count(*) from Add_Products_tbl", con);
            lblProductCount.Text = cmd.ExecuteScalar().ToString();

            // Employee count
            getcon();
            cmd = new SqlCommand("select count(*) from emp_tbl", con);
            lblEmployeeCount.Text = cmd.ExecuteScalar().ToString();

            // Orders / Cart count
            getcon();
            cmd = new SqlCommand("select count(*) from cart_tbl", con);
            lblOrderCount.Text = cmd.ExecuteScalar().ToString();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["Admin"] = null;
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
