using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace CurdMachineTest
{
    public partial class RegistartionForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Defaultconn"].ConnectionString);
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayCountry();
                //btnsubmit.Enabled = false;
                //DisplayState();
                DispalyGender();
                ddlcountry.Items.Insert(0,new ListItem("select country", "0"));
                //ddlstate.Items.Insert(0,new ListItem("Select State--","0"));
                ShowAllRecord();
                Reset();
            }
        }

       public void DisplayCountry()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_countrydata", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cmd.ExecuteNonQuery();
            con.Close();
            ddlcountry.DataTextField = "cname";
            ddlcountry.DataValueField = "cid";
            ddlcountry.DataSource = dt;
            ddlcountry.Items.Insert(0,new ListItem("select Country","0"));
            //ddlcountry.Items.Insert(0,"--Select Country");
            ddlcountry.DataBind();
        }
        public void DisplayState()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_statedata", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@cid",ddlcountry.SelectedValue);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            ddlstate.DataTextField = "sname";
            ddlstate.DataValueField = "sid";
            ddlstate.DataSource = dt;
            ddlstate.Items.Insert(0, new ListItem("--select--", "0"));
            //ddlstate.Items.Insert(0,"select state");
            ddlstate.DataBind();
        }

        public void DispalyGender()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_genderdata", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            rblgender.DataTextField = "gname";
            rblgender.DataValueField = "gid";
            rblgender.DataSource = dt;
            rblgender.DataBind();
        }

        protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayState();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            //if(txtFname.Text != "" && txtLname.Text!=""&& rblgender.SelectedValue!=""&& txtmobileno.Text!=""&& txtemail.Text!="" &&ddlcountry.SelectedValue!=""&&ddlstate.SelectedValue!=""&&cbTandC.Text!="")
            //{
                 
            //}
            if (btnsubmit.Text=="Submit")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_InsertUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("firstname", txtFname.Text);
                cmd.Parameters.AddWithValue("lastname", txtLname.Text);
                cmd.Parameters.AddWithValue("gender", rblgender.SelectedValue);
                cmd.Parameters.AddWithValue("contactno", txtmobileno.Text);
                cmd.Parameters.AddWithValue("email", txtemail.Text);
                cmd.Parameters.AddWithValue("country", ddlcountry.SelectedValue);
                cmd.Parameters.AddWithValue("state", ddlstate.SelectedValue);
                cmd.Parameters.AddWithValue("TandC", cbTandC.Checked);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_InsertUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("eid", ViewState["eid"]);
                cmd.Parameters.AddWithValue("firstname",txtFname.Text);
                cmd.Parameters.AddWithValue("lastname",txtLname.Text);
                cmd.Parameters.AddWithValue("gender",rblgender.SelectedValue);
                cmd.Parameters.AddWithValue("contactno",txtmobileno.Text);
                cmd.Parameters.AddWithValue("email",txtemail.Text);
                cmd.Parameters.AddWithValue("country",ddlcountry.SelectedValue);
                cmd.Parameters.AddWithValue("state",ddlstate.SelectedValue);
                cmd.Parameters.AddWithValue("TandC",cbTandC.Checked);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            ShowAllRecord();
            Reset();
        }

        protected void grdview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName== "CmdDelet")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_DeleteRecord", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@eid",e.CommandArgument);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_Editrecord", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@eid",e.CommandArgument);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                con.Close();
                txtFname.Text = dt.Rows[0]["firstname"].ToString();
                txtLname.Text = dt.Rows[0]["lastname"].ToString();
                rblgender.SelectedValue = dt.Rows[0]["gender"].ToString();
                ddlcountry.SelectedValue = dt.Rows[0]["country"].ToString();
                DisplayState();
               // ddlstate.SelectedValue = dt.Rows[0]["state"].ToString();
                //cbTandC.Checked = dt.Rows[0]["TandC"].ToString();
                txtemail.Text = dt.Rows[0]["Email"].ToString();
                txtmobileno.Text = dt.Rows[0]["contactno"].ToString();
                ViewState["eid"] = e.CommandArgument;
                btnsubmit.Text = "Update";
                btnsubmit.Enabled = true;
                // Convert TandC column value to boolean and set the checkbox
                bool tandcValue;
                if (bool.TryParse(dt.Rows[0]["TandC"].ToString(), out tandcValue))
                {
                    cbTandC.Checked = tandcValue;
                }
                else
                {
                    // Default to false if conversion fails
                    cbTandC.Checked = false;
                }

            }
            ShowAllRecord();
        }

        public void ShowAllRecord()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_showAlldata", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            grdview.DataSource = dt;
            grdview.DataBind();
        }

        public void Reset()
        {
            txtFname.Text = "";
            txtLname.Text = "";
            txtemail.Text = "";
            txtmobileno.Text = "";
            rblgender.ClearSelection();
            //ddlcountry.SelectedIndex = 0;
            //ddlstate.SelectedIndex = 0;
            cbTandC.Checked=false;
        }
    }
}