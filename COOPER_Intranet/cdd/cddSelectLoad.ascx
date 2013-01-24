<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddSelectLoad.ascx.vb" Inherits="cdd_cddSelectLoad" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<style type="text/css">

</style>
<asp:LinkButton ID="lnbDeptoName" runat="server"></asp:LinkButton>

<asp:Label ID="lblSep1" runat="server" Text=">"></asp:Label>

<asp:LinkButton ID="lnbAreaName" runat="server"></asp:LinkButton>

<asp:Label ID="lblSep2" runat="server" Text=">"></asp:Label>

<asp:LinkButton ID="lnbCeldaName" runat="server"></asp:LinkButton>

<asp:HoverMenuExtender ID="lnbCeldaName_HoverMenuExtender" runat="server" 
    DynamicServicePath="" Enabled="True" TargetControlID="lnbCeldaName" 
    OffsetY="15" PopupControlID="pnlCeldasPopUp" HoverDelay="100">
</asp:HoverMenuExtender>

<asp:HoverMenuExtender ID="lnbAreaName_HoverMenuExtender" runat="server" 
    DynamicServicePath="" Enabled="True" TargetControlID="lnbAreaName" 
    OffsetY="15" PopupControlID="pnlAreasPopUp" HoverDelay="100">
</asp:HoverMenuExtender>

<asp:HoverMenuExtender ID="LinkButton1_HoverMenuExtender" runat="server" 
    DynamicServicePath="" Enabled="True" TargetControlID="lnbDeptoName" 
    OffsetY="15" PopupControlID="pnlPopUp" HoverDelay="100" PopDelay="500">
    
</asp:HoverMenuExtender>

<asp:Panel ID="pnlPopUp" runat="server" CssClass="pnlPopup">
<table>
<asp:Repeater ID="repDepts" runat="server" DataSourceID="dsDepts">
<ItemTemplate>
<tr><td>
<asp:LinkButton ID="lnbChild" runat="server" Text='<%# mid(Eval("deptoName"),1,1) & mid(Eval("deptoName"),2).tostring.tolower %>' OnClick="deptSelected" CommandArgument='<%# Bind("deptoID") %>' ></asp:LinkButton>
<asp:HiddenField ID="hflMnemDepto" runat="server" Value='<%# Bind("deptoMnemonic") %>' />
</td></tr>
</ItemTemplate>
</asp:Repeater>

</table>

<asp:SqlDataSource ID="dsDepts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
        SelectCommand="SELECT * FROM [tblDeptos] ORDER BY [deptoName]">
</asp:SqlDataSource>

</asp:Panel>
<asp:DropShadowExtender ID="pnlPopUp_DropShadowExtender" runat="server" 
    Enabled="True" TargetControlID="pnlPopUp">
</asp:DropShadowExtender>
<asp:Panel ID="pnlAreasPopUp" runat="server" CssClass="pnlPopup">
<table>
<asp:Repeater ID="Repeater1" runat="server" DataSourceID="dsAreas">
<ItemTemplate>
<tr><td>
<asp:LinkButton ID="lnbChild" runat="server" Text='<%# Bind("areaName") %>' OnClick="areaSelected" CommandArgument='<%# Bind("areaID") %>' ></asp:LinkButton>
<asp:HiddenField ID="hflMnemArea" runat="server" Value='<%# Bind("areaMnemonic") %>' />
</td></tr>
</ItemTemplate>
</asp:Repeater>

</table>
<asp:SqlDataSource ID="dsAreas" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    
        SelectCommand="SELECT areaID, areaName, areaMnemonic FROM vAreas WHERE (areaDeptoID = @areaDeptoID) UNION SELECT 0 AS Expr1, 'Todas las Areas' AS Expr5, '' AS Expr2">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflDeptID" Name="areaDeptoID" PropertyName="Value"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Panel>
<asp:DropShadowExtender ID="pnlAreasPopUp_DropShadowExtender" runat="server" 
    Enabled="True" TargetControlID="pnlAreasPopUp">
</asp:DropShadowExtender>
<asp:Panel ID="pnlCeldasPopUp" runat="server" CssClass="pnlPopup">
<table>
<asp:Repeater ID="Repeater2" runat="server" DataSourceID="dsCeldas">
<ItemTemplate>
<tr><td>
<asp:LinkButton ID="lnbChild" runat="server" Text='<%# Bind("celdaName") %>' OnClick="celdaSelected" CommandArgument='<%# Bind("celdaID") %>' ></asp:LinkButton>
<asp:HiddenField ID="hflMnemCelda" runat="server" Value='<%# Bind("celdaMnemonic") %>' />
</td></tr>
</ItemTemplate>
</asp:Repeater>

</table>
<asp:SqlDataSource ID="dsCeldas" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    
        SelectCommand="SELECT celdaId, celdaName, celdaMnemonic FROM cdd.tblCeldas WHERE (celdaAreaID = @celdaAreaID) UNION SELECT 0 AS Expr1, 'Todas las Celdas' AS Expr5, '' AS Expr2">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflAreaID" Name="celdaAreaID" PropertyName="Value"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Panel>
<asp:DropShadowExtender ID="pnlCeldasPopUp_DropShadowExtender" runat="server" 
    Enabled="True" TargetControlID="pnlCeldasPopUp">
</asp:DropShadowExtender>
<asp:HiddenField ID="hflDeptId" runat="server" Value="0" />
<asp:HiddenField ID="hflAreaID" runat="server" Value="0" />
<asp:HiddenField ID="hflCeldaID" runat="server" Value="0" />
<asp:HiddenField ID="hflMnemDepto" runat="server" />
<asp:HiddenField ID="hflMnemArea" runat="server" />
<asp:HiddenField ID="hflMnemCelda" runat="server" />
