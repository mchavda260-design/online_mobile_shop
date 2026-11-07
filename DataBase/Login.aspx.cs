using System;
using System.Collections.Generic;
using System.Configuration;// for connection string
using System.Data; // for dataset
// add new namespace for db 
using System.Data.SqlClient;// for connecting to sql server
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataBase
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con; // for connection
        SqlDataAdapter da;// for container
        DataSet ds;//for select
        SqlCommand cmd;// inmsert , update , delete

        string nm;
        int i;

        string s = ConfigurationManager
            .ConnectionStrings["ya"]
            .ConnectionString;
        string a = "path";
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
                    Label6.Text = "welcome : " + nm;
                }
            }
        }

        void Getcon()
        {
            
                con = new SqlConnection(s);
                con.Open();
            
        }









        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!(String.IsNullOrEmpty(TextBox1.Text)) && !(string.IsNullOrEmpty(TextBox2.Text)))
            {
                Getcon();
                cmd = new SqlCommand("select count(*) from emp_tbl where (Email='" + TextBox1.Text + "' or Name='" + TextBox1.Text + "') and Password='" + TextBox2.Text + "'", con);
                i = Convert.ToInt32(cmd.ExecuteScalar());

                if (i > 0)
                {
                    Session["Admin"] = TextBox1.Text;
                    Response.Redirect("User/UserDashboard.aspx");
                }
                else
                {
                    Label6.Text = "Invalid Username & Password";
                }
            }
        }
    }
}