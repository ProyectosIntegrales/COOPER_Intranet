<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cAuditData.ascx.vb" Inherits="qa_cAuditData" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register src="qaAuditDetail.ascx" tagname="qaAuditDetail" tagprefix="uc1" %>

<%@ Register src="../app_controls/cntrlReports.ascx" tagname="cntrlReports" tagprefix="uc2" %>

<style type="text/css">
    a
    {
        color: #990000;
        text-decoration: none;
    }
    .style2
    {
        width: 100%;
    }
</style>

<asp:Panel ID="pnlFilter" runat="server" style="padding-bottom:5px">
            <table cellpadding="0" cellspacing="0" class="style2">
                <tr>
                    <td>
                        De:&nbsp;
                        <asp:TextBox ID="txtDate" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
                        <asp:CalendarExtender ID="txtDate_CalendarExtender" runat="server" 
                            Enabled="True" Format="dd/MM/yyyy" TargetControlID="txtDate">
                        </asp:CalendarExtender>
                        <asp:MaskedEditExtender ID="txtDate_MaskedEditExtender" runat="server" 
                            ClearMaskOnLostFocus="False" Mask="99/99/9999" MaskType="Date" 
                            TargetControlID="txtDate">
                        </asp:MaskedEditExtender>
                        &nbsp;a:
                        <asp:TextBox ID="txtDate0" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
                        <asp:CalendarExtender ID="txtDate0_CalendarExtender" runat="server" 
                            Enabled="True" Format="dd/MM/yyyy" TargetControlID="txtDate0">
                        </asp:CalendarExtender>
                        <asp:MaskedEditExtender ID="txtDate0_MaskedEditExtender" runat="server" 
                            ClearMaskOnLostFocus="False" Mask="99/99/9999" MaskType="Date" 
                            TargetControlID="txtDate0">
                        </asp:MaskedEditExtender>
                        &nbsp;<asp:ImageButton ID="imbFilter" runat="server" Height="16px" 
                            ImageUrl="~/images/Icons/16X16/filter_16x16.gif" />
                        &nbsp;
                        </td>
                    <td align="right">
                        &nbsp;</td>
                </tr>
            </table>
</asp:Panel>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
    DataKeyNames="dataId" DataSourceID="dsAudit" ForeColor="#333333" GridLines="None"
    CssClass="gridview" AllowPaging="True" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:TemplateField HeaderText="Folio" SortExpression="dataID">
            <ItemTemplate>
                <asp:Label ID="lblDefectoID" runat="server" Text='<%# Bind("dataID") %>' Font-Bold="True"></asp:Label>
            </ItemTemplate>
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Right" Width="35px" />
        </asp:TemplateField>

        
        <asp:TemplateField HeaderText="Fecha">

            <ItemTemplate>
                <asp:Label ID="lblDate" runat="server" 
                    Text='<%# Bind("auditDate", "{0:dd/MM/yyyy}") %>'></asp:Label>
            </ItemTemplate>

            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Area" SortExpression="areaName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
           <asp:Label ID="lblAreaName" runat="server" Text='<%# Bind("areaName") %>'></asp:Label>
        </ItemTemplate>
          <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="100px"></ItemStyle>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Auditor" SortExpression="userFullName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
        <asp:HyperLink ID="hlnUsername" runat="server" Text='<%# Bind("userFullName") %>' NavigateUrl='<%# "mailto:" & Eval("userEmailAddress") %>'></asp:HyperLink>
          
        </ItemTemplate>


          <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="100px"></ItemStyle>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="No. de Parte" SortExpression="partNo" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
           <asp:Label ID="lblPartNo" runat="server" Text='<%# Bind("partNo") %>'></asp:Label>
        </ItemTemplate>
          <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="100px"></ItemStyle>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Orden No." SortExpression="workOrder" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
           <asp:Label ID="lblWorkOrder" runat="server" Text='<%# Bind("workOrder") %>'></asp:Label>
        </ItemTemplate>
          <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="100px"></ItemStyle>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Lote Planeado"  ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
           <asp:Label ID="lblLotPlan" runat="server" Text='<%# Bind("lotPlan") %>'></asp:Label>
        </ItemTemplate>
          <HeaderStyle HorizontalAlign="Left" Width="50"></HeaderStyle>
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="50px"></ItemStyle>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Lote Entregado"  ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
           <asp:Label ID="lblLotQty" runat="server" Text='<%# Bind("lotQty") %>'></asp:Label>
        </ItemTemplate>
          <HeaderStyle HorizontalAlign="Left" Width="50"></HeaderStyle>
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="50px"></ItemStyle>
        </asp:TemplateField>

                <asp:TemplateField HeaderText="Cant. Insp."  ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
           <asp:Label ID="lblSamSize" runat="server" Text='<%# Bind("samSize") %>'></asp:Label>
        </ItemTemplate>
          <HeaderStyle HorizontalAlign="Left" Width="50"></HeaderStyle>
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="50px"></ItemStyle>
        </asp:TemplateField>

                <asp:TemplateField HeaderText="Cant. Defs"  ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
        <ItemTemplate>
           <asp:Label ID="lblDefQty" runat="server" Text='<%# Bind("defQty") %>'></asp:Label>
        </ItemTemplate>
          <HeaderStyle HorizontalAlign="Left" Width="50"></HeaderStyle>
            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="50px"></ItemStyle>
        </asp:TemplateField>

        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID="imbInquire" runat="server" ImageUrl="~/images/Icons/16X16/search.png"
                     CommandArgument='<%# Bind("dataID") %>' OnClick="View" Visible='<%# not canEdit() %>'/>
                <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png"
                     CommandArgument='<%# Bind("dataID") %>' OnClick="Edit" Visible='<%# canEdit() %>'/>
                <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png"
                    CommandArgument='<%# Bind("dataID") %>'  OnClick="Delete" Visible='<%# canEdit() %>' />
            </ItemTemplate>
            <HeaderTemplate>
                <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png"
                    OnClick="enableAdd" Visible='<%# canEdit() %>' />
            </HeaderTemplate>
            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
            <ItemStyle HorizontalAlign="Right" Wrap="False" />
        </asp:TemplateField>
    </Columns>
    <EditRowStyle BackColor="#CCCCCC" />
    <EmptyDataTemplate>
        <asp:Label ID="lblEmpty" runat="server"></asp:Label>
        &nbsp;<asp:ImageButton ID="imbAdd0" runat="server" ImageUrl="~/images/Icons/16X16/add.png"
            OnClick="enableAdd" Visible='<%# canEdit() %>' />
    </EmptyDataTemplate>
    <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" HorizontalAlign="Right"
        Width="40" />
    <HeaderStyle BackColor="#666666" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" CssClass="gridviewPager" />
    <RowStyle BackColor="White" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <SortedAscendingCellStyle BackColor="#FDF5AC" />
    <SortedAscendingHeaderStyle BackColor="#4D0000" />
    <SortedDescendingCellStyle BackColor="#FCF6C0" />
    <SortedDescendingHeaderStyle BackColor="#820000" />
