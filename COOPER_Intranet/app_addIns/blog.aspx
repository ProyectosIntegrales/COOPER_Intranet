<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEmpty.master" AutoEventWireup="false" CodeFile="blog.aspx.vb" Inherits="app_addIns_blog" %>
<%@ Register Src="../app_controls/cntrlEditor.ascx" TagName="cntrlEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<asp:SqlDataSource ID="dsContent" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
        SelectCommand="SELECT itemID, itemSection, itemHeader, itemText, itemDate, itemOrder, itemDeleted, itemImageURL FROM tblContent WHERE (itemSection = @itemSection) AND (ISNULL(itemDeleted, 0) = 0) ORDER BY itemOrder">
    <SelectParameters>
        <asp:SessionParameter Name="itemSection" SessionField="sectionID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:Repeater ID="repContent" runat="server" DataSourceID="dsContent">
    <ItemTemplate>
        <asp:Panel ID="pnlContent" runat="server">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="150" style="width:150px;">
                        <div style="width: 150px; height: 150px; overflow: hidden">
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# iif(Eval("itemImageURL")<>"","~/" & Eval("itemImageURL"),"~/images/body/tag.png") %>'
                                Height="150" />
                        </div>
                    </td>
                    <td valign="top" style="padding-left: 15px" width="100%">
                        <table cellpadding="0" cellspacing="0" width="100%" style="margin-bottom: 8px">
                            <tr>
                                <td width="100%" >
                                    <asp:Label ID="lblHeader" runat="server" Text='<%# Bind("itemHeader") %>' CssClass="bodyHeader"></asp:Label>
                                </td>
                                <td style="width: 16px" valign="top">
                                    <asp:ImageButton ID="imbUp" runat="server" ImageUrl="~/images/Icons/arrowup.png"
                                        Height="8" OnClick="moveUp" CommandArgument='<%# Bind("itemID") %>' />
                                    <asp:ImageButton ID="imbDn" runat="server" ImageUrl="~/images/Icons/arrowdn.png"
                                        Height="8" OnClick="moveDn" CommandArgument='<%# Bind("itemID") %>' />
                                </td>
                                <td width="16" align="right" valign="top">
                                    <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png"
                                        ImageAlign="Middle" OnClick="editContent" CommandArgument='<%# Bind("itemID") %>'
                                        Visible="True" />
                                </td>
                            </tr>
                        </table>
                        <asp:Label ID="lblContent" runat="server" Text='<%# Bind("itemText") %>'></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </ItemTemplate>
    <SeparatorTemplate>
        <div class="panelAddContent" style="margin-top: 10px; padding-bottom: 10px">
        </div>
    </SeparatorTemplate>
    <FooterTemplate>
        <asp:Label ID="lblEmptyData" runat="server"></asp:Label><br />
        <asp:Label ID="lblEmptyData1" runat="server"></asp:Label>
        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/new.png"
            OnClick="imbAdd_click" />
        <asp:Label ID="lblEmptyData2" runat="server"></asp:Label>
    </FooterTemplate>
</asp:Repeater>
<asp:Panel ID="pnlAdd" runat="server" Visible="false">
    <div class="panelAddContent">
        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/new.png" />
    </div>
</asp:Panel>

</asp:Content>

