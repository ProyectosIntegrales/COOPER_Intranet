<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cAdmin.ascx.vb" Inherits="qa_cAdmin" %>
<%@ Register src="qaUsers.ascx" tagname="qaUsers" tagprefix="uc4" %>
<%@ Register src="qaAreas.ascx" tagname="qaAreas" tagprefix="uc2" %>
<%@ Register src="qaDefectos.ascx" tagname="qaDefectos" tagprefix="uc1" %>
<%@ Register src="../app_controls/cntrlError.ascx" tagname="cntrlError" tagprefix="uc3" %>

<style type="text/css">




a
{
    color: #990000;
    text-decoration: none;
}

    a
    {
        color: #990000;
        text-decoration: none;
    }

a
{
    color: #990000;
    text-decoration: none;
}

 .grayMenu
{
    padding: 4px 15px 0px 15px;
    border-style: none solid solid none;
    margin: 0px;
    background-color: #CCCCCC;
    text-align: center;
    border-top-width: 1px;
    border-right-width: 1px;
    border-bottom-width: 1px;
    border-left-width: 1px;
    border-top-color: #FFF;
    border-right-color: #FFF;
    border-bottom-color: #FFF;
    border-left-color: #FFF;
    color: #FFFFFF;
    text-decoration: none;
    height: 20px;
    vertical-align: middle;
}

.gridviewPager span
{
    color: Gray;
    font-weight: bold;
    text-decoration: none; 
    padding-left: 5px;
    padding-right: 5px;
    background-color: White;  
}

</style>
    <asp:Panel ID="pnlAdmin" runat="server">

    <table cellpadding="0" cellspacing="0">
        <tr>

           <td>
                <asp:Panel ID="pnlUsers" runat="server" CssClass="activeMenu">
                    <asp:LinkButton ID="lnbUsers" runat="server" CommandArgument="USERS"></asp:LinkButton>
                </asp:Panel>
            </td>

          <td>
                <asp:Panel ID="pnlDefectos" runat="server" CssClass="grayMenu">
                    <asp:LinkButton ID="lnbDefectos" runat="server" CommandArgument="DEFS"></asp:LinkButton>
                </asp:Panel>
            </td>
          
              <td>
                <asp:Panel ID="pnlAreas" runat="server" CssClass="grayMenu">
                    <asp:LinkButton ID="lnbAreas" runat="server" CommandArgument="AREAS"></asp:LinkButton>
                </asp:Panel>
            </td>
   
        </tr>
    </table>
        
    </asp:Panel>
    
    <uc4:qaUsers ID="qaUsers1" runat="server" />
    <uc2:qaAreas ID="qaAreas1" runat="server" Visible="False" />
    <uc1:qaDefectos ID="qaDefectos1" runat="server" Visible="False" />
    
  <uc3:cntrlError ID="cntrlError1" runat="server" />

