using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration; // for connection string
using System.Data; // for dataset
using System.Data.SqlClient; // for connecting to sql server

namespace DataBase.User
{
    public partial class ShowCompany : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
           
                filldatalist();
            
        }

        void Getcon()
        {
           
                con = new SqlConnection(s);
                con.Open();
            
        }

        void filldatalist()
        {
            Getcon();
            da = new SqlDataAdapter("select * from Add_Company_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            DataList1.DataSource = ds;
            DataList1.DataBind();
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_cmid")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("ShowProducts.aspx?cid=" + id);
            }
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DataList1_ItemCommand1(object source, DataListCommandEventArgs e)
        {

        }
    }
}
