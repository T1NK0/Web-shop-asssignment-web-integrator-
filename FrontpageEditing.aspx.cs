using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FrontpageEditing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RepeaterFrontpageTexts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Slet")
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;

            cmd.CommandText = @"DELETE FROM pages WHERE page_id = @page_id";
            cmd.Parameters.AddWithValue("@page_id", e.CommandArgument);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("FrontpageEditing.aspx");
        }

        if (e.CommandName == "Ret")
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            SqlCommand cmd = new SqlCommand("SELECT * FROM pages WHERE page_id = @page_id", conn);
            cmd.Parameters.AddWithValue("@page_id", e.CommandArgument);
            ViewState["page_id"] = e.CommandArgument;

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                TextBoxTitle.Text = reader["page_headings"].ToString();
                TextBoxDescription.Text = reader["page_text"].ToString().Replace("<br>", Environment.NewLine); ;
                TextBoxOpeningHours.Text = reader["opening_hours"].ToString().Replace("<br>", Environment.NewLine);
                TextBoxOpeningChanges.Text = reader["opening_changes"].ToString().Replace("<br>", Environment.NewLine); ;
                TextBoxContactInfo.Text = reader["contact_info"].ToString().Replace("<br>", Environment.NewLine); ;

                Image1.ImageUrl = "~/images/frontpage/" + reader["page_images"].ToString();
                HiddenFieldGem.Value = reader["page_images"].ToString();
            }
            conn.Close();
            ButtonUpload.Visible = false;
            ButtonGem.Visible = true;

        }
    }

    protected void ButtonUpload_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;

        cmd.CommandText = @"INSERT INTO pages (page_text, page_images, page_headings, opening_hours, opening_changes, contact_info) VALUES (@p_text, @p_image, @p_heading, @opening_hours, @opening_changes, @contact_info)";
        cmd.Parameters.AddWithValue("@p_heading", TextBoxTitle.Text);
        cmd.Parameters.AddWithValue("@p_text", TextBoxDescription.Text.Replace(Environment.NewLine, "<br>"));
        cmd.Parameters.AddWithValue("@opening_changes", TextBoxOpeningChanges.Text.Replace(Environment.NewLine, "<br>"));
        cmd.Parameters.AddWithValue("@opening_hours", TextBoxOpeningHours.Text.Replace(Environment.NewLine, "<br>"));
        cmd.Parameters.AddWithValue("@contact_info", TextBoxContactInfo.Text.Replace(Environment.NewLine, "<br>"));

        #region image1
        //database sti til billede
        string bill_sti = "intetbillede.jpg";
        if (FileUploadImage.HasFile)
        {
            //NewGuid danner uniq navn for billeder
            bill_sti = Guid.NewGuid() + Path.GetExtension(FileUploadImage.FileName);
            // Opret
            String UploadeMappe = Server.MapPath("~/images/frontpage/");
            String Filnavn = DateTime.Now.ToFileTime() + FileUploadImage.FileName;
            bill_sti = Filnavn;
            //Gem det orginale Billede
            FileUploadImage.SaveAs(UploadeMappe + Filnavn);
        }
        // Tildel parameter-værdierne, fra input felterne.
        cmd.Parameters.AddWithValue("@p_image", bill_sti);
        #endregion

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("FrontpageEditing.aspx");
    }
    protected void ButtonGem_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = conn;

        cmd.CommandText = @"UPDATE pages SET page_text = @text, page_headings = @heading, opening_hours = @opening_hours, page_images = @p_image, opening_changes = @opening_changes, contact_info = @contact_info WHERE page_id = @page_id";
        cmd.Parameters.AddWithValue("@page_id", ViewState["page_id"]);
        cmd.Parameters.AddWithValue("@heading", TextBoxTitle.Text);
        cmd.Parameters.AddWithValue("@text", TextBoxDescription.Text.Replace(Environment.NewLine, "<br>"));
        cmd.Parameters.AddWithValue("@opening_changes", TextBoxOpeningChanges.Text.Replace(Environment.NewLine, "<br>"));
        cmd.Parameters.AddWithValue("@opening_hours", TextBoxOpeningHours.Text.Replace(Environment.NewLine, "<br>"));
        cmd.Parameters.AddWithValue("@contact_info", TextBoxContactInfo.Text.Replace(Environment.NewLine, "<br>"));


        #region Image 1
        string product_image1 = HiddenFieldGem.Value;
        if (FileUploadImage.HasFile)
        {
            //NewGuid danner uniq navn for billeder
            product_image1 = Guid.NewGuid() + Path.GetExtension(FileUploadImage.FileName);
            // Opret
            String UploadeMappe = Server.MapPath("~/images/frontpage/");
            String Filnavn = DateTime.Now.ToFileTime() + FileUploadImage.FileName;
            product_image1 = Filnavn;

            FileUploadImage.SaveAs(UploadeMappe + Filnavn);

            string old_img = HiddenFieldGem.Value;
            if (File.Exists(Server.MapPath("~/images/frontpage/") + old_img))
            {
                File.Delete(Server.MapPath("~/images/frontpage/") + old_img);
            }
        }
        cmd.Parameters.AddWithValue("@p_image", product_image1);
        #endregion
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("FrontpageEditing.aspx");
    }
}