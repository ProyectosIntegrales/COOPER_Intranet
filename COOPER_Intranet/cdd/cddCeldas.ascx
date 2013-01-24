<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddCeldas.ascx.vb" Inherits="cddCeldas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">
    a
    {
        color: #990000;
        text-decoration: none;
    }
    
    .lblWht
    {
        color: White;
    }
    .lblWht:Hover
    {
        color: Gray;
    }
    .padTop
    {
        margin-top: 10px;
    }
</style>
<asp:Panel ID="pnlItem" runat="server">
    <table cellpadding="0" cellspacing="0">
        <asp:Repeater ID="repItem" runat="server" DataSourceID="dsCeldas">
            <ItemTemplate>
                <tr>
                    <td id="tdCelda" runat="server" class="M" valign="top">
                        <asp:Image ID="imgSpacer1" runat="server" Width="20" ImageUrl="~/images/Icons/spacer.png" />
                    </td>
                    <td style="width: 40px" class="padCells">
                        <asp:Label ID="lblCeldaMnemonic" runat="server" Text='<%# Bind("celdaMnemonic") %>'
                            Font-Bold="True"></asp:Label>
                    </td>
                    <td class="padCells">
                        <asp:Label ID="lblCeldaName" runat="server" Text='<%# Bind("celdaName") %>'></asp:Label>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Panel>
<asp:Panel ID="pnlEdit" runat="server">
    <table cellpadding="0" cellspacing="0">
        <asp:Repeater ID="repEdit" runat="server" DataSourceID="dsCeldas">
            <ItemTemplate>
                <tr>
                    <td id="tdCelda" runat="server" class="M" valign="top">
                        <asp:Image ID="imgSpacer1" runat="server" Width="20" ImageUrl="~/images/Icons/spacer.png" />
                    </td>
                    <td class="padCells M">
                        <asp:Label ID="lblCeldaID" runat="server" Visible="false" Text='<%# Bind("celdaID") %>'></asp:Label>
                        <asp:TextBox ID="txtCeldaMnemonic" runat="server" CssClass="textbox" Width="40" Font-Size="9"
                            Text='<%# Bind("celdaMnemonic") %>'></asp:TextBox>
                    </td>
                    <td class="padCells M">
                        <asp:TextBox ID="txtCeldaName" runat="server" CssClass="textbox" Width="100" Font-Size="9"
                            Text='<%# Bind("celdaName") %>'></asp:TextBox>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <tr>
            <td id="tdNewCelda" runat="server" valign="top">
                <asp:Image ID="imgSpacer1" runat="server" Width="20" ImageUrl="~/images/Icons/spacer.png" />
            </td>
            <td class="padCells M">
                <asp:TextBox ID="txtCeldaMnemonic" runat="server" CssClass="textbox" Width="40" Font-Size="9"></asp:TextBox>
                <asp:TextBoxWatermarkExtender ID="txtCeldaMnemonic_TextBoxWatermarkExtender" runat="server"
                    Enabled="True" TargetControlID="txtCeldaMnemonic" WatermarkText="Celda" WatermarkCssClass="textboxdim">
                </asp:TextBoxWatermarkExtender>
            </td>
            <td class="padCells M">
                <asp:TextBox ID="txtCeldaName" runat="server" CssClass="textbox" Width="100" Font-Size="9"></asp:TextBox>
                <asp:TextBoxWatermarkExtender ID="txtCeldaName_TextBoxWatermarkExtender" runat="server"
                    Enabled="True" TargetControlID="txtCeldaName" WatermarkText="Nombre de Celda"
                    WatermarkCssClass="textboxdim">
                </asp:TextBoxWatermarkExtender>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:SqlDataSource ID="dsCeldas" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    SelectCommand="SELECT * FROM [vCeldas] WHERE ([celdaAreaID] = @areaID) ORDER BY [celdaMnemonic]">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflAreaID" Name="areaID" PropertyName="Value" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="hflAreaID" runat="server" />
<asp:HiddenField ID="hflMode" runat="server" />
