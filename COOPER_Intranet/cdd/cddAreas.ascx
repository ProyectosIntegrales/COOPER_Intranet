<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddAreas.ascx.vb" Inherits="cddAreas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="cddCeldas.ascx" TagName="cddCeldas" TagPrefix="uc1" %>
<%@ Register src="cddEngs.ascx" tagname="cddEngs" tagprefix="uc2" %>
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
   .T {background-image: url('../images/Icons/line2.png'); background-repeat: no-repeat; background-position: right top ; margin-right:5px;}
   .M {background-image: url('../images/Icons/line1.png'); background-repeat: repeat-x; background-position: right top; margin-right:5px;}
   .F {background-image: url('../images/Icons/line3.png'); background-repeat: no-repeat; background-position: right top; margin-right:5px;}
   .L {background-image: url('../images/Icons/line4.png'); background-repeat: no-repeat; background-position: right top; margin-right:5px;}
 
    .padCells { padding-left:4px;}
    .xborderBottom { border-bottom-style: dotted; border-width: 1px; border-color: #808000; margin-bottom:3px; }
</style>
<asp:Panel ID="pnlItem" runat="server">
    <table cellpadding="0" cellspacing="0">
        <asp:Repeater ID="repItem" runat="server" DataSourceID="dsAreas">
            <ItemTemplate>
                <tr>
                <td id="tdArea" runat="server" Class="M" valign="top">
                <asp:Image ID="imgSpacer1" runat="server" Width="20" ImageUrl="~/images/Icons/spacer.png" />
                </td>
                    <td valign="top" class="padCells borderBottom" width="40" >
                        <asp:Label ID="lblAreaMnemonic" runat="server" Text='<%# Bind("areaMnemonic") %>' Font-Bold="True"></asp:Label>
                    </td>
                    <td class="padCells borderBottom" valign="top" width="100" >
                        <asp:Label ID="lblAreaName" runat="server" Text='<%# Bind("areaName") %>'></asp:Label>
                         <uc2:cddEngs ID="cddEngs1" runat="server" Mode="I" AreaId='<%# Bind("areaID") %>' />
                    </td>
                    <td class="padCells borderBottom" valign="top">
                        <uc1:cddCeldas ID="cddCeldas1" runat="server" AreaId='<%# Bind("areaId") %>' Mode="I" />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Panel>
<asp:Panel ID="pnlEdit" runat="server">
    <table cellpadding="0" cellspacing="0">
        <asp:Repeater ID="repEdit" runat="server" DataSourceID="dsAreas">
            <ItemTemplate>
                <tr>
               <td id="tdArea" runat="server" class="M" valign="top">
                <asp:Image ID="imgSpacer1" runat="server" Width="20" ImageUrl="~/images/Icons/spacer.png" />
                </td>
                    <td valign="top" class="padCells M">
                        <asp:Label ID="lblAreaID" runat="server" Visible="false" Text='<%# Bind("areaID") %>'></asp:Label>
                        <asp:TextBox ID="txtAreaMnemonic" runat="server" CssClass="textbox" Width="40" Font-Size="9"
                            Text='<%# Bind("areaMnemonic") %>'></asp:TextBox>
                    </td>
                    <td valign="top" class="M" >
                        <asp:TextBox ID="txtAreaname" runat="server" CssClass="textbox" Width="100" Font-Size="9"
                            Text='<%# Bind("areaName") %>'></asp:TextBox>
                            <uc2:cddEngs ID="cddEngs1" runat="server" Mode="E" AreaId='<%# Bind("areaID") %>' />
                    </td>
                    <td valign="top" >
                        <uc1:cddCeldas ID="cddCeldas1" runat="server" AreaId='<%# Bind("areaId") %>' Mode="E" />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <tr>
         <td id="tdNewArea" runat="server" valign="top">
                <asp:Image ID="imgSpacer1" runat="server" Width="20" ImageUrl="~/images/Icons/spacer.png" />
                </td>
            <td valign="top" class="padCells M" style="padding-right:4px" >
                <asp:TextBox ID="txtAreaMnemonic" runat="server" CssClass="textbox" Width="40" Font-Size="9"></asp:TextBox>
                <asp:TextBoxWatermarkExtender ID="txtAreaMnemonic_TextBoxWatermarkExtender" runat="server"
                    Enabled="True" TargetControlID="txtAreaMnemonic" WatermarkText="Area" WatermarkCssClass="textboxdim">
                </asp:TextBoxWatermarkExtender>
            </td>
            <td valign="top" >
                <asp:TextBox ID="txtAreaname" runat="server" CssClass="textbox" Width="100" Font-Size="9"></asp:TextBox>
                <asp:TextBoxWatermarkExtender ID="txtAreaname_TextBoxWatermarkExtender" runat="server"
                    Enabled="True" TargetControlID="txtAreaname" WatermarkText="Nombre de Area" WatermarkCssClass="textboxdim">
                </asp:TextBoxWatermarkExtender>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:SqlDataSource ID="dsAreas" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    SelectCommand="SELECT * FROM [vAreas] WHERE ([areaDeptoID] = @areaDeptoID) ORDER BY [areaMnemonic]">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflDeptoID" Name="areaDeptoID" PropertyName="Value"
            Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="hflDeptoID" runat="server" />
<asp:HiddenField ID="hflMode" runat="server" />


