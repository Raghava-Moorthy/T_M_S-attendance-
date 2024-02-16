using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Attendance
{
    public partial class Student : System.Web.UI.Page
    {
        string connectionString = "Data Source=RAGHAVA\\MSSQLSERVER02;Initial Catalog=attendance;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowNotifications();
        }
        protected void LeaveSend_Click(object sender, EventArgs e)
        {
            string reasonForLeave = txtReasonForLeave.Value;
            string leaveLetterUrl = txtLeaveLetterUrl.Value;
            string selectedDate = dateInput.Value;
            string numberOfDays = days.SelectedValue;
            string Status_ = "Pending";
            string RegNo = "2115003";
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string insertQuery = "INSERT INTO Student_Leave (RegNo, Reason, LetterUrl, LeaveDate, NumberOfDays, Status_, Apply_) " +
                        "VALUES (@RegNo, @Reason, @LeaveUrl, @LeaveDate, @Days, @Status_, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, connection))
                    {
                        cmd.Parameters.AddWithValue("@Reason", reasonForLeave);
                        cmd.Parameters.AddWithValue("@LeaveUrl", leaveLetterUrl);
                        cmd.Parameters.AddWithValue("@LeaveDate", selectedDate);
                        cmd.Parameters.AddWithValue("@Days", numberOfDays);
                        cmd.Parameters.AddWithValue("@Status_", Status_);
                        cmd.Parameters.AddWithValue("@RegNo", RegNo);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Redirect(Request.Url.AbsoluteUri);
                            txtReasonForLeave.Value = string.Empty;
                            txtLeaveLetterUrl.Value = string.Empty;
                            dateInput.Value = string.Empty;
                            days.SelectedValue = string.Empty;

                        }
                        else Response.Write("Update Failed");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        protected void OD_Click(object sender, EventArgs e)
        {
            string txtReasonOd = txtReasonForOd.Value;
            string Odurl = txtOdLetterUrl.Value;
            string Status_ = "Open";
            string RegNo = "2115002";
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string insertQuery = "INSERT INTO Student_Od(RegNo, Info, OdUrl, Status_, Apply_) " +
                        "VALUES (@RegNo, @Info, @OdUrl, @Status_, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, connection))
                    {
                        cmd.Parameters.AddWithValue("@Info", txtReasonOd);
                        cmd.Parameters.AddWithValue("@OdUrl", Odurl);
                        cmd.Parameters.AddWithValue("@Status_", Status_);
                        cmd.Parameters.AddWithValue("@RegNo", RegNo);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            Response.Redirect(Request.Url.AbsoluteUri);
                            txtReasonForOd.Value = string.Empty;
                            txtOdLetterUrl.Value = string.Empty;

                            Console.WriteLine("BBB");

                        }
                        else
                        {
                            Response.Write("Update Failed");
                            Console.WriteLine("NNN");
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                Console.WriteLine("zzz");

            }

        }
        private void ShowNotifications()
        {
            try
            {
                string query = "SELECT *, FORMAT(Apply_, 'dd-MM-yyyy') AS FormattedDate FROM Student_leave";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            string Reason = reader["Reason"].ToString();
                            string Status = reader["Status_"].ToString();
                            string formattedDate = reader["FormattedDate"].ToString();
                            AddNotification(Reason, Status, formattedDate);
                        }
                        ShowOdNotifications();
                        reader.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }
        private void AddNotification(string Reason, string Status, string date)
        {
            if (!string.IsNullOrEmpty(Reason) && !string.IsNullOrEmpty(Status))
            {
                Panel notificationPanel = new Panel();
                notificationPanel.CssClass = "notification mb-2";
                Label reason = new Label();
                Label status = new Label();
                reason.Text = Reason;
                status.Text = Status;
                if (Status == "Pending")
                {
                    Label icon = new Label();
                    icon.Text = "🔃     (" + date + ")";
                    notificationPanel.Controls.Add(icon);
                    notificationPanel.Controls.Add(reason);
                }
                if (Status == "Accept")
                {
                    Label icon = new Label();
                    icon.Text = "✅ Your Leave Request Has Been Accepted. Request sent Date → (" + date + ")";
                    notificationPanel.Controls.Add(icon);
                }
                if (Status == "Reject")
                {
                    Label icon = new Label();
                    icon.Text = "❌ Your Leave Request Has Been Rejected. Request sent Date → (" + date + ")";
                    notificationPanel.Controls.Add(icon);
                }
                notificationsDiv.Controls.Add(notificationPanel);

                if (Status == "Open")
                {
                    Label icon = new Label();
                    icon.Text = "📩 Your OD Notification is Sent.Sent Date → (" + date + ")";
                    notificationPanel.Controls.Add(icon);

                }
            }
        }
        private void ShowOdNotifications()
        {
            try
            {
                string query = "SELECT *, FORMAT(Apply_, 'dd-MM-yyyy') AS FormattedDate FROM Student_Od";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            string Reason = reader["Info"].ToString();
                            string Status = reader["Status_"].ToString();
                            string formattedDate = reader["FormattedDate"].ToString();
                            AddNotification(Reason, Status, formattedDate);
                        }
                        reader.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }

    }
}