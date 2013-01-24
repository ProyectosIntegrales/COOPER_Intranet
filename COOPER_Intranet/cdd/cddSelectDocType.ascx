<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddSelectDocType.ascx.vb" Inherits="cdd_cddSelectDocType" %>

<asp:SqlDataSource ID="dsDocTypes" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    
    
    
    
    
    SelectCommand="SELECT cdd.tblDocTypes.typeID, cdd.tblDocTypes.typeNameESP FROM cdd.tblDocTypes INNER JOIN cdd.tblDocuments ON cdd.tblDocTypes.typeID = cdd.tblDocuments.documentType WHERE (ISNULL(cdd.tblDocuments.documentDeptoID, 0) = @deptoID) AND (ISNULL(cdd.tblDocuments.documentAreaID, 0) = @areaID) AND (ISNULL(cdd.tblDocuments.documentCeldaID, 0) = @celdaID) AND (cdd.tblDocuments.documentAuthLevel &gt;= - 1) OR (ISNULL(cdd.tblDocuments.documentDeptoID, 0) = @deptoID) AND (ISNULL(cdd.tblDocuments.documentCeldaID, 0) = @celdaID) AND (@areaID = 0) OR (ISNULL(cdd.tblDocuments.documentAreaID, 0) = @areaID) AND (ISNULL(cdd.tblDocuments.documentCeldaID, 0) = @celdaID) AND (@deptoID = 0) OR (ISNULL(cdd.tblDocuments.documentCeldaID, 0) = @celdaID) AND (@areaID = 0) AND (@deptoID = 0) OR (ISNULL(cdd.tblDocuments.documentDeptoID, 0) = @deptoID) AND (ISNULL(cdd.tblDocuments.documentAreaID, 0) = @areaID) OR (ISNULL(cdd.tblDocuments.documentDeptoID, 0) = @deptoID) AND (@areaID = 0) AND (@celdaID = 0) OR (ISNULL(cdd.tblDocuments.documentAreaID, 0) = @areaID) AND (@deptoID = 0) AND (@celdaID = 0) OR (@areaID = 0) AND (@deptoID = 0) AND (@celdaID = 0) GROUP BY cdd.tblDocTypes.typeID, cdd.tblDocTypes.typeNameESP">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflDeptoID" DefaultValue="0" Name="deptoID" 
            PropertyName="Value" />
        <asp:ControlParameter ControlID="hflAreaID" DefaultValue="0" Name="areaID" 
            PropertyName="Value" />
        <asp:ControlParameter ControlID="hflCeldaID" DefaultValue="0" Name="celdaID" 
            PropertyName="Value" />
    </SelectParameters>
</asp:SqlDataSource>
<table cellpadding="0" cellspacing="0">
<tr>
<asp:Repeater ID="Repeater1" runat="server" DataSourceID="dsDocTypes">
<ItemTemplate>
<td>
<asp:Panel ID="pnlDocType" runat="server" CssClass="grayMenu">
<asp:LinkButton id="lnbDocType" runat="server" Text='<%# Bind("typenameESP") %>' CommandArgument='<%# Bind("typeID") %>' OnClick="selectDocType" Font-Size="8"></asp:LinkButton>
</asp:Panel>
</td>
</ItemTemplate>
</asp:Repeater>

</tr>
</table>
<asp:HiddenField ID="hflDeptoID" runat="server" Value="0" />
<asp:HiddenField ID="hflAreaID" runat="server" Value="0" />
<asp:HiddenField ID="hflCeldaID" runat="server" Value="0" />

<asp:HiddenField ID="hflSelectedDocType" runat="server" Value="0" />
