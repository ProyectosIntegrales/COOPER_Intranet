<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlLeftSide.ascx.vb"
    Inherits="app_controls_cntrlLeftSide" %>

<%@ Register src="cntrlEditor.ascx" tagname="cntrlEditor" tagprefix="uc1" %>

<asp:SqlDataSource ID="dsLeftSide" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    SelectCommand="SELECT itemID, itemSection, itemHeader, itemText, itemDate, itemOrder, itemDeleted FROM tblLeftSide WHERE (itemSection = @itemSection) AND (ISNULL(itemDeleted, 0) = 0) ORDER BY itemOrder">
    <SelectParameters>
        <asp:SessionParameter Name="itemSection" SessionField="parentID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:Repeater ID="repLeftSide" runat="server" DataSourceID="dsLeftSide">
    <ItemTemplate>
        <asp:Panel ID="pnlLeftSideItem" runat="server"  Width="200" style="padding-left:10px; padding-right:10px; width:200px;">
            <table cellpadding="0" cellspacing="0" style="margin-bottom: 10px;" width="200">
                <tr>
                    <td class="leftSideHeader"  style="padding: 3px; width:190px">
                        <asp:Label ID="lblHeader" runat="server" Text='<%# Bind("itemHeader") %>' ></asp:Label>
                    </td>
                    <td style="width: 12px" class="leftSideHeader" align="right">
                    <asp:ImageButton ID="imbUp" runat="server" ImageUrl="~/images/Icons/arrowup.png" Height="8" OnClick="moveUp" CommandArgument='<%# Bind("itemID") %>'  />
                    <asp:ImageButton ID="imbDn" runat="server" ImageUrl="~/images/Icons/arrowdn.png" Height="8" OnClick="moveDn" CommandArgument='<%# Bind("itemID") %>'  />
                    </td>
                    <td align="right" class="leftSideHeader" style="padding-right:3px;" >
                        <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png"
                            ImageAlign="Middle" OnClick="editLeftSide" CommandArgument='<%# Bind("itemID") %>' />
                    </td>
                </tr>
                <tr>
                    <td class="leftSideText" colspan="3" style="padding: 3px">
                        <asp:Label ID="lblContent" runat="server" Text='<%# Bind("itemText") %>'></asp:Label>
                    </td>
                </tr>
            </table>

        </asp:Panel>
        
    </ItemTemplate>
</asp:Repeater>
<asp:Panel ID="pnlAdd" runat="server" Visible="false" Width="200" style="padding-left:10px; padding-right:10px; width:200px;">
    <div class="panelAddLeft">
        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/new.png" />
    </div>
</asp:Panel>
<uc1:cntrlEditor ID="cntrlEditor1" runat="server" />

