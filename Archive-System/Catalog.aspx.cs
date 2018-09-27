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
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#catalog').addClass('active');", true);
        }

        protected void LvwDocuments_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            Hfd_ID.Value = e.CommandArgument.ToString();
            Lbl_Authors.DataBind();
            Btn_DownloadAttachment.DataBind();
            Lbl_Catgory.DataBind();
            ScriptManager.RegisterStartupScript(MainUpdatePanel, GetType(), "show",
                @"$('#documentModal').modal('show');", true);
        }

        private void DownloadDocument(int documentID)
        {
            int id = documentID;
            byte[] bytes = null;
            string fileName = "";
            string contentType = "";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT * FROM DocumentSets WHERE ID = @id";
                using (SqlCommand comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bytes = (byte[])reader["document"];
                            fileName = Convert.ToString(reader["documentName"]);
                            contentType = Convert.ToString(reader["docType"]);
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

        private void DownloadAttachment(int documentID)
        {
            int id = documentID;
            byte[] bytes = null;
            string fileName = "";
            string contentType = "";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT * FROM DocumentSets WHERE ID = @id";
                using (SqlCommand comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bytes = (byte[])reader["attachment"];
                            fileName = Convert.ToString(reader["attachmentName"]);
                            contentType = Convert.ToString(reader["atachmentType"]);
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

        protected string GetCategory()
        {
            int currID = Convert.ToInt32(Hfd_ID.Value);
            string query = "SELECT Category FROM DocumentMeta WHERE docID = @id";
            string result = "";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = currID;
                    using (SqlDataReader dr = comm.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            result = Convert.ToString(dr["Category"]);
                        }
                    }
                }
            }

            return result;
        }

        protected string GetAuthors()
        {
            int currID = Convert.ToInt32(Hfd_ID.Value);
            string query = "SELECT * FROM DocumentMeta WHERE docID = @id";
            string result = "";
            List<string> authors = new List<string>(3);
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = currID;
                    using (SqlDataReader dr = comm.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            authors.Add(Convert.ToString(dr["Author"]));
                        }
                    }
                }
            }

            foreach (string name in authors)
            {
                result += $"{name}, ";
            }

            result = result.Substring(0, result.LastIndexOf(",")).Trim();

            return result;
        }

        protected bool HasAttachment()
        {
            int currID = Convert.ToInt32(Hfd_ID.Value);
            int result = -1;
            string query = "SELECT COUNT(*) FROM Attachments WHERE DocumentID = @id";
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = currID;
                    result = Convert.ToInt32(comm.ExecuteScalar());
                }
            }

            return result != 0 ? true : false;
        }

        protected string SetText()
        {
            int currID = Convert.ToInt32(Hfd_ID.Value);

            if (HasAttachment())
            {
                return "Download Attachment";
            }
            else
            {
                return "No Attachment Available";
            }

        }

        protected void FvwBtn_Download_ServerClick(object sender, EventArgs e)
        {
            int currID = Convert.ToInt32(Hfd_ID.Value);
            DownloadDocument(currID);
        }

        protected void Btn_DownloadAttachment_Click(object sender, EventArgs e)
        {
            int currID = Convert.ToInt32(Hfd_ID.Value);
            DownloadAttachment(currID);
        }

        protected void Drp_Filter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Drp_Filter.SelectedValue == "0")
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain GROUP BY docID, Category, " +
                    "Document ORDER BY Category";
            }
            else if (Drp_Filter.SelectedValue == "1")
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain WHERE Category = 'Thesis' " +
                    "GROUP BY docID, Category, Document ORDER BY Document";
            }
            else if (Drp_Filter.SelectedValue == "2")
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain WHERE Category = 'Capstone' " +
                    "GROUP BY docID, Category, Document ORDER BY Document";
            }
            else
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain WHERE docID IN (SELECT DocumentID FROM Attachments) " +
                    "GROUP BY docID, Category, Document ORDER BY Category";
            }


            //SqlDataSource1.Select(null);
            SqlDataSource1.DataBind();
            LvwDocuments.DataBind();
            
        }

        protected string CleanTitle(object title)
        {
            string t_title = title.ToString();
            string result = t_title;

            try
            {
                result = t_title.Substring(0, t_title.LastIndexOf("."));
            }
            catch (Exception)
            {

            }

            return result;
        }

        protected void DataPagerProducts_PreRender(object sender, EventArgs e)
        {
            if (Drp_Filter.SelectedValue == "0")
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain GROUP BY docID, Category, " +
                    "Document ORDER BY Category";
            }
            else if (Drp_Filter.SelectedValue == "1")
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain WHERE Category = 'Thesis' " +
                    "GROUP BY docID, Category, Document ORDER BY Document";
            }
            else if (Drp_Filter.SelectedValue == "2")
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain WHERE Category = 'Capstone' " +
                    "GROUP BY docID, Category, Document ORDER BY Document";
            }
            else
            {
                SqlDataSource1.SelectCommand =
                    "SELECT docID, Category, Document FROM " +
                    "DocumentMetaPlain WHERE docID IN (SELECT DocumentID FROM Attachments) " +
                    "GROUP BY docID, Category, Document ORDER BY Category";
            }

            SqlDataSource1.DataBind();
            LvwDocuments.DataBind();
        }

    }
}