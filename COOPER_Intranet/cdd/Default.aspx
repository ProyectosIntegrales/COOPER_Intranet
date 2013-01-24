<%@ Page Title="" Language="VB" AutoEventWireup="false"  MasterPageFile="~/MasterEmpty.master"  CodeFile="Default.aspx.vb" Inherits="cdd_Default" EnableEventValidation="false" %>

<%@ Register src="cddDocsList.ascx" tagname="cddDocsList" tagprefix="uc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
    <uc1:cddDocsList ID="cddDocsList1" runat="server" buttonsVisible="false" /> 
    
</asp:Content>



