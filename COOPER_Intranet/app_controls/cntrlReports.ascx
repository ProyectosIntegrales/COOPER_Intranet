<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cntrlReports.ascx.vb" Inherits="cntrlReports" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<style type="text/css">
    .modalBackground {
    background-color:#414141;
    filter:alpha(opacity=50);
    opacity:0.5;
    }
    .upCalendar { z-index:10002; }
   #Container 
{
  height:99%;
  min-height:99%;
}

</style>

 <script language="javascript">
  var prm = Sys.WebForms.PageRequestManager.getInstance();
 
  prm.add_initializeRequest(InitializeRequest);
  prm.add_endRequest(EndRequest);
 
  function InitializeRequest(sender, args) 
  {
    $get('Container').style.cursor = 'wait'; 
    
  }
 
  function EndRequest(sender, args) 
  {
    $get('Container').style.cursor = 'auto';
    
  }
</script>     <asp:Label runat="server" ID="lblHeader" Visible="False" ></asp:Label>
<div style="border: 1px solid #CCCCCC; width: 148px; background-color: #E2E2E2;">
<table cellpadding="0" cellspacing="0" width="148">

<tr>
<td style="padding: 3px 3px 3px 3px;">


            <asp:DataList ID="DataList1" runat="server" Font-Bold="False" 
                Font-Italic="False" Font-Overline="False" Font-Strikeout="False" 
                Font-Underline="False" ForeColor="#666666" ShowFooter="False" 
                ShowHeader="False" DataSourceID="dsReports" Font-Size="8">
                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" 
                    Font-Strikeout="False" Font-Underline="False" ForeColor="#003366" />
                <ItemTemplate>
                <table cellpadding="0" cellspacing="0">
                <tr>
                <td>
                    <asp:Image ID="imgReport" runat="server" ImageUrl="~/images/Icons/16X16/print.png" ImageAlign="Middle" />
                </td>
                <td style="padding-left: 3px">
                   <asp:LinkButton ID="reportTitleLinkButton1" runat="server" 
                        Text='<%# Eval("reportTitle") %>' OnClick="goReport" CommandArgument='<%# Eval("reportID") %>'   />
                </td>
                </tr>
                </table>
                            
                </ItemTemplate>
            </asp:DataList>
            </td>
</tr>
 </table>
            </div>
<asp:SqlDataSource ID="dsReports" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    
    
    SelectCommand="SELECT * FROM [tblReports] WHERE ([reportType] = @reportType) ORDER BY [reportTitle]">
    <SelectParameters>
        <asp:ControlParameter ControlID="hfReportType" Name="reportType" 
            PropertyName="Value" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

   <asp:Button id="btnShowPopup" runat="server" Text="PopUp" style="display:none;"  />



 
<cc1:ModalPopupExtender ID="mdlPopup" runat="server" TargetControlID="btnShowPopup" PopupControlID="pnlParameters" CancelControlID="imbClose" BackgroundCssClass="modalBackground" DropShadow="True" >
</cc1:ModalPopupExtender>

 
<asp:Panel ID="pnlParameters" runat="server" Width="420px"
     style="display:nonex;" cssclass="portletbox" BackColor="White" 
    BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px">
    
    <div style="text-align:right; position: relative; top: -6px; right: -8px;" >
    
    <asp:ImageButton ID="imbClose" runat="server" 
            ImageUrl="~/images/misc/del.png" CausesValidation="False"  />
    </div>

   <div id="Container" style="padding: 0px 10px 0px 10px; position: relative; top: -10px;" >   
   
     <asp:UpdatePanel ID="upParameters" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
     
        <asp:FormView ID="FormView2" runat="server" DataKeyNames="reportID" 
            DataSourceID="dsReport">

            <ItemTemplate>
                <asp:Label ID="reportFileLabel" runat="server" Text='<%# Bind("reportFile") %>' 
                    Visible="False" />
                <h1><asp:Label ID="reportTitleLabel" runat="server" 
                    Text='<%# Bind("reportTitle") %>' Font-Size="12" /></h1>

              
            </ItemTemplate>
        </asp:FormView>
        
        <table style="width:100%" cellspacing="0"  >
        <asp:Repeater ID="repeaterParams" runat="server" DataSourceID="dsParams" >

            <ItemTemplate>
            <tr ><td valign="middle" align="right" nowrap="nowrap" >
                    <asp:Label ID="paramTitleLabel" runat="server" 
                        Text='<%# Bind("paramTitle") %>' Visible='<%# Eval("paramVisible") %>' Font-Size="10"  />
