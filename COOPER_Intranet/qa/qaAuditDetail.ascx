<%@ Control Language="VB" AutoEventWireup="false" CodeFile="qaAuditDetail.ascx.vb" Inherits="qa_qaAuditDetail" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register src="../app_controls/cntrlError.ascx" tagname="cntrlError" tagprefix="uc1" %>

<style type="text/css">
    .style1
    {
        width: 100%;
    }
    </style>

<table class="style1" cellpadding="3" cellspacing="0" 
    style="border-style: solid; border-color: #666666">
    <tr>
        <td align="left" bgcolor="#666666" colspan="3" height="30" 
            style="color: #FFFFFF; font-size: 14px; font-weight: bold;" 
            valign="middle">
            Detalle de Inspección</td>
        <td align="right" bgcolor="#666666" colspan="3" height="30" 
            style="color: #FFFFFF; font-size: 14px; font-weight: bold;" 
            valign="middle">
            <asp:Label ID="lblAction" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="right">
            &nbsp;</td>
        <td colspan="2">
            &nbsp;</td>
        <td align="right">
            &nbsp;</td>
        <td colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td align="right">
            Folio:</td>
        <td colspan="2">
            <asp:Label ID="lblFolio" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
        </td>
        <td align="right">
            Fecha de Inspección:</td>
        <td colspan="2">
            <asp:TextBox ID="txtDate" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>

            <asp:CalendarExtender ID="txtDate_CalendarExtender" runat="server" 
                Enabled="True" TargetControlID="txtDate" Format="dd/MM/yyyy">
            </asp:CalendarExtender>

            <asp:MaskedEditExtender ID="txtDate_MaskedEditExtender" runat="server" 
                MaskType="Date" TargetControlID="txtDate" Mask="99/99/9999" 
                ClearMaskOnLostFocus="False" 
                >
            </asp:MaskedEditExtender>
            &nbsp;(dd/mm/aaaa)</td>
    </tr>
    <tr>
        <td align="right" style="padding-top: 10px">
            Auditor:
        </td><td style="padding-top: 10px" colspan="2">
            <asp:DropDownList ID="ddlAuditor" runat="server" CssClass="textbox" 
                DataSourceID="dsAuditores" DataTextField="userFullname" DataValueField="userID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="dsAuditores" runat="server" 
                ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                
                SelectCommand="SELECT userFullname, userID FROM qaa.vUsers WHERE (userPriv &gt; 0) ORDER BY userPriv, userFullname">
            </asp:SqlDataSource>
        </td>
        <td align="right" style="padding-top: 10px">
            Date Code:</td>
        <td style="padding-top: 10px" colspan="2">
            <asp:TextBox ID="txtDatecode" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align="right">
            Area:</td>
        <td colspan="2">
            <asp:DropDownList ID="ddlArea" runat="server" 
                CssClass="textbox" DataSourceID="dsAreas" DataTextField="areaName" 
                DataValueField="areaID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="dsAreas" runat="server" 
                ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                SelectCommand="SELECT areaName, areaID FROM qaa.tblAreas">
            </asp:SqlDataSource>
        </td>
        <td align="right">
            Lote Planeado:</td>
        <td colspan="2">
            <asp:TextBox ID="txtLotPlan" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align="right">
            Orden de Trabajo:</td>
        <td colspan="2">
        <asp:TextBox ID="txtOrder" runat="server" CssClass="textbox"></asp:TextBox>
            
        </td>
        <td align="right">
            Lote Entragado:</td>
        <td colspan="2">
            <asp:TextBox ID="txtLotInsp" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align="right" valign="top">
            No. de Parte:</td>
        <td valign="top" style="padding-bottom: 10px" colspan="2">
        <asp:TextBox ID="txtPartNo" runat="server" CssClass="textbox"></asp:TextBox>
           
        </td>
        <td align="right">
            Cant. Inspeccionada:</td>
        <td colspan="2">
            <asp:TextBox ID="txtQtyInsp" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align="right" bgcolor="Gray" 
            style="background-color: #999999; color: #FFFFFF" valign="middle">
            Defecto:</td>
        <td bgcolor="Gray" style="background-color: #999999; color: #FFFFFF" 
            valign="middle" colspan="2">
            <asp:DropDownList ID="ddlDefectos" runat="server" CssClass="textbox" DataTextField="Defecto" 
                DataValueField="defectoID">
            </asp:DropDownList>
        </td>
        <td align="right" style="background-color: #999999; color: #FFFFFF;" 
            valign="middle">
            Cantidad:</td>
        <td align="right" style="background-color: #999999; color: #FFFFFF; width: 30px;" 
            valign="middle" width="30">
            <asp:TextBox ID="txtQtyDef" runat="server" style="text-align:right" CssClass="textbox" Width="30px"></asp:TextBox>
        </td>
        <td align="left" style="background-color: #999999; color: #FFFFFF; padding-left:10px;" 
            valign="middle" width="250">
            <asp:imageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png" ImageAlign="Middle" />
               
        </td>
    </tr>

                <asp:Repeater ID="repDefectos" runat="server">
                <ItemTemplate>
                
                <tr><td></td>
                    <td align="left" style="padding-left: 8px">
                        <asp:HiddenField ID="hflDefID" runat="server" Value='<%# Bind("defectoId") %>' />
                        <asp:Label ID="lblDefectoDesc" runat="server" Text='<%# Bind("defectoDesc") %>'></asp:Label></td>
                    <td></td><td></td>
                    <td align="right" style="padding-right: 5px">
                        <asp:Label ID="lblDefectoQty" runat="server" Text='<%# Bind("defectoQty") %>'></asp:Label></td><td style="padding-left: 10px">
                <asp:ImageButton ID="imbDelete" runat="server" CommandArgument='<%# Bind("defectoID") %>' OnClick="deleteDefecto" Imageurl="~/images/Icons/16X16/delete.png" ImageAlign="Middle" Visible='<%# hflAction.Value = "UPD" Or hflAction.Value = "ADD" %>' /></td>
                </tr>
            
            </ItemTemplate>
            <AlternatingItemTemplate>
                             <tr bgcolor="#F0F0F0"><td></td>
                    <td align="left" style="padding-left: 8px">
                        <asp:HiddenField ID="hflDefID" runat="server" Value='<%# Bind("defectoId") %>' />
                        <asp:Label ID="lblDefectoDesc" runat="server" Text='<%# Bind("defectoDesc") %>'></asp:Label></td>
                    <td></td>
                    <td></td>
                    <td align="right" style="padding-right: 5px">
                        <asp:Label ID="lblDefectoQty" runat="server" Text='<%# Bind("defectoQty") %>'></asp:Label></td><td style="padding-left: 10px">
                <asp:ImageButton ID="imbDelete" runat="server" CommandArgument='<%# Bind("defectoID") %>' OnClick="deleteDefecto" Imageurl="~/images/Icons/16X16/delete.png" ImageAlign="Middle" Visible='<%# hflAction.Value = "UPD" Or hflAction.Value = "ADD" %>'  /></td>
                </tr>
   
            </AlternatingItemTemplate>
                </asp:Repeater>
                

    <tr >
        <td align="right" colspan="6" 
            style="border-top-style: solid; border-color: #C0C0C0">
            <asp:Image ID="imgSpacer" runat="server" ImageUrl="~/images/Icons/spacer.png" Height="5" /></td>
    </tr>
                

    <tr >
        <td align="right">
            Pzas retrabajadas:</td>
        <td>
            <asp:TextBox ID="txtRework" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
        </td>
        <td align="right">
            Pzas Aceptadas:</td>
        <td align="left">
            <asp:TextBox ID="txtAceptadas" runat="server" CssClass="textbox" 
                Width="80px"></asp:TextBox>
        </td>
        <td colspan="2">
            &nbsp;</td>
    </tr>
                

    <tr>
        <td align="right" valign="top">
            DR:</td>
        <td valign="top">
            <asp:TextBox ID="txtDr" runat="server" CssClass="textbox" Width="80px"></asp:TextBox>
        </td>
        <td align="right" valign="top">
            Comentarios:</td>
        <td align="left" colspan="3" valign="top">
            <asp:TextBox ID="txtComments" runat="server" CssClass="textbox" Height="40px" 
                TextMode="MultiLine" Width="100%"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align="center" colspan="6" style="padding-top: 5px">
                        <asp:Button ID="btnOK" runat="server" CssClass="button" Text="Aceptar" />
                        &nbsp; 
                        <asp:Button ID="btnClose" runat="server" CssClass="button"
                            Text="Cerrar" CausesValidation="False" />
                    </td>
    </tr>
    <tr>
        <td align="center" colspan="6" 
            
            
            style="color: #CC0000; font-weight: bold; padding-bottom: 10px; padding-top: 5px">
            <asp:Label ID="lblError" runat="server"></asp:Label></td>
    </tr>
    </table>

<asp:HiddenField ID="hflAction" runat="server" />
<uc1:cntrlError ID="cntrlError1" runat="server" />


