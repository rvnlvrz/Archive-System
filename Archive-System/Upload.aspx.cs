﻿using System;
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

        }

        protected void Btn_Upload_Click(object sender, EventArgs e)
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

            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();
                        using (SqlCommand comm = new SqlCommand("UploadFile", conn))
                        {
                            comm.CommandType = CommandType.StoredProcedure;
                            comm.Parameters.Add("@filename", SqlDbType.NVarChar).Value = fileName;
                            comm.Parameters.Add("@extension", SqlDbType.NVarChar).Value = contentType;
                            comm.Parameters.Add("@file", SqlDbType.VarBinary).Value = bytes;
                            comm.Parameters.Add("@authAFirst", SqlDbType.NVarChar).Value = Tbx_AuthA_First.Text;
                            comm.Parameters.Add("@authALast", SqlDbType.NVarChar).Value = Tbx_AuthA_Last.Text;
                            comm.Parameters.Add("@authBFirst", SqlDbType.NVarChar).Value = Tbx_AuthB_First.Text;
                            comm.Parameters.Add("@authBLast", SqlDbType.NVarChar).Value = Tbx_AuthB_Last.Text;
                            comm.Parameters.Add("@authCFirst", SqlDbType.NVarChar).Value = Tbx_AuthC_First.Text;
                            comm.Parameters.Add("@authCLast", SqlDbType.NVarChar).Value = Tbx_AuthC_Last.Text;
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

        private void downloadFile()
        {

        }

        /// <summary>
        /// Obtain the userID associated with a certain first and last name in the database
        /// </summary>
        /// <param name="first">The first name of the author</param>
        /// <param name="last">The last name of the author</param>
        /// <returns>The user ID of the author in the database</returns>
        private int GetUserID(string first, string last)
        {
            int userID = -1;
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = "SELECT UserID FROM Users WEHRE FirstName=@first AND LastName=@last";
                    using (SqlCommand comm = new SqlCommand(query, conn))
                    {
                        comm.Parameters.Add("@first", SqlDbType.NVarChar).Value = first;
                        comm.Parameters.Add("@last", SqlDbType.NVarChar).Value = last;
                        userID = (int)comm.ExecuteScalar();
                    }
                }
            }
            catch (Exception)
            {

            }

            return userID != -1 ? userID : 0;

        }
    }
}