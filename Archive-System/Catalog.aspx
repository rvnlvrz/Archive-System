<%@ Page Title="Catalog" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalog.aspx.cs" Inherits="Archive_System.Catalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container">
            <asp:UpdatePanel runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="LvwDocuments" />
                    <asp:AsyncPostBackTrigger ControlID="Drp_Filter" />
                </Triggers>
                <ContentTemplate>
                    <asp:HiddenField ID="Hfd_ID" runat="server" />
                    <div class="form-group">
                        <div class="form-inline">
                            <asp:Label ID="Label1" runat="server" Text="Filter:" CssClass="mr-1 text-uppercase lead"></asp:Label>
                            <div class="mt-3 mb-3"></div>
                            <asp:DropDownList ID="Drp_Filter" runat="server" CssClass="custom-select" OnSelectedIndexChanged="Drp_Filter_SelectedIndexChanged"
                                AutoPostBack="true">
                                <asp:ListItem Value="0">All</asp:ListItem>
                                <asp:ListItem Value="1">Thesis</asp:ListItem>
                                <asp:ListItem Value="2">Capstone</asp:ListItem>
                                <asp:ListItem Value="3">Has attachment</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <asp:ListView ID="LvwDocuments" runat="server" DataKeyNames="docID" DataSourceID="SqlDataSource1" GroupItemCount="4" 
                        OnItemCommand="LvwDocuments_ItemCommand">
                        <EmptyDataTemplate>
                            <table runat="server" style="">
                                <tr>
                                    <td>No data was returned.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <EmptyItemTemplate>
                            <td runat="server" />
                        </EmptyItemTemplate>
                        <GroupTemplate>
                            <tr id="itemPlaceholderContainer" runat="server">
                                <td id="itemPlaceholder" runat="server"></td>
                            </tr>
                        </GroupTemplate>
                        <ItemTemplate>
                            <td runat="server" style="">
                                <div class="card text-center mb-3 mr-3" style="width: 18rem; height: 25rem;">
                                    <div class="card-header">
                                        <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("Category") %>' CssClass="h5" />
                                    </div>
                                    <div class="card-body text-center mb-0">
                                        <img src="Images/placeholder286x180.svg" class="card-img-top img-thumbnail" />
                                        <p class="h6 align-middle mt-3 mb-0">
                                            <asp:Label ID="authorLabel" runat="server" Text='<%# CleanTitle(Eval("Document")) %>' />
                                        </p>
                                    </div>
                                    <div class="card-footer text-muted">
                                        <div class="my-1">
                                            <asp:Button ID="BtnViewDocument" runat="server" Text="View Details" CssClass="btn btn-library-10 btn-block"
                                                CommandArgument='<%# Eval("docID") %>' CausesValidation="false" data-toggle="modal" data-target="#documentModal" />
                                        </div>
                                    </div>
                                </div>
                                <br />
                            </td>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" class="table-responsive-sm">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="groupPlaceholderContainer" runat="server" border="0" style="">
                                            <tr id="groupPlaceholder" runat="server">
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style=""></td>
                                </tr>
                            </table>
                            <div class="text-center">
                                <asp:DataPager ID="DataPagerProducts" runat="server" PagedControlID="LvwDocuments"
                                    PageSize="8" OnPreRender="DataPagerProducts_PreRender">
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
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
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
                                        <asp:Label ID="documentNameLabel" runat="server" CssClass="lead font-weight-bold" Text='<%# CleanTitle(Eval("documentName")) %>' />
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

    <asp:SqlDataSource ID="SDT_DocumentData" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Name], [documentName], [attachmentName] FROM [DocumentSets] WHERE ([ID] = @ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="Hfd_ID" Name="ID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="            SELECT docID, Category, Document FROM DocumentMetaPlain WHERE Category = 'Thesis'
                GROUP BY docID, Category, Document
                ORDER BY Category"></asp:SqlDataSource>
</asp:Content>
