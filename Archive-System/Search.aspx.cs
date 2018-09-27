using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Archive_System
{
    public partial class Search : Page
    {
        private readonly string _connString =
            ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            var hTerm = CleanString(Request.Params["term"]);
            if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "ALL")
                SDT_Results.SelectCommand =
                    "SELECT * FROM DocumentMetaPlain WHERE docID IN (" +
                    "SELECT docID FROM DocumentMeta WHERE " +
                    $"CONTAINS(Category, '\"{hTerm}*\"') OR " +
                    $"CONTAINS(Document, '\"{hTerm}*\"') OR " +
                    $"CONTAINS(Author, '\"{hTerm}*\"')) ";
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "AUTH")
                SDT_Results.SelectCommand =
                    "SELECT * FROM DocumentMetaPlain WHERE docID IN (" +
                    "SELECT docID FROM DocumentMeta WHERE " +
                    $"CONTAINS(Author, '\"{hTerm}*\"')) ";
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "CAT")
                SDT_Results.SelectCommand =
                    "SELECT * FROM DocumentMetaPlain WHERE docID IN (" +
                    "SELECT docID FROM DocumentMeta WHERE " +
                    $"CONTAINS(Category, '\"{hTerm}*\"')) ";
        }

        protected void Lvw_Results_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            Hfd_ID.Value = e.CommandArgument.ToString();
            Lbl_Authors.DataBind();
            Btn_DownloadAttachment.DataBind();
            Lbl_Catgory.DataBind();
            ScriptManager.RegisterStartupScript(UpdatePanel1, GetType(), "show",
                @"$('#documentModal').modal('show');", true);
        }

        protected string GetCategory()
        {
            var currId = Convert.ToInt32(Hfd_ID.Value);
            var query = "SELECT Category FROM DocumentMeta WHERE docID = @id";
            var result = "";

            using (var conn = new SqlConnection(_connString))
            {
                conn.Open();
                using (var comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = currId;
                    using (var dr = comm.ExecuteReader())
                    {
                        while (dr.Read()) result = Convert.ToString(dr["Category"]);
                    }
                }
            }

            return result;
        }

        protected string GetAuthors()
        {
            var currId = Convert.ToInt32(Hfd_ID.Value);
            var query = "SELECT * FROM DocumentMeta WHERE docID = @id";
            var result = "";
            var authors = new List<string>(3);
            using (var conn = new SqlConnection(_connString))
            {
                conn.Open();
                using (var comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = currId;
                    using (var dr = comm.ExecuteReader())
                    {
                        while (dr.Read()) authors.Add(Convert.ToString(dr["Author"]));
                    }
                }
            }

            foreach (var name in authors) result += $"{name}, ";

            result = result.Substring(0, result.LastIndexOf(",")).Trim();

            return result;
        }

        protected bool HasAttachment()
        {
            var currId = Convert.ToInt32(Hfd_ID.Value);
            var result = -1;
            var query = "SELECT COUNT(*) FROM Attachments WHERE DocumentID = @id";
            using (var conn = new SqlConnection(_connString))
            {
                conn.Open();
                using (var comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = currId;
                    result = Convert.ToInt32(comm.ExecuteScalar());
                }
            }

            return result != 0 ? true : false;
        }

        protected string SetText()
        {
            var currId = Convert.ToInt32(Hfd_ID.Value);

            if (HasAttachment())
                return "Download Attachment";
            return "No Attachment Available";
        }

        private void DownloadDocument(int documentId)
        {
            var id = documentId;
            byte[] bytes = null;
            var fileName = "";
            var contentType = "";

            using (var conn = new SqlConnection(_connString))
            {
                conn.Open();
                var query = "SELECT * FROM DocumentSets WHERE ID = @id";
                using (var comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    using (var reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bytes = (byte[]) reader["document"];
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

        private void DownloadAttachment(int documentId)
        {
            var id = documentId;
            byte[] bytes = null;
            var fileName = "";
            var contentType = "";

            using (var conn = new SqlConnection(_connString))
            {
                conn.Open();
                var query = "SELECT * FROM DocumentSets WHERE ID = @id";
                using (var comm = new SqlCommand(query, conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = id;
                    using (var reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bytes = (byte[]) reader["attachment"];
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

        protected void FvwBtn_Download_ServerClick(object sender, EventArgs e)
        {
            var currId = Convert.ToInt32(Hfd_ID.Value);
            DownloadDocument(currId);
        }

        protected void Btn_DownloadAttachment_Click(object sender, EventArgs e)
        {
            var currId = Convert.ToInt32(Hfd_ID.Value);
            DownloadAttachment(currId);
        }

        private string CleanString(string input)
        {
            var output = "";

            try
            {
                output = input.Replace("'", "''");
            }
            catch (Exception)
            {
            }

            return output;
        }

        protected void BtnSearchDocuments_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Search.aspx?field={DrpField.SelectedValue}&term={TbxSearchTerms.Text}");
        }

        protected string CleanTitle(object title)
        {
            var tTitle = title.ToString();
            var result = tTitle;

            try
            {
                result = tTitle.Substring(0, tTitle.LastIndexOf("."));
            }
            catch (Exception)
            {
            }

            return result;
        }
    }
}