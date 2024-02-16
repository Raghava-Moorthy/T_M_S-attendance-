using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Attendance
{
    public partial class tutorr : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connectionString = "Data Source=RAGHAVA\\MSSQLSERVER02;Initial Catalog=attendance;Integrated Security=True";
                string query = "SELECT * FROM Student_Leave WHERE Status_ = 'Pending'";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        connection.Open();

                        DataTable dt = new DataTable();

                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(dt);
                        }

                        notification.DataSource = dt;
                        notification.DataBind();

                        connection.Close();
                    }
                }
            }
        }

        protected void Accept_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=RAGHAVA\\MSSQLSERVER02;Initial Catalog=attendance;Integrated Security=True";
            Button acceptButton = (Button)sender;
            string notificationID = acceptButton.CommandArgument;
            RepeaterItem item = (RepeaterItem)acceptButton.NamingContainer;
            Label regNoLabel = (Label)item.FindControl("RegNoLabel");
            Label idLabel = (Label)item.FindControl("IDLabel");

            string regNo = regNoLabel.Text;
            int notificationId = Convert.ToInt32(idLabel.Text); 
            string updateQuery = "UPDATE Student_Leave SET Status_ = 'Accept' WHERE ID = @ID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@ID", notificationId);

                    connection.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    connection.Close();

                    if (rowsAffected > 0)
                    {
                        string updatedMessage = "Request Updated";
                        UpdateNotificationMessage(notificationId, updatedMessage);
                        BindNotifications(); 
                    }
                    else
                    {
                        Response.Write("Update Failed");
                    }
                }
            }
        }

        private void UpdateNotificationMessage(int notificationID, string updatedMessage)
        {
            string script = $"updateNotificationMessage('{notificationID}', '{updatedMessage}')";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "updateNotificationMessage", script, true);
        }

        private void BindNotifications()
        {
            string connectionString = "Data Source=RAGHAVA\\MSSQLSERVER02;Initial Catalog=attendance;Integrated Security=True";
            string query = "SELECT * FROM Student_Leave WHERE Status_ = 'Pending'";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();

                    DataTable dt = new DataTable();

                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dt);
                    }
                    notification.DataSource = dt;
                    notification.DataBind();

                    connection.Close();
                }
            }
        }

        protected void Reject_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=RAGHAVA\\MSSQLSERVER02;Initial Catalog=attendance;Integrated Security=True";
            Button acceptButton = (Button)sender;
            string notificationID = acceptButton.CommandArgument;
            RepeaterItem item = (RepeaterItem)acceptButton.NamingContainer;
            Label regNoLabel = (Label)item.FindControl("RegNoLabel");
            Label idLabel = (Label)item.FindControl("IDLabel");

            string regNo = regNoLabel.Text;
            int notificationId = Convert.ToInt32(idLabel.Text); 

            string updateQuery = "UPDATE Student_Leave SET Status_ = 'Reject' WHERE ID = @ID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@ID", notificationId); 

                    connection.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    connection.Close();

                    if (rowsAffected > 0)
                    {
                        string updatedMessage = "Request Updated";
                        UpdateNotificationMessage(notificationId, updatedMessage);
                        BindNotifications(); 
                    }
                    else
                    {
                        Response.Write("Update Failed");
                    }
                }
            }

        }
    }
}
