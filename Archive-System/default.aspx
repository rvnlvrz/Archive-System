<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Archive_System.Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid row justify-content-center align-items-center parallax" id="searchbox">
        <div class="wrap">
            <div class="">
                <div class="container white-box">
                    <div class="wrap">
                        <div class="container ">
                            <div class="form-group mb-1">
                                <asp:Label ID="lbl_searchbox" runat="server" Text="Search for" CssClass="lead col-form-label text-uppercase"></asp:Label>
                                <asp:TextBox ID="TbxSearchTerms" runat="server" CssClass="form-control form-control-lg"
                                    placeholder="Thesis, Neural Network...">
                                </asp:TextBox>
                            </div>
                            <div class="form-inline">
                                <asp:Label ID="Label3" runat="server" Text="Limit search to:" CssClass="mr-1 text-uppercase lead"></asp:Label>
                                <asp:DropDownList ID="DrpItem" runat="server" CssClass="custom-select mr-1 mt-1 mb-1">
                                    <asp:ListItem>Documents</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="DrpWords" runat="server" CssClass="custom-select mr-1 mr-1 mt-1 mb-1">
                                    <asp:ListItem>that contain exact words from my query</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="DrpField" runat="server" CssClass="custom-select mr-1 mr-1 mt-1 mb-1">
                                    <asp:ListItem Value="all">in all fields</asp:ListItem>
                                    <asp:ListItem Value="title">in title</asp:ListItem>
                                    <asp:ListItem Value="auth">in author</asp:ListItem>
                                    <asp:ListItem Value="cat">in category</asp:ListItem>
                                </asp:DropDownList>
                                <div class="text-right ml-auto">
                                    <asp:Button ID="BtnSearchDocs" runat="server" Text="SEARCH" CssClass="btn btn-library-10" Font-Size="18px"
                                        OnClick="BtnSearchDocs_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
