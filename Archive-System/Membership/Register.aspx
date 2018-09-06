<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Archive_System.Membership.Register" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="lib-backdrop">
        <div class="tinted d-flex align-items-center h-100 w-100">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="lib-box" style="width: 80%">
                        <h4 style="font-size: 2rem;"><i class="fa fa-graduation-cap">&nbsp;</i>The Cardinal Archives</h4>
                    </div>
                </div>
                <div class="row justify-content-center align-items-center">
                    <div class="card" style="border-color: rebeccapurple; width: 80%">
                        <div class="card-body">
                            <h2 class="card-title text-center">
                                <strong>Sign Up</strong>
                            </h2>
                            <asp:CreateUserWizard ID="CreateUserWizard" runat="server" CssClass="w-100" CreateUserButtonText="Register" OnCreatedUser="CreateUserWizard_CreatedUser" ActiveStepIndex="1" ContinueDestinationPageUrl="~/Default.aspx">
                                <CreateUserButtonStyle CssClass="btn btn-library-10 form-control form-control-lg" />
                                <WizardSteps>
                                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                                        <ContentTemplate>
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName" Display="Dynamic" ErrorMessage="First Name is required." CssClass="text-danger"></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <asp:TextBox ID="MiddleName" runat="server" CssClass="form-control" placeholder="Middle Name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="MiddleNameRequired" runat="server" ControlToValidate="MiddleName" Display="Dynamic" ErrorMessage="Middle Name is required." CssClass="text-danger"></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <asp:TextBox ID="LastName" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastName" Display="Dynamic" ErrorMessage="Last Name is required." CssClass="text-danger"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="User Name"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Passwords do no match." ToolTip="Passwords do no match." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="CreateUserWizard1" CssClass="text-danger"></asp:CompareValidator>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <asp:TextBox ID="Email" runat="server" CssClass="form-control mb-1" placeholder="E-mail"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="text-danger">
                                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                            </div>
                                        </ContentTemplate>
                                        <CustomNavigationTemplate>
                                            <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" CssClass="btn btn-library-10 form-control form-control-lg" Text="Register" />
                                        </CustomNavigationTemplate>
                                    </asp:CreateUserWizardStep>
                                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                                        <ContentTemplate>
                                            <div class="text-center">
                                                Your account has been successfully created.
                                            </div>
                                                <div class="text-right">
                                                    <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Continue" Text="Continue" ValidationGroup="CreateUserWizard" CssClass="btn btn-success"/>
                                                </div>
                                        </ContentTemplate>
                                    </asp:CompleteWizardStep>
                                </WizardSteps>
                            </asp:CreateUserWizard>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
