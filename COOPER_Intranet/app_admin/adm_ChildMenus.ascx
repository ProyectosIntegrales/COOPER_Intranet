<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adm_ChildMenus.ascx.vb"
    Inherits="app_admin_adm_ChildMenus" %>
<style type="text/css">
    .padb2
    {
        padding-bottom: 2px;
    }
    .padr2
    {
        padding-right: 2px;
        margin-right: 2px;
    }
    .selected
    {
        border: 1px dotted #FFFFFF;
         text-align: center;
        height: 25px;
        width: 100%;
    }
    
    .selected a { text-decoration:underline; }
    .unselected
    {
        text-align: center;
        height: 25px;
        width: 100%;
    }
</style>
<div style="background-color: #666; ">
    <table cellspacing="0" cellpadding="0" >
        <tr>
            <asp:Repeater ID="repChilds" runat="server" DataSourceID="dsMenus">
                <ItemTemplate>
                    <td class="menuChild" valign="middle" nowrap="nowrap" align="center">
                        <asp:Panel ID="pnlChild" runat="server" CssClass="unselected">
                        <table cellpadding="0" cellspacing="0">
                        <tr>
                        <td style="padding-top: 5px">
                        <asp:ImageButton ID="imbLeft" runat="server" ImageUrl="~/images/Icons/arrowlf.png" OnClick="moveLf" CommandArgument='<%# Bind("menuID") %>' />
                        </td>
                        <td style="padding-bottom: 2px; margin-bottom: 2px; padding-top:2px;
                                padding-right: 20px; padding-left: 20px;">
                         <asp:LinkButton ID="lnbChildEsp" Text='<%# Bind("menuTextEsp") %>' runat="server"
                                    OnClick="Selected" CommandArgument='<%# Bind("menuId") %>' />
                        </td>
                        <td style="padding-top: 5px">
                        <asp:ImageButton ID="imbRight" runat="server" ImageUrl="~/images/Icons/arrowrt.png" OnClick="moveRt" CommandArgument='<%# Bind("menuID") %>' />
                        </td>
                        </tr>
                        
                        </table>
                         
                        </asp:Panel>
                    </td>
                </ItemTemplate>
            </asp:Repeater>
            <td class="menuChild" valign="middle" nowrap="nowrap" align="center">
                <asp:Panel ID="pnlAdd" runat="server" CssClass="unselected" >
                   <div style="padding-top:4px;"><asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png"
                        Visible="True" ImageAlign="Middle" />
                    <asp:LinkButton ID="lnbAdd" runat="server" 
                    >Agregar Botón</asp:LinkButton></div>
                </asp:Panel>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="hflParentMenu" runat="server" />
<asp:HiddenField ID="hflSelectedID" runat="server" />
<asp:SqlDataSource ID="dsMenus" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    SelectCommand="SELECT tblMenuItems.menuID, tblMenuItems.menuTextESP, tblMenuItems.menuTextENG, vSections.sectionID, vSections.sectionTitleEsp, vSections.sectionTitleEng FROM tblMenuItems INNER JOIN vSections ON ISNULL(tblMenuItems.menuSection, - 1000) = vSections.sectionID WHERE (tblMenuItems.menuParent = @menuParent) ORDER BY tblMenuItems.menuSortKey">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflParentMenu" Name="menuParent" PropertyName="Value" />
    </SelectParameters>
</asp:SqlDataSource>
