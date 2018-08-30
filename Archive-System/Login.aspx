<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Archive_System.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="d-flex">
            <div class="mx-auto" style="margin-top: 5rem;">
                <%-- Login Card --%>
                <div class="row">
                    <div class="card" style="border-color: rebeccapurple; width: 24rem;">
                        <div class="card-body">
                            <asp:Login ID="LoginControl" runat="server" LoginButtonText="Sign In" TitleText="" RenderOuterTable="False" OnAuthenticate="LoginControl_Authenticate" CreateUserText="Not Registered?" OnLoginError="LoginControl_LoginError" DestinationPageUrl="~/Default.aspx">
                                <LayoutTemplate>
                                    <div class="form-group">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                        <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ValidationGroup="Login" Display="Dynamic" CssClass="text-danger">User Name is required.</asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ValidationGroup="Login" Display="Dynamic" CssClass="text-danger">Password is required.</asp:RequiredFieldValidator>
                                    </div>
                                    <asp:CheckBox ID="RememberMe" runat="server" CssClass="" Text="&nbsp;Remember Me" />
                                    <div class="text-danger">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                        <%--<asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="LoginControl" />--%>
                                    </div>
                                    <div class="text-right" style="margin-top: 0.5rem">
                                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Sign In" ValidationGroup="Login" CssClass="btn btn-success" />
                                    </div>
                                </LayoutTemplate>
                            </asp:Login>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
