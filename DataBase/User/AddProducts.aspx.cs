using System;
using System.Collections.Generic;
using System.Configuration;// for connection string
using System.Data; // for dataset
using System.Data.SqlClient;// for connecting to sql server
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataBase.User
{
    public partial class AddProducts : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm, nm;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        void getcon()
        {
           
                con = new SqlConnection(s);
                con.Open();
            
        }

        void imgupload()
        {
            if (fuProductImage.HasFile)
            {
                string ext = System.IO.Path.GetExtension(fuProductImage.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif" || ext == ".webp")
                {
                    string fileName = System.IO.Path.GetFileName(fuProductImage.FileName);
                    string savePath = Server.MapPath("~/Product_Images/") + fileName;
                    fuProductImage.SaveAs(savePath);
                    fnm = "~/Product_Images/" + fileName;
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

        void fillcombo()
        {
            getcon();
            da = new SqlDataAdapter("select * from Add_Company_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            drpcid.DataSource = ds;
            drpcid.DataTextField = "Comp_Name";
            drpcid.DataValueField = "Comp_Id";
            drpcid.DataBind();
            drpcid.Items.Insert(0, new ListItem("-- Select Company --", "0"));
        }

        void clear()
        {
            drpcid.SelectedIndex = 0;
            pnm.Text = "";
            pmdl.Text = "";
            pdecs.Text = "";
            twgt.Text = "";
            pconfi.Text = "";
            pprice.Text = "";
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            if (drpcid.SelectedValue != "0")
            {
                getcon();
                imgupload();
                cmd = new SqlCommand("insert into Add_Products_tbl(Prod_Comp_id, Prod_Name, Prod_Model, Prod_Desc, Prod_Weight, Prod_Config, Prod_Img, Prod_Price) values('" + drpcid.SelectedValue + "','" + pnm.Text + "','" + pmdl.Text + "','" + pdecs.Text + "','" + twgt.Text + "','" + pconfi.Text + "','" + fnm + "','" + pprice.Text + "')", con);
                
                
                
                cmd.ExecuteNonQuery();
                clear();
            }
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
                    Label1.Text = "welcome : " + nm;
                }

                if (!IsPostBack)
                {
                    fillcombo();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }
}