<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddEngs.ascx.vb" Inherits="cdd_cddEngs" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<style type="text/css"">
  .G {background-image: url('../images/Icons/line5.png'); background-repeat: no-repeat; background-position: right top; margin-right:5px;}
</style>
<asp:Panel ID="pnlEngs" runat="server" style="padding-top:3px; padding-bottom:5px;">

<table cellpadding="0" cellspacing="0">
    <tr>
        <td class="G">
            <asp:Image ID="imgSpacer" runat="server" ImageUrl="~/images/Icons/spacer.png" Width="20" />
        </td>
        <td class="padCells" style="padding-right:4px;" nowrap="nowrap">
            <asp:TextBox ID="txtCalEngNo" runat="server" CssClass="textbox" Font-Size="9" Width="40"
                Visible="false" AutoPostBack="True"></asp:TextBox>
            <asp:TextBoxWatermarkExtender ID="txtCalEngNo_TextBoxWatermarkExtender" 
                runat="server" Enabled="True" TargetControlID="txtCalEngNo" 
                WatermarkCssClass="textboxdim" WatermarkText="Cal Eng"></asp:TextBoxWatermarkExtender>
            <asp:Label ID="lblCalEngNo" runat="server" Font-Bold="True"></asp:Label>
        </td>
        <td nowrap="nowrap">
            <asp:Label ID="lblCalEngName" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="L">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/Icons/spacer.png" Width="20" />
        </td>
        <td class="padCells" style="padding-right:4px;" nowrap="nowrap">
            <asp:TextBox ID="txtMfgEngNo" runat="server" CssClass="textbox" Font-Size="9" Width="40"
                Visible="false" AutoPostBack="True"></asp:TextBox>
            <asp:TextBoxWatermarkExtender ID="txtMfgEngNo_TextBoxWatermarkExtender" 
                runat="server" Enabled="True" TargetControlID="txtMfgEngNo" 
                WatermarkCssClass="textboxdim" WatermarkText="Mfg Eng"></asp:TextBoxWatermarkExtender>
            <asp:Label ID="lblMfgEngNo" runat="server" Font-Bold="True"></asp:Label>
        </td>
        <td  nowrap="nowrap">
            <asp:Label ID="lblMfgEngName" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<asp:HiddenField ID="hflAreaID" runat="server" />
<asp:HiddenField ID="hflMode" runat="server" />
</asp:Panel>