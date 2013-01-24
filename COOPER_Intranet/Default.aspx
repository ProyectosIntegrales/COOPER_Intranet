<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" ValidateRequest="false"  %>
<%@ Reference Control = "app_addIns/userControl.ascx" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:PlaceHolder ID="PlaceHolder1" runat="server" >
    </asp:PlaceHolder>


</asp:Content>

