<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlDocTypeMenu.ascx.vb"
    Inherits="cdd_cntrlDocTypeMenu" %>
<table cellpadding="0" cellspacing="0">
    <tr>
        <asp:Repeater ID="repTypes" runat="server" DataSourceID="dsTypes">
            <ItemTemplate>
                <td >
                <asp:Panel ID="pnlMenu" runat="server" CssClass="grayMenu">
                    <asp:LinkButton ID="lnbType" runat="server" Text='<%# Eval("typeName") %>' OnClick="lnbClick" CommandArgument='<%# Eval("documentType") %>'></asp:LinkButton>
                    </asp:Panel>
                </td>
            </ItemTemplate>
        </asp:Repeater>
    </tr>
</table>
<asp:HiddenField ID="hflArea" runat="server" />
<asp:HiddenField ID="hflType" runat="server" />
<asp:SqlDataSource ID="dsTypes" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    ProviderName="<%$ ConnectionStrings:COOPER_IntranetConnectionString.ProviderName %>" 
    
    
    SelectCommand="SELECT cdd.tblDocuments.documentType FROM cdd.tblDocuments INNER JOIN cdd.tblDocTypes ON cdd.tblDocuments.documentType = cdd.tblDocTypes.typeID WHERE (cdd.tblDocuments.documentAreaID = @Area) GROUP BY cdd.tblDocuments.documentType, cdd.tblDocTypes.typeNameESP, cdd.tblDocuments.documentAuthLevel HAVING (cdd.tblDocuments.documentAuthLevel &gt; 0) ORDER BY cdd.tblDocuments.documentType">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflArea" Name="Area" PropertyName="Value" />
    </SelectParameters>
</asp:SqlDataSource>
