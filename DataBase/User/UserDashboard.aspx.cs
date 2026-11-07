using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace DataBase.User
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
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
                // Welcome message
                getcon();
                da = new SqlDataAdapter("Select * from emp_tbl where Email = '" + Session["Admin"] + "' or Name = '" + Session["Admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["Name"].ToString();
                    lblWelcome.Text = "Welcome, " + nm + "!";
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

            // ✅ Cart count — ફક્ત logged-in user ની items
            getcon();
            // પહેલા logged-in user નો Id મેળવો
            SqlCommand cmdUserId = new SqlCommand(
                "SELECT Id FROM emp_tbl WHERE Email='" + Session["Admin"] +
                "' OR Name='" + Session["Admin"] + "'", con);
            object userIdObj = cmdUserId.ExecuteScalar();
            if (userIdObj != null && userIdObj != DBNull.Value)
            {
                int userId = Convert.ToInt32(userIdObj);
                getcon();
                cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM cart_tbl WHERE Cart_User_Id=" + userId, con);
                lblCartCount.Text = cmd.ExecuteScalar().ToString();
            }
            else
            {
                lblCartCount.Text = "0";
            }

            // Employee count
            getcon();
            cmd = new SqlCommand("select count(*) from emp_tbl", con);
            lblEmployeeCount.Text = cmd.ExecuteScalar().ToString();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["Admin"] = null;
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
