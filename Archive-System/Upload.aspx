<%@ Page Title="Upload" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="Archive_System.Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid parallax">
        <div class="wrap">
            <div class="mt-3">
                <div class="container white-box">
                    <div class="pt-3 pb-3">
                        <div class="container">
                            <div class="form-group">
                                <asp:Label ID="Label4" runat="server" Text="Study Title" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                <asp:TextBox ID="Tbx_FileName" runat="server" CssClass="form-control mt-2" placeholder="title"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqVal_FileName" runat="server" ErrorMessage="A title is required" ForeColor="Red"
                                    Display="Dynamic" ControlToValidate="Tbx_FileName"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label3" runat="server" Text="Type" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                <asp:DropDownList ID="DRP_Category" runat="server" CssClass="custom-select mt-2">
                                    <asp:ListItem Selected="True" Value="1">Thesis</asp:ListItem>
                                    <asp:ListItem Value="2">Capstone</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Lbl_AuthA" runat="server" Text="First Author" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                <div class="form-row">
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="Tbx_AuthA_First" runat="server" CssClass="form-control mb-2 mt-2" placeholder="first name"
                                            ValidationGroup="first"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="Tbx_AuthA_Last" runat="server" CssClass="form-control mt-2" placeholder="last name"
                                            ValidationGroup="first"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Both the author's first and last names are required"
                                        OnServerValidate="ReqValC_AuthA_ServerValidate" ControlToValidate="Tbx_AuthA_Last"
                                        Display="Dynamic" ValidationGroup="first" ForeColor="Red"></asp:CustomValidator>
                                    <asp:CustomValidator ID="ReqValC_AuthA_First" runat="server" ErrorMessage="Both the author's first and last names are required"
                                        OnServerValidate="ReqValC_AuthA_ServerValidate" ControlToValidate="Tbx_AuthA_First"
                                        Display="Dynamic" ValidationGroup="first" ForeColor="Red"></asp:CustomValidator>
                                    <asp:CustomValidator ID="NoRepeatA" runat="server" ErrorMessage="An author's name may only appear once" 
                                        ControlToValidate="Tbx_AuthA_Last" ForeColor="Red" Display="Dynamic" ValidationGroup="first" OnServerValidate="NoDuplicateC_ServerValidate"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label1" runat="server" Text="Second Author" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                <div class="form-row">
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="Tbx_AuthB_First" runat="server" CssClass="form-control mb-2 mt-2" placeholder="first name"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="Tbx_AuthB_Last" runat="server" CssClass="form-control mt-2" placeholder="last name"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator ID="ReqValC_AuthB_First" runat="server" ErrorMessage="Both the author's first and last names are required"
                                        OnServerValidate="ReqValC_AuthB_ServerValidate" ControlToValidate="Tbx_AuthB_First"
                                        Display="Dynamic" ValidationGroup="second" ForeColor="Red"></asp:CustomValidator>
                                    <asp:CustomValidator ID="ReqValC_AuthB_Last" runat="server" ErrorMessage="Both the author's first and last names are required"
                                        OnServerValidate="ReqValC_AuthB_ServerValidate" ControlToValidate="Tbx_AuthB_Last"
                                        Display="Dynamic" ValidationGroup="second" ForeColor="Red"></asp:CustomValidator>
                                    <asp:CustomValidator ID="NoRepeatB" runat="server" ErrorMessage="An author's name may only appear once" 
                                        ControlToValidate="Tbx_AuthB_Last" ForeColor="Red" Display="Dynamic" ValidationGroup="second" OnServerValidate="NoDuplicateC_ServerValidate"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label2" runat="server" Text="Third Author" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                <div class="form-row">
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="Tbx_AuthC_First" runat="server" CssClass="form-control mb-2 mt-2" placeholder="first name"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="Tbx_AuthC_Last" runat="server" CssClass="form-control mt-2" placeholder="last name"></asp:TextBox>
                                    </div>
                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Both the author's first and last names are required"
                                        OnServerValidate="ReqValC_AuthC_ServerValidate" ControlToValidate="Tbx_AuthC_Last"
                                        Display="Dynamic" ValidationGroup="third" ForeColor="Red"></asp:CustomValidator>
                                    <asp:CustomValidator ID="ReqValC_AuthC_First" runat="server" ErrorMessage="Both the author's first and last names are required"
                                        OnServerValidate="ReqValC_AuthC_ServerValidate" ControlToValidate="Tbx_AuthC_First"
                                        Display="Dynamic" ValidationGroup="third" ForeColor="Red"></asp:CustomValidator>
                                    <asp:CustomValidator ID="NoRepeatC" runat="server" ErrorMessage="An author's name may only appear once" 
                                        ControlToValidate="Tbx_AuthC_Last" ForeColor="Red" Display="Dynamic" ValidationGroup="third" OnServerValidate="NoDuplicateC_ServerValidate"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Lbl_uploadBox" runat="server" Text="Document" CssClass="lead col-form-label text-uppercase"></asp:Label>
                                <div class="wrap border border-danger rounded">
                                    <asp:FileUpload ID="FileUpload_Documents" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Lbl_attachmentBox" runat="server" Text="Attachment" CssClass="lead col-form-label text-uppercase"></asp:Label>
                                <div class="wrap border border-danger rounded">
                                    <asp:FileUpload ID="FileUpload_Attachments" runat="server" />
                                </div>
                            </div>
                            <div class="mt-2 text-right">
                                <asp:Button ID="Btn_Upload" runat="server" Text="Upload" CssClass="btn btn-library-10" OnClick="Btn_Upload_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Modal -->
    <div class="modal fade" id="compeleteModal" tabindex="-1" role="dialog" aria-labelledby="compeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="compeleteModalLabel">Upload Status</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p class="lead">The upload was completed successfully.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" runat="server"
                        data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Fail Modal -->
    <div class="modal fade" id="failModal" tabindex="-1" role="dialog" aria-labelledby="compeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="failModalLabel">Upload Status</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p class="lead">The upload failed.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" runat="server"
                        data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
