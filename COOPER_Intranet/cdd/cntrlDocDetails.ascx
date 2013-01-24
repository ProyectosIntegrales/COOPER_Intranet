<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlDocDetails.ascx.vb" Inherits="cntrlDocDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="cddSelectLoad.ascx" TagName="cddSelectLoad" TagPrefix="uc1" %>

<style type="text/css">
    .style1
    {
        position: relative;
        top: -20px;
        left: 20px;
        z-index: 1000;
        opacity: 0;
        filter: alpha(opacity=0);
    }
    

</style>
<script type="text/javascript">

    function processFile(sender, args) {
        val = args.get_fileName();
        document.getElementById('<%=txtFilename.ClientID%>').value = val.substring(val.lastIndexOf('\\') + 1);
        var ext = val.substring(val.lastIndexOf('.') + 1).toLowerCase()
        var icon = '../images/icons/files/' + ext.substring(0, 3) + '.png'
        document.getElementById('<%=imgDocUploadIcon.ClientID%>').src = icon;
        document.getElementById('<%=imgDocIcon.ClientID%>').src = icon;
        document.getElementById('<%=lblDocNameData.ClientID%>').href = getCookie('FileName');
        if (document.getElementById('<%=lblDocNameData.ClientID%>').innerHTML == "" | document.getElementById('<%=lblDocNameData.ClientID%>').innerHTML == "Seleccione 'Tipo de Documento'.") {
            try {
                document.getElementById('<%=lblDocNameData.ClientID%>').innerHTML = getCookie('DocName');
            }
            catch (err) { }
            try {
                document.getElementById('<%=txtDocName.ClientID%>').value = getCookie('DocName');
            }
            catch (err) { }
             }
        aspnetForm.target = "";

        if (document.getElementById('<%=imbConvertPDF.ClientID%>')) {
            if (ext.substring(0, 3) == 'doc' || ext.substring(0, 3) == 'xls' || ext.substring(0, 3) == 'ppt') {
                document.getElementById('<%=imbConvertPDF.ClientID%>').style.visibility = 'visible';
            } else { document.getElementById('<%=imbConvertPDF.ClientID%>').style.visibility = 'hidden'; }
        }
    }

    function getCookie(c_name) {
        var i, x, y, ARRcookies = document.cookie.split(";");
        for (i = 0; i < ARRcookies.length; i++) {
            x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
            y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
            x = x.replace(/^\s+|\s+$/g, "");
            if (x == c_name) {
                return unescape(y).replace('FileName=~/cdd/','');
            }
        }
    }
