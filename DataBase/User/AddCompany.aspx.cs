using System;
using System.Reflection.Emit;
using System.Web.UI;
using System.Web.UI.WebControls;
// add new namespace for db 
using System.Data.SqlClient;// for connecting to sql server
using System.Data; // for dataset
using System.Configuration;// for connection string

namespace  DataBase.User
{
    public partial class AddCompany : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds; 
        SqlCommand cmd;
        string fnm, nm;
        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;
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
                    Label1.Text = "welcome : " + nm;
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void imgupload()
        {
            if (fimg.HasFile)
            {
                string ext = System.IO.Path.GetExtension(fimg.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif" || ext == ".webp")
                {
                    string fileName = System.IO.Path.GetFileName(fimg.FileName);
                    string savePath = Server.MapPath("~/Comp_Images/") + fileName;
                    fimg.SaveAs(savePath);
                    fnm = "~/Comp_Images/" + fileName;
                    Label1.Text = "Image uploaded successfully!";
                }
                else
                {
                    fnm = "";
                    Label1.Text = "Error: Only JPG, PNG, GIF, WEBP files allowed!";
                }
            }
            else
            {
                fnm = "";
            }
        }


        void clear()
        {
            txtnm.Text = "";
            txtonm.Text = "";
            txteml.Text = "";
            txtadd.Text = "";
        }


        protected void btnAddCompany_Click(object sender, EventArgs e)
        {

            getcon();
            imgupload();
            cmd = new SqlCommand("insert into Add_Company_tbl(Comp_Name,Comp_Owner_Name,Comp_Email,Comp_address,Comp_Cover_img) values('" + txtnm.Text + "','" + txtonm.Text + "','" + txteml.Text + "','" + txtadd.Text + "','" + fnm + "')", con);
            cmd.ExecuteNonQuery();
            clear();



        }
    }
}