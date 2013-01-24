<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/MasterEmpty.master" CodeFile="adm_Deptos.aspx.vb" Inherits="app_admin_adm_Deptos" %>
<%@ Register src="adm_Privs.ascx" tagname="adm_Privs" tagprefix="uc1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        
      
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    CellPadding="4" DataKeyNames="deptoID" DataSourceID="dsDeptos" 
    ForeColor="#333333" GridLines="None" CssClass="gridview" 
    AllowPaging="True" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:BoundField DataField="deptoID" HeaderText="deptoId" InsertVisible="False" 
            ReadOnly="True" SortExpression="deptoId" Visible="False" />
<asp:TemplateField HeaderText="Depto." SortExpression="deptoShort">
            <EditItemTemplate>
                <asp:TextBox ID="txtDeptoShort" runat="server" Text='<%# Bind("deptoMnemonic") %>' Width="100" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("deptoMnemonic") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:TextBox ID="txtDeptoShort" runat="server" Text="" Width="100" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Nombre" SortExpression="deptoName" 
            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
            <EditItemTemplate>
                <asp:TextBox ID="txtdeptoName" runat="server" Text='<%# Bind("deptoName") %>' Width="100%" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("deptoName") %>'></asp:Label>
            </ItemTemplate>
               <FooterTemplate>
                <asp:TextBox ID="txtdeptoName" runat="server" Text="" Width="100%" cssclass="textbox" Font-Size="9" ></asp:TextBox>
            </FooterTemplate>

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
        </asp:TemplateField>
         
        
        <asp:TemplateField HeaderText="Gerente/Supervisor" SortExpression="Managername">
            <EditItemTemplate>
                <asp:TextBox ID="txtdeptomanagerNo" runat="server" Text='<%# Bind("deptomanagerNo") %>' 
                    Width="40px" cssclass="textbox" Font-Size="9" AutoPostBack="True" 
                    ontextchanged="MgrnoChanged" ></asp:TextBox>
                &nbsp;<asp:Label ID="lblMgrname" runat="server"></asp:Label>
            </EditItemTemplate>
            <FooterTemplate>
                &nbsp;<asp:Label ID="lblMgrname" runat="server"></asp:Label>
            
            <asp:TextBox ID="txtdeptomanagerNo" runat="server" Text="" 
                    Width="40px" cssclass="textbox" Font-Size="9" AutoPostBack="True" 
                    ontextchanged="MgrnoChanged" ></asp:TextBox>
            
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("deptomanagerNo") & " - " & Eval("Managername") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
            <asp:TextBox ID="txtdeptomanagerNo" runat="server"  
                   Width="100%" cssclass="textbox" Font-Size="9" ></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        
        <asp:TemplateField HeaderText="Celdas"></asp:TemplateField>
        
        <asp:TemplateField>
        <ItemTemplate>
        <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png" CommandName="Edit"  />
        <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png" CommandArgument='<%# Bind("deptoID") %>' OnClientClick="return confirm('¿Está seguro de eliminar este registro?');" OnClick="Delete" />
        </ItemTemplate>
        <EditItemTemplate>
         <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Update" CommandArgument='<%# Bind("deptoID") %>' />
        <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/images/Icons/16X16/cancel.png"  CommandName="Cancel" />
        </EditItemTemplate>
        <HeaderTemplate>
        
        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png" OnClick="enableAdd" />
        </HeaderTemplate>
        <FooterTemplate>
          <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Insert" />
        <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/images/Icons/16X16/cancel.png" OnClick="Cancel" />
        </FooterTemplate>
            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
            <ItemStyle HorizontalAlign="Right" Wrap="False" />
        </asp:TemplateField>

    </Columns>
    <EditRowStyle BackColor="#CCCCCC" />
    <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#666666" Font-Bold="True" ForeColor="White" 
            HorizontalAlign="Left" />
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="White" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <SortedAscendingCellStyle BackColor="#FDF5AC" />
    <SortedAscendingHeaderStyle BackColor="#4D0000" />
    <SortedDescendingCellStyle BackColor="#FCF6C0" />
    <SortedDescendingHeaderStyle BackColor="#820000" />
</asp:GridView>
<asp:SqlDataSource ID="dsDeptos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    
        
        
        SelectCommand="SELECT * FROM [vDeptos] ORDER BY [deptoMnemonic]" >
 
</asp:SqlDataSource>

</asp:Content>