&nbsp;
                    </td>
                    <td valign="middle" >
                <asp:Label ID="paramNameLabel" runat="server" Text='<%# Bind("paramName") %>' 
                    Visible="false" />
                                <asp:Label ID="paramIsIDLabel" runat="server" Text='<%# Bind("paramIsID") %>' 
                    Visible="false" />
                <asp:Label ID="paramIsOptionalLabel" runat="server" Text='<%# Bind("paramIsOptional") %>' 
                    Visible="false" />
                <asp:Label ID="paramOptionalIDLabel" runat="server" Text='<%# Bind("paramOptionalID") %>' 
                    Visible="false" />
                <asp:Label ID="paramControlLabel" runat="server" Text='<%# Bind("paramControl") %>' 
                    Visible="False" />
                    <asp:TextBox runat="server" ID="txtParam" Width="150" Visible='<%# (Eval("paramControl").trim = "textbox") and Eval("paramVisible") %>' Font-Size="8"></asp:TextBox>
                    <asp:ImageButton runat="server" ID="imbCalendar" Visible='<%# (Eval("paramControl").trim = "calendar") and Eval("paramVisible") %>' ImageUrl="~/images/misc/calendar-blue.png" ImageAlign="AbsMiddle" />
                    <asp:TextBox runat="server" ID="calParam" Width="100"  
             Font-Size="8" Visible='<%# (Eval("paramControl").trim = "calendar") and Eval("paramVisible") %>'></asp:TextBox>
             <asp:Image runat="server" id="imgReq" ImageAlign="Middle" Visible="false" ImageUrl="~/images/1306438480_minus_circle.png" />
         <cc1:CalendarExtender ID="txtDate_CalendarExtender" runat="server" 
             Enabled="True" TargetControlID="calParam" PopupButtonID="imbCalendar" Format="MMM dd, yyyy" >
         </cc1:CalendarExtender>
                   <asp:CheckBox ID="chkParam" runat="server" Visible='<%# (Eval("paramControl").trim = "checkbox") and Eval("paramVisible") %>' Font-Size="8"/>
                    </td>
            </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
         <div class="portletbox" style="text-align:center; margin-top:15px;  padding-top:10px; margin-right: 80px; margin-left: 80px; padding-bottom: 10px;"> 

             <asp:Imagebutton ID="btnDOC" runat="server" Height="24px" 
                 ImageUrl="~/images/misc/doc.jpg" 
                 ToolTip="Documento de MS Word" OnClick="genDOC" CausesValidation="True"  />&nbsp;&nbsp;&nbsp;

             <asp:Imagebutton ID="btnXLS" runat="server" Height="24px" 
                 ImageUrl="~/images/misc/xls.jpg" 
                 ToolTip="Documento de MS Excel" OnClick="genXLS" CausesValidation="True" />&nbsp;&nbsp;&nbsp;
             
             <asp:Imagebutton ID="btnXLD" runat="server" Height="24px" 
                 ImageUrl="~/images/misc/xld.jpg" 
                 ToolTip="Hoja de datos de MS Excel" OnClick="genXLD" 
                 CausesValidation="True" />&nbsp;&nbsp;&nbsp;               

             <asp:Imagebutton ID="btnPDF" runat="server" Height="24px" 
                 ImageUrl="~/images/misc/pdf.jpg" 
                 ToolTip="Documento Acrobat PDF" OnClick="genPDF" CausesValidation="True" /><br />
                
        </div>
        </ContentTemplate>
        </asp:UpdatePanel>

   
        </div>
             
    </asp:Panel>


  
<asp:HiddenField ID="hfReportType" runat="server" />


  
<asp:HiddenField ID="hfDBname" runat="server" />


  
<asp:HiddenField ID="hfDBServer" runat="server" />
<asp:HiddenField ID="hfParamID" runat="server" />



  
<asp:HiddenField ID="hfParamOptional1" runat="server" />



  
<asp:HiddenField ID="hfParamOptional2" runat="server" />



  
<asp:HiddenField ID="hfParamOptional3" runat="server" />



  
    <asp:SqlDataSource ID="dsParams" runat="server" 
        ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
        
            
    SelectCommand="SELECT tblReportParameters.reportID, tblReportParameters.paramName, tblReportParameters.paramType, tblReportParameters.paramTitle, ISNULL(tblReportParameters.paramVisible, 0) AS paramVisible, ISNULL(tblReportParameters.paramIsID, 0) AS paramIsID, ISNULL(tblReportParameters.paramIsOptional, 0) AS paramIsOptional, tblReportParameters.paramOptionalID, tblReportParametersType.paramControl FROM tblReportParameters INNER JOIN tblReportParametersType ON tblReportParameters.paramType = tblReportParametersType.paramType WHERE (tblReportParameters.reportID = @rID)">
        <SelectParameters>
            <asp:SessionParameter Name="rID" SessionField="ReportID" />
        </SelectParameters>
    </asp:SqlDataSource>
<asp:HiddenField ID="hfItemClass" runat="server" />



  
    <asp:SqlDataSource ID="dsReport" runat="server" 
        ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
        
    SelectCommand="SELECT * FROM [tblReports] WHERE ([reportID] = @reportID)">
        <SelectParameters>
            <asp:SessionParameter Name="reportID" SessionField="ReportID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource> 