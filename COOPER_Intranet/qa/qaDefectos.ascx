<%@ Control Language="VB" AutoEventWireup="false" CodeFile="qaDefectos.ascx.vb" Inherits="qa_qaDefectos" %>
<style type="text/css">



a
{
    color: #990000;
    text-decoration: none;
}

</style>
        
      
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    CellPadding="4" DataKeyNames="defectoId" DataSourceID="dsDefectos" 
    ForeColor="#333333" GridLines="None" CssClass="gridview" 
    AllowPaging="True" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
            <asp:TemplateField HeaderText="Defecto" SortExpression="defectoID" >

            <ItemTemplate>
            <asp:Label ID="lblDefectoID" runat="server" Text='<%# Bind("defectoID") %>' Font-Bold="True"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
            <asp:Label ID="lblDefectoID" runat="server" Text='<%# Bind("defectoID") %>' Font-Bold="True"></asp:Label>
            </EditItemTemplate>
            <FooterTemplate>
            <asp:Label ID="lblDefectoID" runat="server" Font-Bold="True"></asp:Label>
            </FooterTemplate>
                <FooterStyle HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Left" />
            </asp:TemplateField>
        <asp:TemplateField HeaderText="Descripción" SortExpression="defectoDescription" 
            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
            
            <ItemTemplate>
                <asp:Label ID="lblDefectoDesc" runat="server" Text='<%# Bind("defectoDescription") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtDefectoDesc" runat="server" Text='<%# Bind("defectoDescription") %>' CssClass="textbox" Width="200"></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
               <asp:textbox ID="txtDefectoDesc" runat="server" CssClass="textbox" Width="200"></asp:textbox>
            </FooterTemplate>

            <FooterStyle HorizontalAlign="Left" />

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
        </asp:TemplateField>
         
        
        <asp:TemplateField>
        <ItemTemplate>
        <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png" CommandName="Edit"  />
        <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png" CommandArgument='<%# Bind("defectoID") %>' OnClientClick="return confirm('¿Estás seguro de eliminar este registro?');" OnClick="Delete" />
        </ItemTemplate>
        <EditItemTemplate>
         <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Update" CommandArgument='<%# Bind("defectoID") %>' />
        <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/images/Icons/16X16/cancel.png"  CommandName="Cancel" />
        </EditItemTemplate>
        <HeaderTemplate>
        
        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png" OnClick="enableAdd" />
        </HeaderTemplate>
        <FooterTemplate>
          <asp:ImageButton ID="imbOK0" runat="server" 
                ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Insert" />
        <asp:ImageButton ID="imbCancel0" runat="server" 
                ImageUrl="~/images/Icons/16X16/cancel.png" OnClick="Cancel" />
        </FooterTemplate>
            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
            <ItemStyle HorizontalAlign="Right" Wrap="False" />
        </asp:TemplateField>

    </Columns>
    <EditRowStyle BackColor="#CCCCCC" />
        <EmptyDataTemplate>
            <asp:Label ID="lblEmpty" runat="server"></asp:Label>
            &nbsp;<asp:ImageButton ID="imbAdd0" runat="server" 
                ImageUrl="~/images/Icons/16X16/add.png" OnClick="enableAdd" />
        </EmptyDataTemplate>
    <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" HorizontalAlign="Right" Width="40" />
    <HeaderStyle BackColor="#666666" Font-Bold="True" ForeColor="White" 
            HorizontalAlign="Left" />

                            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" 
                            CssClass="gridviewPager" />
    <RowStyle BackColor="White" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <SortedAscendingCellStyle BackColor="#FDF5AC" />
    <SortedAscendingHeaderStyle BackColor="#4D0000" />
    <SortedDescendingCellStyle BackColor="#FCF6C0" />
    <SortedDescendingHeaderStyle BackColor="#820000" />
</asp:GridView>
<asp:SqlDataSource ID="dsDefectos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    SelectCommand="SELECT qaa.tblDefectos.* FROM qaa.tblDefectos">
</asp:SqlDataSource>

