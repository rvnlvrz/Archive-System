using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLogicLayer;

namespace Archive_System.Membership
{
    public partial class Register : Page
    {
        private readonly UserLogic _userLogic = new UserLogic();

        protected void Page_Load(object sender, EventArgs e)
        {
            Master.HideFooterHeader();
        }

        protected void CreateUserWizard_CreatedUser(object sender, EventArgs e)
        {
            var firstName =
                CreateUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("FirstName") as TextBox;
            var middleName =
                CreateUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("MiddleName") as TextBox;
            var lastName = CreateUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("LastName") as TextBox;

            if (CreateUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("UserName") is TextBox userName)
            {
                var newUser = System.Web.Security.Membership.GetUser(userName.Text);
                var newUserId = (Guid) newUser.ProviderUserKey;
                _userLogic.UpdateName(firstName.Text, middleName.Text, lastName.Text, newUserId);
            }
        }
    }
}