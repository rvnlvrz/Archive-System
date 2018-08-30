<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Archive_System.Login" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="lib-backdrop">
        <div class="tinted d-flex align-items-center h-100 w-100">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="lib-box">
                        <h4 style="font-size: 22px;"><i class="fa fa-graduation-cap">&nbsp;</i>The Cardinal Archives</h4>
                    </div>
                </div>
                <%-- Login Card --%>
                <div class="row justify-content-center align-items-center">
                    <div class="card" style="border-color: rebeccapurple;">
                        <div class="card-body" style="width: 360px;">
                            <h5 class="card-title lead text-center display-4"><strong>Sign In</strong></h5>
                            <asp:Login ID="LoginControl" runat="server" LoginButtonText="Sign In" TitleText="" RenderOuterTable="False" OnAuthenticate="LoginControl_Authenticate" CreateUserText="Not Registered?" OnLoginError="LoginControl_LoginError" DestinationPageUrl="Home.aspx">
                                <LayoutTemplate>
                                    <div class="form-group">
                                        <%--<asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>--%>
                                        <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="username"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ValidationGroup="Login" Display="Dynamic" CssClass="text-danger">User Name is required.</asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group">
                                        <%--<asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>--%>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control" placeholder="password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ValidationGroup="Login" Display="Dynamic" CssClass="text-danger">Password is required.</asp:RequiredFieldValidator>
                                    </div>
                                    <asp:CheckBox ID="RememberMe" runat="server" CssClass="" Text="&nbsp;Remember Me" />
                                    <div class="text-danger">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                        <%--<asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="LoginControl" />--%>
                                    </div>
                                    <div class="text-right" style="margin-top: 0.5rem">
                                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Sign In" ValidationGroup="Login" CssClass="btn btn-library-10 form-control" />
                                    </div>
                                    <div class="divider">
                                        <hr class="left">
                                        <small>New to the library?</small>
                                        <hr class="right">
                                    </div>
                                    <div class="form-group">
                                        <asp:Button ID="BtnContact" runat="server" Text="Register Now" CssClass="btn btn-info form-control"
                                            Font-Size="14px" />
                                    </div>
                                    <div class="form-group text-center">
                                        <p>
                                            By signing in to the Cardinal Archives, you are agreeing to our 
                                    <a href="#">Terms of Use</a> and to our <a href="#">Privacy Policy</a>.
                                        </p>
                                    </div>
                                </LayoutTemplate>
                            </asp:Login>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
