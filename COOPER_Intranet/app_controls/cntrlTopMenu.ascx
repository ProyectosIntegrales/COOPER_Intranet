<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlTopMenu.ascx.vb"
    Inherits="cntrlTopMenu" %>
<table cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td class="noborder" style="width: 5px; border-right-style: solid; border-right-width: 1px;
            border-right-color: #FFFFFF;">
            &nbsp;
        </td>
        <td class="noborder" style="background-color: #000000">
        <table cellpadding="0" cellspacing="0">
        <tr>
        
   
        <asp:Repeater ID="repTopMenu" runat="server" DataSourceID="dsTopMenu">
            <ItemTemplate>
                <td style="background-color: #000000" valign="middle">
                    <asp:Panel ID="pnlTopMenu" runat="server" Wrap="False">
                        <asp:LinkButton ID="lnbTopmenu" runat="server" Text='<%# Bind("menuText") %>' OnClick="selectMenuItem"
                            CommandArgument='<%# Bind("menuID") %>'></asp:LinkButton>
                    </asp:Panel>
                </td>
            </ItemTemplate>
        </asp:Repeater>
             </tr>
        </table>
        </td>
        <td class="noborder" width="50%" style="background-color: #000000">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td class="noborder" style="width: 5px; border-right-style: solid; border-right-width: 1px;
            border-right-color: #FFFFFF; background-color: #666666;">
            &nbsp;
        </td>
        <td colspan="20" class="noborder" style="height: 20px; background-color: #666666;">
            <table cellpadding="0" cellspacing="0" style="height: 20px">
                <tr>
                    <asp:Repeater ID="repMenuChilds" runat="server">
                        <ItemTemplate>
                            <td align="center" style="padding-left:15px; padding-right: 15px; padding-bottom:3px; padding-top: 3px;">
                                <asp:Panel ID="pnlChildMenu" runat="server" Wrap="False" CssClass="menuChild" >
                                    <asp:LinkButton ID="lnbChildmenu" runat="server" Text='<%# Bind("menuText") %>' OnClick="selectMenuChild"
                                        CommandArgument='<%# Bind("menuID") %>'></asp:LinkButton>
                                </asp:Panel>
                            </td>
                        </ItemTemplate>
                    </asp:Repeater>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:SqlDataSource ID="dsTopMenu" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    SelectCommand="SELECT menuID, menuTextESP AS menuText FROM tblMenuItems WHERE (ISNULL(menuParent, 0) = 0) AND (menuID &gt; 0) AND (@isAdmin = 0) OR (ISNULL(menuParent, 0) = 0) AND (menuID &gt; 0 OR menuID &lt; 0) AND (@isAdmin = 1) ORDER BY menuSortKey">
    <SelectParameters>
        <asp:SessionParameter Name="isAdmin" SessionField="isAdmin" />
    </SelectParameters>
</asp:SqlDataSource>
