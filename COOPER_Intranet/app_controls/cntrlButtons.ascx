<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlButtons.ascx.vb" Inherits="app_controls_cntrlButtons" %>

<asp:panel id="pnlButtons" runat="server" 
    style="border:1px solid gray; text-align: center; vertical-align: middle; padding-top: 8px; padding-left:10px; padding-right:10px; padding-bottom: 8px"  
    Width="180px">
    
<asp:ImageButton ID="imbOK" runat="server" 
        ImageUrl="~/images/Buttons/applyBig.png" />
        
<asp:ImageButton ID="imbDelete" runat="server" 
        ImageUrl="~/images/Buttons/trash.png" Height="24px" />
<asp:ImageButton ID="imbCancel" runat="server" 
        ImageUrl="~/images/Buttons/cancel.png" Height="24px" />
</asp:panel>
