using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Archive_System
{
	public partial class Home : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#home').addClass('active');", true);
        }
	}
}