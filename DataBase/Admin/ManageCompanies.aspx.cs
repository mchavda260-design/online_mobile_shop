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
    public partial class ManageCompanies : System.Web.UI.Page
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
            da = new SqlDataAdapter("select * from Add_Company_tbl", con);
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
            int cid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            GridViewRow row = GridView1.Rows[e.RowIndex];

            string compName   = ((TextBox)row.Cells[1].Controls[0]).Text;
            string ownerName  = ((TextBox)row.Cells[2].Controls[0]).Text;
            string compEmail  = ((TextBox)row.Cells[3].Controls[0]).Text;
            string compAddr   = ((TextBox)row.Cells[4].Controls[0]).Text;

            getcon();
            cmd = new SqlCommand("update Add_Company_tbl set Comp_Name='" + compName + "', Comp_Owner_Name='" + ownerName + "', Comp_Email='" + compEmail + "', Comp_address='" + compAddr + "' where Comp_Id='" + cid + "'", con);
            cmd.ExecuteNonQuery();

            GridView1.EditIndex = -1;
            fillgrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            getcon();
            cmd = new SqlCommand("delete from Add_Company_tbl where Comp_Id='" + cid + "'", con);
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
