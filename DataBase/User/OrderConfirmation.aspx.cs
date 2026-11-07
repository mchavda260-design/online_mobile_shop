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
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        int uid = 1;
        string nm;

        string s = ConfigurationManager.ConnectionStrings["ya"].ConnectionString;

        void Getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillCartGrid()
        {
            Getcon();
            da = new SqlDataAdapter(
                "select c.Cart_Id, p.Prod_Name, p.Prod_Price, p.Prod_Img, c.Quantity " +
                "from Add_Products_tbl p " +
                "INNER JOIN cart_tbl c ON p.Prod_Id = c.Cart_Prod_Id " +
                "where c.Cart_User_Id = '" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();

            decimal subtotal = 0;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                subtotal += Convert.ToDecimal(row["Prod_Price"]) * Convert.ToInt32(row["Quantity"]);
            }

            decimal delivery = 200;
            decimal grandtotal = subtotal + delivery;

            lblSubtotal.Text  = "₹" + subtotal.ToString("0.00");
            lblDelivery.Text  = "₹" + delivery.ToString("0.00");
            lblGrandTotal.Text = "₹" + grandtotal.ToString("0.00");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                Getcon();

                da = new SqlDataAdapter(
                    "Select * from emp_tbl where Email = '" + Session["Admin"] + "' or Name = '" + Session["Admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm  = ds.Tables[0].Rows[0]["Name"].ToString();
                    uid = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);

                    lblWelcome.Text = "Welcome, " + nm + "  ✔";
                    lblName.Text    = nm;
                    lblMobile.Text  = ds.Tables[0].Rows[0]["Mobile"].ToString();
                    lblAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                }

                if (!IsPostBack)
                {
                    fillCartGrid();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string payMethod = "Cash on Delivery";
            if (rbOnline.Checked) payMethod = "Online Payment";
            else if (rbUPI.Checked) payMethod = "UPI";

            string grandTotalStr = lblGrandTotal.Text.Replace("₹", "").Trim();
            decimal grandTotal = Convert.ToDecimal(grandTotalStr);

            
            Getcon();
            da = new SqlDataAdapter(
                "SELECT Cart_Prod_Id, Quantity FROM cart_tbl WHERE Cart_User_Id = '" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMsg.Text = "⚠️ Cart ખાલી છે! પહેલા product add કરો.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            
            cmd = new SqlCommand("SELECT ISNULL(MAX(Order_No), 0) + 1 FROM Order_tbl", con);
            int nextOrderNo = Convert.ToInt32(cmd.ExecuteScalar());

            string address = lblAddress.Text;
            string orderDate = DateTime.Now.ToString("yyyy-MM-dd");

            
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                int prodId   = Convert.ToInt32(row["Cart_Prod_Id"]);
                int quantity = Convert.ToInt32(row["Quantity"]);

                cmd = new SqlCommand(
                    "INSERT INTO Order_tbl (Order_No, Order_User_Id, Order_Prod_Id, Quantity, Pay_Method, Pay_Status, Ship_Address, Order_Date) " +
                    "VALUES ('" + nextOrderNo + "', '" + uid + "', '" + prodId + "', '" + quantity + "', '" + payMethod + "', 'Pending', '" + address + "', '" + orderDate + "')", con);
                cmd.ExecuteNonQuery();
            }

            
            cmd = new SqlCommand("DELETE FROM cart_tbl WHERE Cart_User_Id = '" + uid + "'", con);
            cmd.ExecuteNonQuery();

            lblMsg.Text      = "✅ Order Placed Successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;

            Response.AddHeader("Refresh", "2;URL=Order details.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}
