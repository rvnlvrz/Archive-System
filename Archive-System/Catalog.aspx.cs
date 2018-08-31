using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using System.Configuration;

namespace Archive_System
{
	public partial class Catalog : System.Web.UI.Page
	{
        string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void LvwDocuments_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            byte[] bytes = null;
            string fileName = "";
            string contentType = "";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT * FROM Documents WHERE ID = @id";
                using (SqlCommand comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bytes = (byte[])reader["File"];
                            fileName = Convert.ToString(reader["Name"]);
                            contentType = Convert.ToString(reader["ContentType"]);
                        }
                    }
                }
            }

            Response.Clear();
            Response.AddHeader("Cache-Control", "no-cache, must-revalidate, post-check=0, pre-check=0");
            Response.AddHeader("Pragma", "no-cache");
            Response.AddHeader("Content-Description", "File Download");
            Response.AddHeader("Content-Type", "application/force-download");
            Response.AddHeader("Content-Transfer-Encoding", "binary\n");
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}