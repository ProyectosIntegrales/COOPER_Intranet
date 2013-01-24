<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEmpty.master" AutoEventWireup="false" CodeFile="cddAdmin.aspx.vb" Inherits="cdd_cddAdmin" %>

<%@ Register src="cddDocTypes.ascx" tagname="cddDocTypes" tagprefix="uc1" %>

<%@ Register src="cddUsers.ascx" tagname="cddUsers" tagprefix="uc2" %>

<%@ Register src="../app_controls/cntrlError.ascx" tagname="cntrlError" tagprefix="uc3" %>

<%@ Register src="cddDeptos.ascx" tagname="cddDeptos" tagprefix="uc4" %>

<%@ Register src="cddAreas.ascx" tagname="cddAreas" tagprefix="uc5" %>

<%@ Register src="../app_controls/cntrlReports.ascx" tagname="cntrlReports" tagprefix="uc6" %>

<%@ Register src="cddPDFCLog.ascx" tagname="cddPDFCLog" tagprefix="uc7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="pnlAdmin" runat="server">

    <table cellpadding="0" cellspacing="0">
        <tr>
          <td>
                <asp:Panel ID="pnlDeptos" runat="server" CssClass="grayMenu">
                    <asp:LinkButton ID="lnbDeptos" runat="server" CommandArgument="DEPTOS"></asp:LinkButton>
                </asp:Panel>
            </td>
          
              <td>
                <asp:Panel ID="pnlMenuUsers" runat="server" CssClass="grayMenu">
                    <asp:LinkButton ID="lnbUsers" runat="server" CommandArgument="USERS"></asp:LinkButton>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel ID="pnlDocTypes" runat="server" CssClass="grayMenu">
                    <asp:LinkButton ID="lnbDocTypes" runat="server" CommandArgument="TYPES"></asp:LinkButton>
                </asp:Panel>
            </td>
                  <td>
                <asp:Panel ID="pnlReports" runat="server" CssClass="grayMenu">
                    <asp:LinkButton ID="lnbPDFC" runat="server" CommandArgument="REPORTS"></asp:LinkButton>
                </asp:Panel>
            </td>
        </tr>
    </table>
        
        <uc4:cddDeptos ID="cddDeptos1" runat="server" Visible="True" />
    <uc1:cddDocTypes ID="cddDocTypes1" runat="server" Visible="False" />
        <uc7:cddPDFCLog ID="cddPDFCLog1" runat="server" Visible="False" />
        <uc2:cddUsers ID="cddUsers1" runat="server" Visible="False" />
    </asp:Panel>
    
  <uc3:cntrlError ID="cntrlError1" runat="server" />
</asp:Content>

