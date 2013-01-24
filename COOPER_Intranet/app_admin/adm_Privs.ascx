<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adm_Privs.ascx.vb"
    Inherits="app_addIns_adm_privs" ClientIDMode="AutoID" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Panel ID="pnlPrivs" runat="server" style="display:none" BackColor="White" 
    BorderColor="#333333" BorderStyle="Solid" BorderWidth="2px" Height="500px"><div>
    
   <table width="100%">
   <tr>
   <td class="leftSideHeader" 
           style="padding: 5px; border: 1px solid #666666;">
       <asp:Label ID="lblPrivLabel" runat="server"></asp:Label>
       &nbsp;<asp:Label ID="lblfullName" runat="server"></asp:Label>
       &nbsp;[<asp:Label ID="lbluserName" runat="server"></asp:Label>
       ]&nbsp;
       </td>
   </tr>
   <tr>
   <td style="padding: 5px">
       &nbsp;</td>
   </tr>
       <tr>
           <td>
               <asp:DataList ID="DataList1" runat="server" DataKeyField="sectionID" 
                   DataSourceID="dsPrivs" RepeatColumns="2" Width="100%" CellPadding="5">
                   <ItemTemplate>
                       <asp:CheckBox ID="chkPriv" runat="server" Checked='<%# Eval("PrivOK") %>' />
                       <asp:Label ID="lblSectionID" runat="server" Text='<%# Eval("sectionID") %>' Visible="False" />
                       <asp:Label ID="lblSectionTitle" runat="server" Text='<%# Eval("sectionTitle") %>' ></asp:Label>
                       <br />
                   </ItemTemplate>
               </asp:DataList>
           </td>
          
       </tr>
   </table></div>
   <div style="text-align:center; padding-top: 20px;"><asp:Button ID="btnOK" 
           runat="server" Text="OK" CssClass="button" Width="80px" />&nbsp;&nbsp;<asp:Button ID="btnClose" runat="server" Text="Close" CssClass="button" />
           </div>
</asp:Panel>
<asp:Button ID="btnPopUp" runat="server" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" DropShadow="True"
    TargetControlID="btnPopUp" PopupControlID="pnlPrivs" BackgroundCssClass="modalBackground"
    CancelControlID="btnClose">
    
</asp:ModalPopupExtender>

<asp:HiddenField ID="hflUserID" runat="server" />
<asp:SqlDataSource ID="dsPrivs" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    
    SelectCommand="SELECT sectionID, sectionTitle, MAX(x) AS PrivOK FROM (SELECT tblSections.sectionTitleESP AS sectionTitle, tblSections.sectionID, (CASE WHEN NOT privId IS NULL THEN 1 ELSE 0 END) * MAX(CASE WHEN userID = @userId THEN 1 ELSE 0 END) AS x FROM tblSections LEFT OUTER JOIN tblPrivs ON tblSections.sectionID = tblPrivs.sectionID GROUP BY tblSections.sectionID, tblPrivs.userID, tblSections.sectionTitleESP, tblPrivs.privID HAVING (tblSections.sectionID &gt; 0)) AS A GROUP BY sectionID, sectionTitle ORDER BY sectionID">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflUserID" Name="userID" PropertyName="Value" 
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>



