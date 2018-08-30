<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="Archive_System.Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid parallax">
        <div class="wrap">
            <div class="col-sm-12">
                <div class="pt-5 mt-3">
                    <div class="container white-box">
                        <div class="wrap">
                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <asp:Label ID="Lbl_AuthA" runat="server" Text="First Author" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                        <div class="form-row">
                                            <div class="form-group col-sm-6">
                                                <asp:TextBox ID="Tbx_AuthA_First" runat="server" CssClass="form-control" placeholder="first name"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <asp:TextBox ID="Tbx_AuthA_Last" runat="server" CssClass="form-control" placeholder="last name"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <asp:Label ID="Label1" runat="server" Text="Second Author" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                            </div>
                                            <div class="col-sm-6 form-check">
                                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Not Applicable" CssClass="form-check-input" TextAlign="Right" />
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-sm-6">
                                                <asp:TextBox ID="Tbx_AuthB_First" runat="server" CssClass="form-control" placeholder="first name"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <asp:TextBox ID="Tbx_AuthB_Last" runat="server" CssClass="form-control" placeholder="last name"></asp:TextBox>
                                            </div>
                                        </div>
                                        <asp:Label ID="Label2" runat="server" Text="Third Author" CssClass="mr-1 mb-3 text-uppercase lead"></asp:Label>
                                        <div class="form-row">
                                            <div class="form-group col-sm-6">
                                                <asp:TextBox ID="Tbx_AuthC_First" runat="server" CssClass="form-control" placeholder="first name"></asp:TextBox>
                                            </div>
                                            <div class="form-group col-sm-6">
                                                <asp:TextBox ID="Tbx_AuthC_Last" runat="server" CssClass="form-control" placeholder="last name"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:Label ID="lbl_uploadBox" runat="server" Text="Document Upload" CssClass="lead col-form-label text-uppercase"></asp:Label>
                                        <div class="wrap border border-danger rounded">
                                            <asp:FileUpload ID="FileUpload_Documents" runat="server" />
                                        </div>
                                        <div class="mt-2 text-right">
                                            <asp:Button ID="Btn_Upload" runat="server" Text="Upload" CssClass="btn btn-primary" OnClick="Btn_Upload_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
