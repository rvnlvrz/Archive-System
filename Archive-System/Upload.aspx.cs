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
            try
            {
                Validate();
                if ((FileUpload_Documents.HasFile && FileUpload_Attachments.HasFile) && IsValid)
                {
                    UploadDocument();
                    UploadAttachment();
                    ClearControls();
                    ScriptManager.RegisterStartupScript(Btn_Upload, GetType(), "UpdateNotifModal",
                        @"$('#compeleteModal').modal('toggle');", true);

                }
                else if (FileUpload_Documents.HasFile && IsValid)
                {
                    UploadDocument();
                    ClearControls();
                    ScriptManager.RegisterStartupScript(Btn_Upload, GetType(), "UpdateNotifModal",
                        @"$('#compeleteModal').modal('toggle');", true);
                }
                else if (!FileUpload_Documents.HasFile)
                {
                    ScriptManager.RegisterStartupScript(Btn_Upload, GetType(), "UpdateNotifModal",
                        @"$('#NoDocumentModal').modal('toggle');", true);
                }
                else if(!FileUpload_Attachments.HasFile && FileUpload_Attachments.HasFile)
                {
                    ScriptManager.RegisterStartupScript(Btn_Upload, GetType(), "UpdateNotifModal",
                        @"$('#DocumentRequiredModal').modal('toggle');", true);
                }
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(Btn_Upload, GetType(), "UpdateNotifModal",
                    @"$('#failModal').modal('toggle');", true);
            }
        }

        private void UploadDocument()
        {
            FileInfo h_File = new FileInfo(Path.GetFileName(FileUpload_Documents.PostedFile.FileName));
            string fileName = $"{Tbx_FileName.Text}{h_File.Extension}";
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

        private void UploadAttachment()
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

        private void ClearControls()
        {
            Tbx_AuthA_First.Text = "";
            Tbx_AuthA_Last.Text = "";
            Tbx_AuthB_First.Text = "";
            Tbx_AuthB_Last.Text = "";
            Tbx_AuthC_First.Text = "";
            Tbx_AuthC_Last.Text = "";
            Tbx_FileName.Text = "";
        }

        private bool HasCompleteAuthors(string valA, string valB)
        {
            bool completeAuthors = true;

            if ((valA != string.Empty) && (valB == string.Empty))
            {
                completeAuthors = false;
            }
            else if ((valA == string.Empty) && (valB != string.Empty))
            {
                completeAuthors = false;
            }

            return completeAuthors;
        }

        protected void ReqValC_AuthB_First_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = HasCompleteAuthors(args.Value, Tbx_AuthB_Last.Text);
        }

        protected void ReqValC_AuthA_First_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = HasCompleteAuthors(args.Value, Tbx_AuthA_Last.Text);
        }

        protected void ReqValC_AuthA_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = HasCompleteAuthors(args.Value, Tbx_AuthA_Last.Text) &&
                HasCompleteAuthors(args.Value, Tbx_AuthA_First.Text);
        }

        protected void ReqValC_AuthB_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = HasCompleteAuthors(args.Value, Tbx_AuthB_Last.Text) &&
                HasCompleteAuthors(args.Value, Tbx_AuthB_First.Text);
        }

        protected void ReqValC_AuthC_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = HasCompleteAuthors(args.Value, Tbx_AuthC_Last.Text) &&
                HasCompleteAuthors(args.Value, Tbx_AuthC_First.Text);
        }

        protected void NoDuplicateC_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string authAConcat = (Tbx_AuthA_First.Text + Tbx_AuthA_Last.Text).ToLower();
            string authBConcat = (Tbx_AuthB_First.Text + Tbx_AuthB_Last.Text).ToLower();
            string authCConcat = (Tbx_AuthC_First.Text + Tbx_AuthC_Last.Text).ToLower();

            bool AuthFieldsEmpty = (authBConcat == string.Empty) || (authCConcat == string.Empty);

            if ((authAConcat == authBConcat) || (authAConcat == authCConcat) || ((authBConcat == authCConcat) && !AuthFieldsEmpty))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
    }
}