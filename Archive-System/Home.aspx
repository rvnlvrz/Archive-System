<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Archive_System.Home" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid parallax" id="searchbox">
        <div class="wrap">
            <div class="col-sm-12">
                <div class="pt-5 mt-5">
                    <div class="container" id="searchbox-inner">
                        <div class="wrap">
                            <div class="container">
                                <div class="form-group mb-1">
                                    <asp:Label ID="lbl_searchbox" runat="server" Text="Search for" CssClass="lead col-form-label text-uppercase"></asp:Label>
                                    <asp:TextBox ID="TbxSearchTerms" runat="server" CssClass="form-control form-control-lg"
                                        placeholder="Alaska, Fiction...">
                                    </asp:TextBox>
                                </div>
                                <div class="form-inline">
                                    <asp:Label ID="Label3" runat="server" Text="Limit search to:" CssClass="mr-1 text-uppercase lead"></asp:Label>
                                    <asp:DropDownList ID="DrpItem" runat="server" CssClass="custom-select mr-1 mt-1 mb-1">
                                        <asp:ListItem>Books</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DrpWords" runat="server" CssClass="custom-select mr-1 mr-1 mt-1 mb-1">
                                        <asp:ListItem>that contain exact words from my query</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DrpField" runat="server" CssClass="custom-select mr-1 mr-1 mt-1 mb-1">
                                        <asp:ListItem Value="all">in all fields</asp:ListItem>
                                        <asp:ListItem Value="title">in title</asp:ListItem>
                                        <asp:ListItem Value="auth">in author</asp:ListItem>
                                        <asp:ListItem Value="pub">in publisher</asp:ListItem>
                                        <asp:ListItem Value="isbn">in ISBN</asp:ListItem>
                                        <asp:ListItem Value="callnum">in call number</asp:ListItem>
                                    </asp:DropDownList>
                                    <div class="text-right ml-auto">
                                        <asp:Button ID="BtnSearchLib" runat="server" Text="SEARCH" CssClass="btn btn-library-10" Font-Size="18px" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container pt-5">
                        <div class="row">
                            <div class="col-md-4 mb-4">
                                <div class="card mapuan-card">
                                    <div class="card-body">
                                        <div class="row justify-content-center">
                                            <div class="col-xs-3">
                                                <i class="ai ai-acm ai-5x"></i>
                                            </div>
                                            <div class="col-xs-3">
                                                <i class="ai ai-springer ai-5x"></i>
                                            </div>
                                            <div class="w-100"></div>
                                            <div class="col-xs-3">
                                                <i class="ai ai-researchgate ai-5x" id="rg"></i>
                                            </div>
                                            <div class="col-xs-3">
                                                <i class="ai ai-ieee ai-5x"></i>
                                            </div>
                                        </div>
                                        <hr class="mapuan-hr" />
                                        <p class="text-center lead">
                                            Ut vitae sapien neque. Aenean tempor quam nibh, in commodo mauris lobortis maximus. Fusce imperdiet.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-4">
                                <div class="card mapuan-card">
                                    <div class="card-body">
                                        <div class="text-center">
                                            <span class="fa fa-upload fa-10x"></span>
                                        </div>
                                        <hr class="mapuan-hr" />
                                        <p class="text-center lead">
                                            Pellentesque interdum blandit quam, quis blandit leo lacinia non. Proin ac efficitur magna. Proin erat.
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-4">
                                <div class="card mapuan-card">
                                    <div class="card-body">
                                        <div class="text-center">
                                            <i class="fas fa-school fa-10x"></i>
                                        </div>
                                        <hr class="mapuan-hr" />
                                        <p class="text-center lead">
                                            Aliquam leo tortor, mattis ullamcorper interdum sed, sollicitudin ac diam. Ut efficitur tortor at lacus.
                                        </p>
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
