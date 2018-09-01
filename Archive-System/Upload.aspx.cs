using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using System.Configuration;

namespace Archive_System
{
    public partial class Upload : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#upload').addClass('active');", true);
        }

        protected void Btn_Upload_Click(object sender, EventArgs e)
        {
            if(FileUpload_Documents.HasFile && FileUpload_Attachments.HasFile)
            {
                UploadDocument();
                UploadAttachment();
            }
            else
            {
                UploadDocument();
            }
        }

        private void UploadDocument()
        {
            try
            {
                string fileName = Path.GetFileName(FileUpload_Documents.PostedFile.FileName);
                string contentType = FileUpload_Documents.PostedFile.ContentType;
                byte[] bytes;
                using (Stream fs = FileUpload_Documents.PostedFile.InputStream)
                {
                    using (BinaryReader br = new BinaryReader(fs))
                    {
                        bytes = br.ReadBytes((Int32)fs.Length);
                    }
                }

                using (TransactionScope scope = new TransactionScope())
                {
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();
                        using (SqlCommand comm = new SqlCommand("UploadDocument", conn))
                        {
                            comm.CommandType = CommandType.StoredProcedure;
                            comm.Parameters.Add("@filename", SqlDbType.NVarChar).Value = fileName;
                            comm.Parameters.Add("@contentType", SqlDbType.NVarChar).Value = contentType;
                            comm.Parameters.Add("@file", SqlDbType.VarBinary).Value = bytes;
                            comm.Parameters.Add("@authAFirst", SqlDbType.NVarChar).Value = Tbx_AuthA_First.Text;
                            comm.Parameters.Add("@authALast", SqlDbType.NVarChar).Value = Tbx_AuthA_Last.Text;
                            comm.Parameters.Add("@authBFirst", SqlDbType.NVarChar).Value = Tbx_AuthB_First.Text;
                            comm.Parameters.Add("@authBLast", SqlDbType.NVarChar).Value = Tbx_AuthB_Last.Text;
                            comm.Parameters.Add("@authCFirst", SqlDbType.NVarChar).Value = Tbx_AuthC_First.Text;
                            comm.Parameters.Add("@authCLast", SqlDbType.NVarChar).Value = Tbx_AuthC_Last.Text;
                            comm.Parameters.Add("@categoryID", SqlDbType.Int).Value = Convert.ToInt32(DRP_Category.SelectedValue);
                            comm.ExecuteNonQuery();
                        }
                    }

                    scope.Complete();
                }
            }
            catch (Exception)
            {

            }
        }

        private void UploadAttachment()
        {
            try
            {
                string fileName = Path.GetFileName(FileUpload_Attachments.PostedFile.FileName);
                string contentType = FileUpload_Attachments.PostedFile.ContentType;
                byte[] bytes;
                using (Stream fs = FileUpload_Attachments.PostedFile.InputStream)
                {
                    using (BinaryReader br = new BinaryReader(fs))
                    {
                        bytes = br.ReadBytes((Int32)fs.Length);
                    }
                }

                using (TransactionScope scope = new TransactionScope())
                {
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();
                        using (SqlCommand comm = new SqlCommand("UploadFile", conn))
                        {
                            comm.CommandType = CommandType.StoredProcedure;
                            comm.Parameters.Add("@filename", SqlDbType.NVarChar).Value = fileName;
                            comm.Parameters.Add("@contentType", SqlDbType.NVarChar).Value = contentType;
                            comm.Parameters.Add("@file", SqlDbType.VarBinary).Value = bytes;
                            comm.ExecuteNonQuery();
                        }
                    }

                    scope.Complete();
                }
            }
            catch (Exception)
            {

            }

        }
    }
}