</asp:GridView>
<uc2:cntrlReports ID="cntrlReports1" runat="server" ReportType="QAEXP" />
<asp:SqlDataSource ID="dsAudit" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    
    
    
    
    SelectCommand="SELECT qaa.tblAuditData.dataID, qaa.tblAuditData.auditDate, qaa.tblAuditData.areaID, qaa.tblAuditData.workOrder, qaa.tblAuditData.partNo, qaa.tblAuditData.lotPlan, qaa.tblAuditData.lotQty, qaa.tblAuditData.samSize, qaa.tblAuditData.rewQty, qaa.tblAuditData.accQty, qaa.tblAreas.areaName, qaa.tblAreas.areaMnemonic, vUsers.userFirstName + ' ' + vUsers.userLastName AS userFullName, vUsers.userEMailAddress, SUM(qaa.tblAuditDefectos.defectoQty) AS defQty FROM qaa.tblAuditData INNER JOIN qaa.tblAreas ON qaa.tblAuditData.areaID = qaa.tblAreas.areaID INNER JOIN vUsers ON qaa.tblAuditData.userID = vUsers.userId LEFT OUTER JOIN qaa.tblAuditDefectos ON qaa.tblAuditData.dataID = qaa.tblAuditDefectos.dataID GROUP BY qaa.tblAuditData.dataID, qaa.tblAuditData.auditDate, qaa.tblAuditData.areaID, qaa.tblAuditData.workOrder, qaa.tblAuditData.partNo, qaa.tblAuditData.lotPlan, qaa.tblAuditData.lotQty, qaa.tblAuditData.samSize, qaa.tblAuditData.rewQty, qaa.tblAuditData.accQty, qaa.tblAreas.areaName, qaa.tblAreas.areaMnemonic, vUsers.userFirstName + ' ' + vUsers.userLastName, vUsers.userEMailAddress HAVING (qaa.tblAuditData.auditDate &gt;= @dateInit AND qaa.tblAuditData.auditDate &lt;= @dateFinal) ORDER BY qaa.tblAuditData.dataID DESC">
    <SelectParameters>
        <asp:SessionParameter Name="dateInit" SessionField="filterDateInit" />
        <asp:SessionParameter Name="dateFinal" SessionField="filterDateFinal" />
    </SelectParameters>
</asp:SqlDataSource>

<uc1:qaAuditDetail ID="qaAuditDetail1" runat="server" Visible="False" />

