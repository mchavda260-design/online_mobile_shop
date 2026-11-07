using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// add new namespace for db 
using System.Data.SqlClient;// for connecting to sql server
using System.Data; // for dataset
using System.Configuration;// for connection string

namespace DataBase
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con; // for connection
        SqlDataAdapter da;// for container
        DataSet ds;//for select
        SqlCommand cmd;// inmsert , update , delete

        string fnm;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;
        string a = "path";
        protected void Page_Load(object sender, EventArgs e)
        {
            Getcon();
            
        }

        void Getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void imgupload()
        {
            
                fnm = "~/images/" + FileUpload1.FileName;
                FileUpload1.SaveAs(Server.MapPath(fnm));
            }
           
        void clear()
        {
            txtnm.Text = "";
            rdbgen.SelectedIndex = -1;
            txtemil.Text = "";
            txtpass.Text = "";
            DropDownList1.SelectedIndex = -1;
            txtadd.Text = "";
            txtmob.Text = "";
           
        }

        
        protected void btnsub_Click(object sender, EventArgs e)
        {
            if (Button1.Text == "Submit")
            {
                imgupload();
                Getcon();
                cmd = new SqlCommand("insert into emp_tbl(Name,Gender,Email,City,Address,Mobile,Image,Password)values('" + txtnm.Text + "','" + rdbgen.SelectedItem.Text + "','" + txtemil.Text + "','" + DropDownList1.SelectedItem.Text + "','" + txtadd.Text + "','" + txtmob.Text + "','" + fnm + "','" + txtpass.Text + "')", con);
                cmd.ExecuteNonQuery();
                clear();
               
                
            }
            
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
            }
        }
    }



