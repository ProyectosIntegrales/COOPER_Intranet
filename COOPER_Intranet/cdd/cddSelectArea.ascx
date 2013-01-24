<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddSelectArea.ascx.vb"
    Inherits="cdd_cddSelectArea" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<link href="../Styles.css" rel="stylesheet" type="text/css" />
<style type="text/css">

    .areasPanel
    {
        background-color: GrayText;
        color: White;
        padding-bottom: 5px;
        padding-top: 5px;
        padding-left: 10px;
        padding-right: 10px;
        font-size: 12px;
    }
    .areasPanel a
    {
        color: White;
        text-decoration: none;
    }
    .areasPanel:hover
    {
        background-color: Gray;
    }
    .celdasPanel {        background-color:#cccccc ;
        color: black;
        padding-bottom: 5px;
        padding-top: 5px;
        padding-left: 15px;
        padding-right: 5px;
        font-size: 12px;
        
        width: 130px;
    }
    
    .celdasPanel a
    {
        color: Black;
        text-decoration: none;
    }
    
    .celdasPanel:hover
    { background-color: #999999 }
    
    .celdasPanelActive 
    {
         background-color:#cccccc ;
        color: red;
        padding-bottom: 5px;
        padding-top: 5px;
        padding-left: 15px;
        padding-right: 5px;
        font-size: 12px;
        
        width: 130px;
        
    }
    
    
</style>
<asp:SqlDataSource ID="dsAreas" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    SelectCommand="SELECT areaID, areaMnemonic, areaName, areaDeptoID, mfgEngEmpNo, calEngEmpNo, mfgEngUsername, mfgEngName, calEngUsername, calEngName, deptoMnemonic FROM vAreas WHERE (deptoMnemonic = @deptoMnemonic) UNION SELECT 0 AS Expr1, '' AS Expr2, 'Todas las Areas' AS Expr3, 0 AS Expr4, 0 AS Expr5, 0 AS Expr6, '' AS Expr7, '' AS Expr8, '' AS Expr9, '' AS Expr10, '' AS Expr11">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflDept" Name="deptoMnemonic" PropertyName="Value"
            Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="hflDept" runat="server" />

<asp:Accordion ID="Accordion1" runat="server" DataSourceID="dsAreas" HeaderCssClass="areasPanel"
    Width="150px" 
    BackColor="#FF3300" HeaderSelectedCssClass="activeMenuLeft" >
    
<HeaderTemplate>

            <asp:linkButton ID="lnbArea" runat="server" Text='<%# Bind("areaName") %>' CommandArgument='<%# Bind("areaID") %>' OnClick="selectArea"></asp:linkButton>
        
 </HeaderTemplate>
 <ContentTemplate>
 <asp:HiddenField ID="hflAreaID" runat="server" Value='<%# Bind("areaID") %>' />
        
 <asp:SqlDataSource ID="dsCeldas" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    SelectCommand="SELECT * FROM cdd.[tblCeldas] WHERE ([celdaAreaID] = @celdaAreaID)">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflAreaID" Name="celdaAreaID" 
            PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
<asp:Repeater ID="repCeldas" runat="server" DataSourceID="dsCeldas">
    <ItemTemplate>
    <asp:Panel ID="pnlCeldas" runat="server" CssClass="celdasPanel" Width="130">
        <asp:LinkButton ID="lnbCelda" runat="server" Text='<%# Bind("celdaName") %>' CommandArgument='<%# Bind("celdaID") %>' OnClick="selectCelda"></asp:LinkButton>

    </asp:Panel>
    
   

            </ItemTemplate>
        </asp:Repeater>

</ContentTemplate>
</asp:Accordion>


<asp:HiddenField ID="hflSelAreaID" runat="server" Value="0" />
<asp:HiddenField ID="hflSelCeldaID" runat="server" Value="0" />



