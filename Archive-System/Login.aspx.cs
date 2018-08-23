using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Archive_System
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginControl_LoginError(object sender, EventArgs e)
        {
            // Verify user
            if (System.Web.Security.Membership.ValidateUser(LoginControl.UserName, LoginControl.Password))
            {
                FormsAuthentication.RedirectFromLoginPage(LoginControl.UserName, LoginControl.RememberMeSet);
            }
        }

        protected void LoginControl_Authenticate(object sender, AuthenticateEventArgs e)
        {
            // Determine why the user could not login...
            LoginControl.FailureText = "Your login attempt was not successful. Please try again.";

            // Does there exist a User account for this user?
            MembershipUser usrInfo = System.Web.Security.Membership.GetUser(LoginControl.UserName);
            if (usrInfo != null)
            {
                // Is this user locked out?
                if (usrInfo.IsLockedOut)
                {
                    LoginControl.FailureText = "Your account has been locked out because of too many invalid login attempts. Please contact the administrator to have your account unlocked.";
                }
                else if (!usrInfo.IsApproved)
                {
                    LoginControl.FailureText = "Your account has not yet been approved. You cannot login until an administrator has approved your account.";
                }
            }
        }
    }
}