using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Attendance
{
    public partial class OA1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void uploadButton_Click(object sender, EventArgs e)
        {
            if (fileInput.HasFile)
            {
                try
                {
                    DataTable dt = new DataTable();
                    using (StreamReader reader = new StreamReader(fileInput.PostedFile.InputStream))
                    {
                        string[] headers = reader.ReadLine().Split(',');
                        foreach (string header in headers)
                            dt.Columns.Add(header.Trim());
                        while (!reader.EndOfStream)
                        {
                            string[] rows = reader.ReadLine().Split(',');
                            DataRow dr = dt.NewRow();
                            for (int i = 0; i < headers.Length; i++)
                                dr[i] = rows[i].Trim();
                            dt.Rows.Add(dr);
                        }
                    }
                    string connectionString = "Data Source=RAGHAVA\\MSSQLSERVER02;Initial Catalog=attendance;Integrated Security=True";
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();
                        foreach (DataRow row in dt.Rows)
                        {
                            string regno = row["RegNo"].ToString();
                            string name = row["Name"].ToString();
                            string status = row["Status"].ToString();

                            string insertQuery = "INSERT INTO Students_attendance (RegNo, Name, Status) VALUES (@RegNo, @Name, @Status)";
                            using (SqlCommand cmd = new SqlCommand(insertQuery, connection))
                            {
                                cmd.Parameters.AddWithValue("@RegNo", regno);
                                cmd.Parameters.AddWithValue("@Name", name);
                                cmd.Parameters.AddWithValue("@Status", status);
                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    Response.Redirect(Request.Url.AbsoluteUri);
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", $"alert('Error: {ex.Message}');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "NoFileMessage", "alert('Please select a file to upload.');", true);
            }
        }


    }
}
