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
    public partial class ManageEmployees : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from emp_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        void clear()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtPhone.Text = "";
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into emp_tbl(Name, Email, Password, Phone) values('" + txtName.Text + "','" + txtEmail.Text + "','" + txtPassword.Text + "','" + txtPhone.Text + "')", con);
            cmd.ExecuteNonQuery();
            clear();
            fillgrid();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            fillgrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            fillgrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int eid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            GridViewRow row = GridView1.Rows[e.RowIndex];

            string empName  = ((TextBox)row.Cells[1].Controls[0]).Text;
            string empEmail = ((TextBox)row.Cells[2].Controls[0]).Text;
            string empPass  = ((TextBox)row.Cells[3].Controls[0]).Text;
            string empPhone = ((TextBox)row.Cells[4].Controls[0]).Text;

            getcon();
            cmd = new SqlCommand("update emp_tbl set Name='" + empName + "', Email='" + empEmail + "', Password='" + empPass + "', Phone='" + empPhone + "' where Emp_Id='" + eid + "'", con);
            cmd.ExecuteNonQuery();

            GridView1.EditIndex = -1;
            fillgrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int eid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            getcon();
            cmd = new SqlCommand("delete from emp_tbl where Emp_Id='" + eid + "'", con);
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
