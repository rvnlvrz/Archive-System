using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Archive_System
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void HideFooterHeader()
        {
            header.Visible = false;
            navbar.Visible = false;
            footer_primary.Visible = false;
        }

        protected void BtnTopFind_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Search.aspx?field=all&term={TbxTopFind.Text}");
        }
    }
}