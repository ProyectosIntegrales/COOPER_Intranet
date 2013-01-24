<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEmpty.master" AutoEventWireup="false"
    CodeFile="adm_Menus.aspx.vb" Inherits="app_addIns_adm_Menus" %>


<%@ Register Src="adm_ChildMenus.ascx" TagName="adm_ChildMenus" TagPrefix="uc1" %>
<%@ Register Src="../app_controls/cntrlButtons.ascx" TagName="cntrlButtons" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .dotBottom
        {
            border-bottom: 1px dotted #999999;
        }
        .sideDots
        {
            border-left: 1px dotted #999999;
            border-right: 1px dotted #999999;
        }
        .padb2
        {
            padding-bottom: 2px;
        }
        .padr2
        {
            padding-right: 2px;
            margin-right: 2px;
        }

    </style>
    <asp:SqlDataSource ID="dsTopMenu" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
        SelectCommand="SELECT menuID, menuTextESP,  menuTextENG, menuSection  FROM tblMenuItems WHERE (ISNULL(menuParent, 0) = 0) AND (menuID &gt; 0) ORDER BY menuSortKey">
    </asp:SqlDataSource>
    <table cellpadding="0" cellspacing="0" width="100%" >
        <tr>
            <td style="width: 5px; border-right-style: solid; border-right-width: 1px;
                border-right-color: #FFFFFF; background-color: #808080;">
                &nbsp;
            </td>
            <asp:Repeater ID="repTopMenu" runat="server" DataSourceID="dsTopMenu">
                <ItemTemplate>
                    <td valign="middle" >
                        <asp:Panel ID="pnlTopMenu" runat="server" Wrap="False" >
                            <table cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td  >
                                        <asp:ImageButton ID="imbLeft" runat="server" ImageUrl="~/images/Icons/arrowlf.png"
                                            OnClick="moveLf" CommandArgument='<%# Bind("menuID") %>' />
                                    </td>
                                    <td style="padding-bottom: 2px; margin-bottom: 2px;">
                                        <asp:LinkButton ID="lnbMenuTextEsp" runat="server" Text='<%# Bind("menuTextEsp") %>'
                                            OnClick="selectedMenuItem" CommandArgument='<%# Bind("menuID") %>'></asp:LinkButton>
                                    </td>
                                    <td >
                                        <asp:ImageButton ID="imbRight" runat="server" ImageUrl="~/images/Icons/arrowrt.png"
                                            OnClick="moveRt" CommandArgument='<%# Bind("menuID") %>' />
                                    </td>
                                </tr>
                               
                            </table>
                            <asp:HiddenField ID="hflSection" runat="server" Value='<%# Bind("menuSection") %>' />
                        </asp:Panel>
                    </td>
                </ItemTemplate>
            </asp:Repeater>
            <td style="border-style: dotted dotted dotted none; border-width: 1px; border-color: #FFFFFF; background-color: #000000; " 
                valign="middle" nowrap="nowrap">
                <asp:Panel ID="pnlAdd" runat="server" CssClass="blackMenu" >
                    <div >
                        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png"
                            Visible="True" ImageAlign="Middle" />&nbsp;<asp:LinkButton ID="lnbAdd" runat="server">Agregar Botón</asp:LinkButton></div>
                </asp:Panel>
            </td>
            <td class="noborderx" width="50%" style="background-color: #000000">
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlDetails" runat="server" BorderColor="#ff0000" BorderWidth="2" BorderStyle="Solid"
        Visible="false" Style="padding: 5px" Font-Size="9pt" BackColor="#CCCCCC">
        <uc1:adm_ChildMenus ID="adm_ChildMenus1" runat="server" />
        <br />
        <table width="100%">
            <tr>
                <td align="right" valign="top">
                    Texto de Botón:
                </td>
                <td valign="top" width="100">
                    <asp:TextBox ID="txtMenuTextEsp" runat="server" CssClass="textbox"></asp:TextBox>
                </td>
                <td align="right" rowspan="2" valign="top">
                    &nbsp;</td>
                <td valign="top">
                    <asp:DropDownList ID="ddlsectionEsp" runat="server" CssClass="textbox" DataSourceID="dsSectionEsp"
                        DataTextField="sectionTitleEsp" DataValueField="sectionID" AutoPostBack="True"
                        Width="100%">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="dsSectionEsp" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
                        
                        SelectCommand="SELECT sectionID, CASE WHEN sectionID &gt; 0 THEN CAST(sectionID AS varchar) + ' - ' ELSE '' END + sectionTitleEsp AS sectionTitleEsp FROM vSections"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top">
                    &nbsp;</td>
                <td valign="top" width="100">
                    &nbsp;</td>
                <td valign="top">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td width="100">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
                    <uc2:cntrlButtons ID="cntrlButtons1" runat="server" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="hflMenuId" runat="server" />
    <asp:HiddenField ID="hflMenuParent" runat="server" Value="0" />
</asp:Content>
