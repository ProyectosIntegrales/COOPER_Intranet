<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddPDFCLog.ascx.vb" Inherits="cdd_cddPDFCLog" %>
<asp:SqlDataSource ID="dsPDFC" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    SelectCommand="SELECT time, message FROM cdd.tblPDFConverterLog ORDER BY time DESC">
</asp:SqlDataSource>
<table cellpadding="0" cellspacing="0">
<tr>
<td valign="top">
<table cellpadding="0" cellspacing="0" style="margin-right: 10px">
<tr>
<td style="width: 150px; height: 25px; padding: 8px; margin-right: 10px; background-color: #CCCCCC; border: 1px solid #C0C0C0" valign="middle">
<asp:LinkButton ID="LinkButton2" runat="server">Refrescar Lista</asp:LinkButton>
</td>
</tr>
<tr>
<td style="width: 150px; height: 25px; padding: 8px; margin-right: 10px; background-color: #CCCCCC; border: 1px solid #C0C0C0" valign="middle">
<asp:LinkButton ID="LinkButton1" runat="server">Borrar Registros</asp:LinkButton>
</td>
</tr>
<tr>
<td style="width: 150px; height: 25px; padding: 8px; margin-right: 10px; background-color: #CCCCCC; border: 1px solid #C0C0C0" valign="middle">
<asp:LinkButton ID="LinkButton3" runat="server">Borrar documentos pendientes</asp:LinkButton>
</td>
</tr>
</table>
<div >
    </div>
</td>
<td>

        <h3><asp:Label ID="Label4" runat="server" 
                Text="Actividad Reciente" Font-Bold="True"></asp:Label></h3>

<asp:ListView ID="ListView1" runat="server" DataSourceID="dsPDFC">
<ItemTemplate>
    <asp:Label ID="Label1" runat="server" Text='<%# Eval("time") %>' Font-Size="8"></asp:Label>&nbsp;<asp:Label ID="Label2" runat="server" Text='<%# Eval("message") %>' Font-Bold="True"></asp:Label><br />
</ItemTemplate>
</asp:ListView>
</td>
<td style="padding-left: 20px" valign="top">
 <h3><asp:Label ID="Label3" runat="server" Text="Documentos pendientes" Font-Bold="True"></asp:Label></h3>
    <asp:PlaceHolder ID="PlaceHolder1" runat="server">
       
    </asp:PlaceHolder>
</td>
</tr>
</table>
<asp:Timer ID="Timer1" runat="server" Interval="10000">
</asp:Timer>

