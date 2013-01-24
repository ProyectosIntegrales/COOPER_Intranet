<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEmpty.master" AutoEventWireup="false" CodeFile="adm_Sections.aspx.vb" Inherits="app_addIns_adm_Sections" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="dsSections" runat="server" 
        ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
        
        
        SelectCommand="SELECT * FROM [tblSections] WHERE ([sectionID] &gt; @sectionID)">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="sectionID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    CellPadding="4" DataKeyNames="sectionID" DataSourceID="dsSections" 
    ForeColor="#333333" GridLines="None" CssClass="gridview" 
    AllowPaging="True" AllowSorting="True" Width="100%">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="sectionID" HeaderText="No." ReadOnly="True" 
                SortExpression="sectionID" >
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Nombre de la Sección" 
                SortExpression="sectionTitleESP">
                <EditItemTemplate>
                    <asp:TextBox ID="txtSectionTitleEsp" Width="100%" cssclass="textbox" Font-Size="9" runat="server" Text='<%# Bind("sectionTitleESP") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("sectionTitleESP") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                <asp:TextBox ID="txtSectionTitleEsp" Width="100%" cssclass="textbox" Font-Size="9" runat="server" ></asp:TextBox>
                </FooterTemplate>
                <HeaderStyle HorizontalAlign="Left" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Title English" SortExpression="sectionTitleENG" 
                Visible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="txtsectionTitleEng" Width="100%" cssclass="textbox" Font-Size="9" runat="server" Text='<%# Bind("sectionTitleENG") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("sectionTitleENG") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                <asp:TextBox ID="txtsectionTitleEng" Width="100%" cssclass="textbox" Font-Size="9" runat="server" ></asp:TextBox>
                </FooterTemplate>
                <HeaderStyle HorizontalAlign="Left" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Nombre del Control" 
                SortExpression="sectionControlName">
                <EditItemTemplate>
                    <asp:TextBox ID="txtSectionControlname" Width="100%" cssclass="textbox" Font-Size="9" runat="server" 
                        Text='<%# Bind("sectionControlName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("sectionControlName") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                <asp:TextBox ID="txtSectionControlname" Width="100%" cssclass="textbox" Font-Size="9" runat="server" 
                        ></asp:TextBox>
                        </FooterTemplate>
                <HeaderStyle HorizontalAlign="Left" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Menu" SortExpression="sectionLeftMenu">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("sectionLeftMenu") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" 
                        Checked='<%# Bind("sectionLeftMenu") %>' Enabled="false" />
                </ItemTemplate>
                <FooterTemplate>
                 <asp:CheckBox ID="CheckBox1" runat="server" 
                         />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Documento de Ayuda">
        <ItemTemplate>
            <asp:Label ID="Label3" runat="server" Text='<%# Bind("sectionHelpFile") %>'></asp:Label>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtSectionHelpFile" runat="server" cssclass="textbox" Font-Size="9"  Text='<%# Bind("sectionHelpFile") %>'></asp:TextBox>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:TextBox ID="txtSectionHelpFile" runat="server" cssclass="textbox" Font-Size="9"  Text='<%# Bind("sectionHelpFile") %>'></asp:TextBox>
        </FooterTemplate>
                <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>

            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="imbEdit" runat="server" CommandName="Edit" 
                        ImageUrl="~/images/Icons/16X16/edit.png" />
                    <asp:ImageButton ID="imbDelete" runat="server" 
                        CommandArgument='<%# Bind("sectionID") %>' 
                        ImageUrl="~/images/Icons/16X16/delete.png" OnClick="Delete" 
                        OnClientClick="return confirm('¿Está seguro de eliminar este registro?');" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:ImageButton ID="imbOK" runat="server" 
                        CommandArgument='<%# Bind("sectionID") %>' 
                        ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Update" />
                    <asp:ImageButton ID="imbCancel" runat="server" CommandName="Cancel" 
                        ImageUrl="~/images/Icons/16X16/cancel.png" />
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:ImageButton ID="imbOK" runat="server" 
                        ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Insert" />
                    <asp:ImageButton ID="imbCancel" runat="server" 
                        ImageUrl="~/images/Icons/16X16/cancel.png" OnClick="Cancel" />
                </FooterTemplate>
                <HeaderTemplate>
                    <asp:ImageButton ID="imbAdd" runat="server" 
                        ImageUrl="~/images/Icons/16X16/add.png" OnClick="enableAdd" />
                </HeaderTemplate>
                <FooterStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
                <ItemStyle HorizontalAlign="Right" Wrap="False" />
            </asp:TemplateField>

        </Columns>
        <EditRowStyle BackColor="#CCCCCC" Font-Size="8pt" />
        <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#666666" Font-Bold="True" ForeColor="White" 
            HorizontalAlign="Left" VerticalAlign="Bottom" />
        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <SortedAscendingCellStyle BackColor="#FDF5AC" />
        <SortedAscendingHeaderStyle BackColor="#4D0000" />
        <SortedDescendingCellStyle BackColor="#FCF6C0" />
        <SortedDescendingHeaderStyle BackColor="#820000" />
    </asp:GridView>
</asp:Content>

