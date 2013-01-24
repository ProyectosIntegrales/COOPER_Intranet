<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlError.ascx.vb" Inherits="App_controls_cntrlError" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>

<asp:Panel ID="pnlError" runat="server" style="text-align:center; display:none">
<div style="border: 2px solid #FFFFFF; LINE-HEIGHT: 20pt; BACKGROUND-COLOR: #CC0000; COLOR: #FFFFFF; FONT-WEIGHT: bold; text-align: center;" >
       
    <table class="style1">
        <tr>
            <td style="padding: 20px">
       
    <asp:Label ID="lblError" runat="server" Font-Size="8pt"></asp:Label>
 
            </td>
            <td align="right" valign="top" width="20">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageAlign="Top" 
                    ImageUrl="~/images/Icons/close.png" />
            </td>
        </tr>
    </table>
</div>
</asp:Panel>
<asp:Button ID="btnPopUp" runat="server" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" DropShadow="True"
    TargetControlID="btnPopUp" PopupControlID="pnlError" BackgroundCssClass="modalBackground"
    Y="158"></asp:ModalPopupExtender>