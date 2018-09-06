<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Archive_System.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container white-box">
            <div class="wrap mt-4">
                <div class="container">
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
                            <asp:Button ID="BtnSearchDocuments" runat="server" Text="SEARCH" CssClass="btn btn-library-10" Font-Size="18px"
                                OnClick="BtnSearchDocuments_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="wrap">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="Hfd_ID" runat="server" />
                        <asp:ListView ID="Lvw_Results" runat="server" DataSourceID="SDT_Results" OnItemCommand="Lvw_Results_ItemCommand">
                            <EmptyDataTemplate>
                                <span>No Documents were found based on your criteria.</span>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <br />
                                <div class="container">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="container">
                                                <div class="row align-items-center">
                                                    <div class="col col-md-2">
                                                        <img src="Images/placeholder286x180.svg" class="img-thumbnail" />
                                                    </div>
                                                    <div class="col col-sm-8">
                                                        <div class="container">
                                                            <br />
                                                            <p class="h5">
                                                                <strong>
                                                                    <asp:Label ID="DocumentLabel" runat="server" Text='<%# CleanTitle(Eval("Document")) %>' />
                                                                </strong>
                                                            </p>
                                                            <p class="h6">
                                                                <asp:Label ID="CategoryLabel" runat="server" Text='<%# Eval("Category") %>' />
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="col align-self-center">
                                                        <asp:Button ID="BtnViewDetails" runat="server" Text="View Details" CssClass="btn btn-library btn-block"
                                                            CommandArgument='<%# Eval("docID") %>' CausesValidation="false" data-toggle="modal"
                                                            data-target="#documentModal" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <span style=""></span>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <div id="itemPlaceholderContainer" runat="server" style="">
                                    <span runat="server" id="itemPlaceholder" />
                                </div>
                                <div class="wrap text-center">
                                    <asp:DataPager ID="DataPagerProducts" runat="server" PagedControlID="Lvw_Results"
                                        PageSize="8">
                                        <Fields>
                                            <asp:NextPreviousPagerField ShowFirstPageButton="False" ShowNextPageButton="False"
                                                ButtonCssClass="btn btn-library-10 text-white" PreviousPageText="<" FirstPageText="|<" />
                                            <asp:NumericPagerField NumericButtonCssClass="btn btn-secondary" CurrentPageLabelCssClass="btn btn-success bg-mapuan-gold" />
                                            <asp:NextPreviousPagerField ShowLastPageButton="False" ShowPreviousPageButton="False"
                                                ButtonCssClass="btn btn-library-10 text-white" NextPageText=">" LastPageText=">|" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </LayoutTemplate>
                        </asp:ListView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="documentModal" tabindex="-1" role="dialog" aria-labelledby="documentModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Lbl_Catgory" runat="server" Text='<%# GetCategory() %>' CssClass="h5"></asp:Label>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <h5 class="modal-title" id="exampleModalLongTitle"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" ChildrenAsTriggers="true">
                    <Triggers>
                        <asp:PostBackTrigger ControlID="Btn_DownloadAttachment" />
                        <asp:PostBackTrigger ControlID="FvwBtn_Download" />
                    </Triggers>
                    <ContentTemplate>
                        <div class="modal-body">
                            <asp:FormView ID="FVW_DocumentDetails" runat="server" DataSourceID="SDT_DocumentData" DefaultMode="ReadOnly" CssClass="w-100">
                                <ItemTemplate>
                                    <div class="container text-center">
                                        <img src="Images/placeholder286x180.svg" class="img-thumbnail" />
                                        <div class="d-block w-100 mb-3"></div>
                                        <asp:Label ID="documentNameLabel" runat="server" CssClass="lead" Text='<%# CleanTitle(Eval("documentName")) %>' />
                                        <div class="mt-2">
                                            <i class="fa fa-calendar lead" aria-hidden="true"></i>&nbsp;
                                            <asp:Label ID="Label2" runat="server" CssClass="lead" Text='<%# Eval("UploadDate", "{0:d}") %>' />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:FormView>
                            <div class="container text-center mt-2">
                                <i class="fas fa-user lead"></i>&nbsp;
                                <asp:Label ID="Lbl_Authors" runat="server" CssClass="lead" Text='<%# GetAuthors() %>'></asp:Label>
                                <div class="form-group mt-2">
                                    <asp:Button ID="FvwBtn_Download" runat="server" Text="Download Document" OnClick="FvwBtn_Download_ServerClick"
                                        CssClass="btn btn-success" />
                                    <div class="d-block w-100 mt-2"></div>
                                    <asp:Button ID="Btn_DownloadAttachment" runat="server" Text='<%# SetText() %>' Enabled='<%# HasAttachment() %>' CssClass="btn btn-primary"
                                        OnClick="Btn_DownloadAttachment_Click" />
                                </div>
                                <div class="form-group">
                                </div>
                            </div>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SDT_DocumentData" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Name], [documentName], [attachmentName], [UploadDate] FROM [DocumentSets] WHERE ([ID] = @ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Hfd_ID" Name="ID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="SDT_Results" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" />
</asp:Content>
