<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlEditor.ascx.vb"
    Inherits="app_controls_cntrlEditor" ClientIDMode="AutoID" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script type="text/javascript">
    function UploadComplete(sender, args) {
        // alert(Get_Cookie('imageData'));
        $get('bodyImage').src = Get_Cookie('imageData');
    }

    function Get_Cookie(check_name) {
        // first we'll split this cookie up into name/value pairs
        // note: document.cookie only returns name=value, not the other components
        var a_all_cookies = document.cookie.split(';');
        var a_temp_cookie = '';
        var cookie_name = '';
        var cookie_value = '';
        var b_cookie_found = false; // set boolean t/f default f

        for (i = 0; i < a_all_cookies.length; i++) {
            // now we'll split apart each name=value pair
            a_temp_cookie = a_all_cookies[i].split('=');


            // and trim left/right whitespace while we're at it
            cookie_name = a_temp_cookie[0].replace(/^\s+|\s+$/g, '');

            // if the extracted name matches passed check_name
            if (cookie_name == check_name) {
                b_cookie_found = true;
                // we need to handle case where cookie has no value but exists (no = sign, that is):
                if (a_temp_cookie.length > 1) {
                    cookie_value = unescape(a_temp_cookie[1].replace(/^\s+|\s+$/g, ''));
                }
                // note that in cases where cookie is initialized but no value, null is returned
                return cookie_value;
                break;
            }
            a_temp_cookie = null;
            cookie_name = '';
        }
        if (!b_cookie_found) {
            return null;
        }
    }

    function triggerFileUpload() {
        document.getElementById("ctl00_ContentPlaceHolder1_blog1_cntrlEditor1_AsyncFileUpload1_ctl02").click();
    }

    Sys.Extended.UI.HtmlEditorExtenderBehavior.prototype._editableDiv_submit = function () {
        //html encode
        var char = 3;
        var sel = null;
        try {
            this._editableDiv.focus();
        } catch (e) { }

        if (Sys.Browser.agent != Sys.Browser.Firefox) {
            if (document.selection) {
                sel = document.selection.createRange();
                sel.moveStart('character', char);
                sel.select();
            }
            else {
                sel = window.getSelection();
                sel.collapse(this._editableDiv.firstChild, char);
            }
        }

        //Encode html tags
        this._textbox._element.value = this._encodeHtml();
    };       
</script>
<asp:Panel ID="pnlEdit" runat="server" Style="display: nonex">
    <div style="text-align: right; position: relative; top: 303px; z-index: 10000;">
        <asp:ImageButton ID="imbTrash" runat="server" ImageUrl="~/images/buttons/trash.png"
            CssClass="padr25px" ToolTip="Delete" OnClientClick="return confirm('Estás seguro de eliminar esta nota?');" />
        <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/buttons/apply.png"
            ToolTip="Apply" />
        <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/images/buttons/cancel.png"
            CssClass="padr5px" ToolTip="Cancel" /></div>
    <div style="position: relative; top: -33px">
        <asp:TextBox ID="txtHeader" runat="server"></asp:TextBox>
        <br />
        <asp:TextBox ID="Editor1" runat="server" Height="260px" Width="200" ></asp:TextBox>
        <asp:HtmlEditorExtender ID="txtBody_HtmlEditorExtender" runat="server" Enabled="True"
            TargetControlID="Editor1">
            <Toolbar>
                <asp:Undo />
                <asp:Redo />
                <asp:Bold />
                <asp:Italic />
                <asp:Underline />
                <asp:StrikeThrough />
                <asp:CreateLink />
                <asp:UnLink />
                <asp:InsertOrderedList />
                <asp:InsertUnorderedList />
                <asp:Indent />
                <asp:Outdent />
            </Toolbar>
        </asp:HtmlEditorExtender>
        <asp:Panel ID="pnlImg" runat="server" Style="position: relative; overflow: Hidden;
            width: 180px; height: 40px; cursor: pointer; text-align: left; top: -10px; left: -100px;">
            <asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server" OnClientUploadComplete="UploadComplete"
                ThrobberID="imgProgress" Style="position: absolute; z-index: 50; opacity: 0%;
                filter: alpha(opacity=0);" UploaderStyle="Traditional" ClientIDMode="AutoID"
                Width="180px" Height="40px" />
            <asp:ImageButton ID="imbPicture" runat="server" ImageUrl="~/images/buttons/image.png"
                Style="position: absolute; top: 0px; left: 157px; z-index: 1;" />
            <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/Icons/uploading.gif"
                Style="position: absolute; top: 23px; left: 159px; z-index: 1;" />
            <div style="width: 40px; height: 40px; overflow: hidden; z-index: 2; right: 30px;
                position: absolute; cursor: pointer;">
                <asp:Image ID="bodyImage" runat="server" Height="40" ImageAlign="Top" ImageUrl="~/images/Icons/Picture.png" />
            </div>
        </asp:Panel>
    </div>
</asp:Panel>
<asp:Button ID="btnPopUp" runat="server" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" DropShadow="True"
    TargetControlID="btnPopUp" PopupControlID="pnlEdit" BackgroundCssClass="modalBackground"
    Y="158">
</asp:ModalPopupExtender>
<asp:HiddenField ID="hflItemID" runat="server" />
