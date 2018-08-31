<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Catalog.aspx.cs" Inherits="Archive_System.Catalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="wrap">
        <div class="container">
            <asp:ListView ID="LvwDocuments" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1" GroupItemCount="4" OnItemCommand="LvwDocuments_ItemCommand">
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
                                <asp:Label ID="titleLabel" runat="server" Text="Thesis" CssClass="h5" />
                            </div>
                            <div class="card-body text-center mb-0">
                                <img src="Images/placeholder286x180.svg" class="card-img-top img-thumbnail" />
                                <p class="h6 align-middle mt-3 mb-0">
                                    <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("Name") %>' />
                                </p>
                            </div>
                            <div class="card-footer text-muted">
                                <div class="my-1">
                                    <asp:Button ID="BtnRequestRent" runat="server" Text="Download" CssClass="btn btn-library-10 btn-block"
                                        CommandArgument='<%# Eval("ID") %>' CausesValidation="false" />
                                </div>
                            </div>
                        </div>
                        <br />
                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
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
                </LayoutTemplate>
            </asp:ListView>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="documentModal" tabindex="-1" role="dialog" aria-labelledby="documentModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Thesis</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:FormView ID="FVW_DocumentDetails" runat="server"></asp:FormView>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="SDT_DocumentData" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" ProviderName="<%$ ConnectionStrings:DefaultConnection.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [Documents]"></asp:SqlDataSource>
</asp:Content>
