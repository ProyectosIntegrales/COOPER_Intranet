<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddEmail.ascx.vb" Inherits="cdd_cddEmail" %>
<style type="text/css">


a
{
    color: #990000;
    text-decoration: none;
}

</style>
        
      
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    CellPadding="4" DataKeyNames="typeId" DataSourceID="dsEmails" 
    ForeColor="#333333" GridLines="None" CssClass="gridview" 
    AllowPaging="True" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:BoundField DataField="EmailId" HeaderText="No." InsertVisible="False" 
            ReadOnly="True" SortExpression="EmailId" >
        <ControlStyle Font-Size="8pt" Width="20px" />
        <HeaderStyle Font-Size="9pt" HorizontalAlign="Left" />
        <ItemStyle Font-Size="9pt" HorizontalAlign="Center" Width="60px" 
            Font-Bold="True" />
        </asp:BoundField>
        <asp:TemplateField HeaderText="Asunto" SortExpression="EmailSubject" 
            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
            <EditItemTemplate>
                <asp:TextBox ID="txtEmailSubject" runat="server" Text='<%# Bind("EmailSubject") %>' Width="100%" cssclass="textbox" Font-Size="8"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmailSubject") %>' Font-Size="8"></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
              <asp:TextBox ID="txtEmailSubject" runat="server" Text="" Width="100%" 
                      cssclass="textbox" Font-Size="8" ></asp:TextBox>
            </FooterTemplate>

            <FooterStyle Font-Size="8pt" />

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left" Font-Bold="True"></ItemStyle>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mensaje" SortExpression="EmailMessage">
            <EditItemTemplate>
                <asp:TextBox ID="txtEmailMessage" runat="server" Text='<%# Bind("EmailMessage") %>' CssClass="textbox" Font-Size="8"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblEmailMessage" runat="server" Text='<%# Bind("EmailMessage") %>' Font-Size="8"></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtEmailMessage" runat="server" Text="" CssClass="textbox" Font-Size="8"></asp:TextBox>
            </FooterTemplate>
            <FooterStyle HorizontalAlign="Center" />
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Aprobación por<br>Ing. de Manuf." SortExpression="mfgEngApproval" Visible="true">
            <EditItemTemplate>
            <asp:CheckBox ID="chkmfgEngApproval" runat="server" 
                    Checked='<%# isnull(Eval("mfgEngApproval"),0) %>' Enabled="True"  />

            </EditItemTemplate>
            <ItemTemplate>
            <asp:CheckBox ID="chkmfgEngApproval" runat="server" 
                    Checked='<%# isnull(Eval("mfgEngApproval"),0) %>' Enabled="false"  />

            </ItemTemplate>
            <FooterTemplate>
            <asp:CheckBox ID="chkmfgEngApproval" runat="server" 
                    Checked="false"   />

            </FooterTemplate>
            <FooterStyle HorizontalAlign="Center" />
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Aprobación por<br>Ing. de Calidad" SortExpression="calEngApproval" Visible="true">
            <EditItemTemplate>
            <asp:CheckBox ID="chkCalEngApproval" runat="server" 
                    Checked='<%# isnull(Eval("calEngApproval"),0) %>' Enabled="True"  />

            </EditItemTemplate>
            <ItemTemplate>
            <asp:CheckBox ID="chkCalEngApproval" runat="server" 
                    Checked='<%# isnull(Eval("calEngApproval"),0) %>' Enabled="false"  />

            </ItemTemplate>
            <FooterTemplate>
            <asp:CheckBox ID="chkCalEngApproval" runat="server" 
                    Checked="false"   />

            </FooterTemplate>
            <FooterStyle HorizontalAlign="Center" />
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Clave" SortExpression="typeFoldername">
            <EditItemTemplate>
                <asp:TextBox ID="txtFoldername" runat="server" Text='<%# Bind("typeFoldername") %>' cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblFoldername" runat="server" Text='<%# Bind("typeFoldername") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:TextBox ID="txtFoldername" runat="server" Text="" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>

         <asp:TemplateField HeaderText="Formato de Documento" SortExpression="typeNameFormat">
            <EditItemTemplate>
                <asp:TextBox ID="txtNameFormat" runat="server" Text='<%# Bind("typeNameFormat") %>' cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblNameFormat" runat="server" Text='<%# Bind("typeNameFormat") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:TextBox ID="txtNameFormat" runat="server" Text="" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField>
        <ItemTemplate>
        <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png" CommandName="Edit"  />
        <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png" CommandArgument='<%# Bind("typeID") %>' OnClientClick="return confirm('¿Está seguro de eliminar este registro?');" OnClick="Delete" />
        </ItemTemplate>
        <EditItemTemplate>
         <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Update" CommandArgument='<%# Bind("typeID") %>' />
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
            <FooterStyle Font-Size="9pt" />
            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" Font-Size="9pt" />
            <ItemStyle HorizontalAlign="Right" Wrap="False" Font-Size="9pt" />
        </asp:TemplateField>

    </Columns>
    <EditRowStyle BackColor="#CCCCCC" />
    <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" HorizontalAlign="Right" Width="40" />
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
<asp:SqlDataSource ID="dsEmails" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    ProviderName="<%$ ConnectionStrings:COOPER_IntranetConnectionString.ProviderName %>" 
    
    SelectCommand="SELECT cdd.tblEmailNotifications.* FROM cdd.tblEmailNotifications"></asp:SqlDataSource>