</script>

            <table width="100%" 
    style="border-width: 1px; border-color: #FF0000; border-right-style: solid; border-bottom-style: solid; border-left-style: solid;" 
    cellspacing="0" cellpadding="0">
                <tr>
                    <td style="padding: 5px; background-color: #FF0000; color: #FFFFFF; font-weight: bold;" colspan="7" 
                        valign="middle">
                        <asp:Label ID="lblHeader" runat="server"></asp:Label>
                    </td>
                </tr>
                   <tr>
                    <td style="padding: 10px 5px 5px 5px;" valign="middle" align="right">
                        <asp:Label ID="lblDocName" runat="server"></asp:Label>
                    </td>
                    <td valign="middle" style="padding: 10px 5px 5px 5px;" nowrap="nowrap">
                        <asp:Image ID="imgDocIcon" runat="server" ClientIDMode="Static" ImageAlign="Middle"
                            ImageUrl="~/images/Icons/16X16/documents.png" />
                        <asp:HyperLink ID="lblDocNameData" runat="server" Target="_blank" 
                            Font-Bold="True"></asp:HyperLink>
                        &nbsp;<asp:TextBox ID="txtDocName" runat="server" Width="180px" Visible="False"></asp:TextBox>
                        &nbsp;<asp:ImageButton ID="imbEditOK" runat="server" 
                            ImageUrl="~/images/Icons/16X16/apply.png" Visible="False" />
                        <asp:ImageButton ID="imbEditCancel" runat="server" 
                            ImageUrl="~/images/Icons/16X16/delete.png" Visible="False" />
                        &nbsp;
                        <asp:Image ID="imgOptions" runat="server" ImageAlign="Right" 
                            ImageUrl="~/images/Icons/16X16/applications.png" />
                        <asp:HoverMenuExtender ID="imgOptions_HoverMenuExtender" runat="server" 
                            DynamicServicePath="" Enabled="True" TargetControlID="imgOptions" 
                            PopupControlID="pnlButtons" OffsetX="20" OffsetY="-5" >
                        </asp:HoverMenuExtender>
                        <asp:Panel ID="pnlButtons" runat="server" CssClass="pnlPopup" style="width:60px; overflow:auto">
           <table cellpadding="0" cellspacing="0">
           <tr>
             <td>
            <asp:ImageButton ID="imbEdit" runat="server" ImageAlign="Middle" 
                                ImageUrl="~/images/Buttons/btnEdit.png" Width="60px" 
                   ToolTip="Editar nombre" />
           </td>
           </tr><tr>
           <td>
           <asp:ImageButton ID="imbConvertPDF" runat="server" 
                            ImageUrl="~/images/Buttons/ctopdf.png" Width="60px" ImageAlign="Middle" ToolTip="Convertir documento a PDF" />
           </td>
           </tr>
                      <tr>
           <td>
           <asp:ImageButton ID="imbUpload" runat="server" 
                            ImageUrl="~/images/Buttons/upload.jpg" Width="60px" 
                   ImageAlign="Middle" ToolTip="Subir un nuevo documento" />
           </td>
           </tr>
                      <tr>
           <td>
            <asp:ImageButton ID="imbOriginal" runat="server" ImageAlign="Middle" 
                                ImageUrl="~/images/Buttons/original.png" Width="60px" 
                   ToolTip="Abrir el documento original" />
               <asp:Timer ID="Timer1" runat="server" Enabled="False" Interval="5000">
               </asp:Timer>
           </td>
           </tr>
                               <tr>
           <td>
            <asp:ImageButton ID="imbObsoleto" runat="server" ImageAlign="Middle" 
                                ImageUrl="~/images/Buttons/obsoleto.png" Width="60px" 
                   ToolTip="Iniciar proceso de Obsolescencia" />
           </td>
           </tr>
             
           </table>
                         
                    
                           
                   
                        </asp:Panel>
                       
                        <asp:DropShadowExtender ID="pnlButtons_DropShadowExtender" runat="server" 
                            Enabled="True" TargetControlID="pnlButtons">
                        </asp:DropShadowExtender>
                       
                    </td>
                    <td valign="top" class="style2" style="padding: 10px 5px 5px 5px;" align="right" 
                           colspan="2">
                        <asp:Label ID="lblRev" runat="server"></asp:Label>&nbsp;
                    </td>
                    <td style="padding: 10px 5px 5px 5px;" valign="top" >
                        <asp:TextBox ID="txtRev" runat="server" CssClass="textbox" Width="50px" AutoPostBack="True"></asp:TextBox>
                    &nbsp;<asp:Image ID="imgChgRev" runat="server" ImageAlign="Middle" 
                            ImageUrl="~/images/Icons/16X16/info2.png" 
                            ToolTip="En proceso de cambio de revisión. Este campo no puede ser modificado." 
                            Visible="False" />
                    <asp:HiddenField ID="hflRevChange" runat="server" Value="0" />
                    </td>
                    <td style="padding: 10px 5px 5px 5px;" valign="top" align="right" >
                        <asp:label ID="lblAuthor" runat="server" Text="Autor:"></asp:label></td>
                    <td style="padding: 10px 5px 5px 5px;" valign="top" >
                        <asp:DropDownList ID="ddlAuthor" runat="server" DataSourceID="dsUsers" 
                            DataTextField="userFullname" DataValueField="userName" 
                             BackColor="#E8E8E8">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="dsUsers" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                            
                            
                            
                            
                            SelectCommand="SELECT { fn UCASE(userName) } AS username, userFullname, userEmployeeNo FROM cdd.vUsers WHERE (userID &gt; 0) GROUP BY { fn UCASE(userName) }, userFullname, userEmployeeNo, privLevel HAVING (privLevel &gt;= 1) ORDER BY userFullname">
                        </asp:SqlDataSource>
                       </td>
                </tr>
                <tr>
                    <td align="right" 
                        style="padding: 5px; width: 150px; " 
                        valign="top" >
                        Tipo de Documento:</td>
                    <td style="padding: 5px; width: 250px;" valign="top" nowrap="nowrap">
                        <asp:LinkButton ID="lnbDocType" runat="server" Text="Tipo de Documento"></asp:LinkButton>
                        <asp:HoverMenuExtender ID="lnbDocType_HoverMenuExtender" runat="server" 
                            DynamicServicePath="" Enabled="True" OffsetY="15" PopupControlID="pnlDocTypes" 
                            TargetControlID="lnbDocType"></asp:HoverMenuExtender>
                        <asp:Panel ID="pnlDocTypes" runat="server" CssClass="pnlPopup">
                            <table>
                                <asp:Repeater ID="repDocTypes" runat="server" DataSourceID="dsTypes">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnbType" runat="server" 
                                                    CommandArgument='<%# Bind("typeID") %>' OnClick="selectType" 
                                                    Text='<%# Bind("typenameEsp") %>'></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                            <asp:SqlDataSource ID="dsTypes" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                                SelectCommand="SELECT cdd.tblDocTypes.* FROM cdd.tblDocTypes">
                            </asp:SqlDataSource>
                        </asp:Panel>
                        <asp:HiddenField ID="hflType" runat="server" Value="0" />
                        <asp:DropShadowExtender ID="pnlDocTypes_DropShadowExtender" runat="server" 
                            Enabled="True" TargetControlID="pnlDocTypes"></asp:DropShadowExtender>
                    </td>
                    <td align="right" valign="top" class="style3" colspan="2" style="padding: 5px">
                        Area/Celda:&nbsp;</td>
                    <td align="left" valign="top" nowrap="nowrap" style="padding: 5px" colspan="3">
                        <uc1:cddSelectLoad ID="cddSelectLoad1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right" style="padding: 5px; width: 150px;" valign="top">
                        <asp:Label ID="lblDocUpload" runat="server" style="padding-top:8px"></asp:Label>
                    </td>
                    <td nowrap="nowrap" valign="top" colspan="6" style="padding: 5px">
                        <asp:Panel ID="pnlUpload" runat="server" 
                            Style="width: 260px; height: 24px;">
                            <asp:Image ID="imgDocUploadIcon" runat="server" ImageAlign="Middle" 
                                ImageUrl="~/images/Icons/16X16/documents.png" 
                                Style="position: relative; left: 4px; top: -2px; z-index: 1" />
                            <asp:TextBox ID="txtFilename" runat="server" CssClass="textbox" Style="padding-left: 23px;
                                position: relative; left: -18px; top: 0px;" Width="180px"></asp:TextBox>
                            <asp:Image ID="ImageButton1" runat="server" ClientIDMode="Static" 
                                ImageAlign="Middle" ImageUrl="~/images/Icons/16X16/folder.png" 
                                Style="position: relative; left: -15px;" />
                            <br />
                            <div class="style1">
                                <asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server"  
                                    OnClientUploadComplete="processFile" Width="220px" />
                            </div>
                        </asp:Panel>
   
                    </td>
                </tr><tr>
                    <td align="right" style="padding: 5px; width: 150px; " valign="top">
                        <asp:Label ID="lblDesc" runat="server"></asp:Label>
                    </td>
                    <td colspan="6" nowrap="nowrap" style="padding: 5px 15px 5px 5px;" 
                        valign="top">
                        <asp:TextBox ID="txtDescEsp" runat="server" CssClass="textbox"  
                            TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="padding: 5px; width: 150px;" valign="top">
                        <asp:Label ID="lblCopies" runat="server"></asp:Label>
                    </td>
                    <td colspan="2"  valign="top" style="padding: 5px">
                        <asp:TextBox ID="txtCopies" runat="server" CssClass="textbox" 
                            TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                    <td  valign="top" align="right" style="padding: 5px" rowspan="2">
                        <asp:Label ID="lblPlano" runat="server"></asp:Label>
                    </td>
                    <td  style="padding: 5px 15px 5px 5px;" valign="top" rowspan="2" colspan="3">
                        <asp:TextBox ID="txtPlano" runat="server" CssClass="textbox" 
                            TextMode="MultiLine" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="padding: 5px; width: 150px;" valign="top">
                        <asp:Label ID="lblResp" runat="server"></asp:Label>
                    </td>
                    <td colspan="2"  valign="top" style="padding: 5px">
                        <asp:TextBox ID="txtResp" runat="server" CssClass="textbox" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width: 150px; padding:5px;" valign="top">
                        <asp:Label ID="lblReject" runat="server"></asp:Label>
                    </td>
                    <td colspan="6" valign="top" 
                        style="padding: 5px 15px 5px 5px">
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="textbox" Height="34px" TextMode="MultiLine"
                            Width="100%" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="padding: 10px 5px 10px 5px; color: #CC0000;" 
                        align="center">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblError" runat="server"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td align="center" colspan="7" style="padding-bottom: 10px">
                        <asp:Button ID="btnOK" runat="server" CssClass="button" Text="Aceptar" OnClientClick="window.location.href = window.location.href"  />
                        &nbsp;&nbsp;<asp:Button ID="btnReject" runat="server" CssClass="button" Text="Rechazar" />
                        &nbsp;&nbsp;<asp:Button ID="btnClose" runat="server" CssClass="button"
                            Text="Cerrar" />
                    </td>
                </tr>
            </table>
            </div>
                                      
  

<asp:HiddenField ID="hflDocId" runat="server" />
<asp:HiddenField ID="hflAction" runat="server" />
<asp:HiddenField ID="hflAuth" runat="server" />
<asp:HiddenField ID="hflAuthLevel" runat="server" />

<asp:Button ID="btnMClose" runat="server" Style="visibility: hidden" />

<asp:Button ID="btnMFinish" runat="server" Style="visibility: hidden" />