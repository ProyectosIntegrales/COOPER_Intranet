<%@ Control Language="VB" AutoEventWireup="false" CodeFile="qaAreas.ascx.vb" Inherits="qa_qaAreas" %>
<style type="text/css">
    a
    {
        color: #990000;
        text-decoration: none;
    }
</style>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
    DataKeyNames="areaId" DataSourceID="dsAreas" ForeColor="#333333" GridLines="None"
    CssClass="gridview" AllowPaging="True" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:BoundField DataField="areaID" HeaderText="areaID" InsertVisible="False" ReadOnly="True"
            SortExpression="areaID" Visible="False" />
        <asp:TemplateField HeaderText="Clave" SortExpression="areaMnemonic">
            <ItemTemplate>
                <asp:Label ID="lblareaMnemonic" runat="server" Text='<%# Bind("areaMnemonic") %>'
                    Font-Bold="True"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtareaMnemonic" runat="server" Font-Bold="True" CssClass="textbox"
                    Width="40" Text='<%# Bind("areaMnemonic") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtareaMnemonic" runat="server" Font-Bold="True" CssClass="textbox"
                    Width="40" AutoPostBack="True" OnTextChanged="getAreaPre"></asp:TextBox>
            </FooterTemplate>
            <FooterStyle HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Descripción" SortExpression="areaDescription" ItemStyle-HorizontalAlign="Left"
            HeaderStyle-HorizontalAlign="Left">
            <ItemTemplate>
                <asp:Label ID="lblareaName" runat="server" Text='<%# Bind("areaName") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtareaName" runat="server" Text='<%# Bind("areaName") %>' CssClass="textbox"
                    Width="200"></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtareaName" runat="server" CssClass="textbox" Width="200"></asp:TextBox>
            </FooterTemplate>
            <FooterStyle HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            <ItemStyle HorizontalAlign="Left"></ItemStyle>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png"
                    CommandName="Edit" />
                <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png"
                    CommandArgument='<%# Bind("areaID") %>' OnClientClick="return confirm('¿Estás seguro de eliminar este registro?');"
                    OnClick="Delete" />
            </ItemTemplate>
            <EditItemTemplate>
                <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png"
                    OnClick="Update" CommandArgument='<%# Bind("areaID") %>' />
                <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/images/Icons/16X16/cancel.png"
                    CommandName="Cancel" />
            </EditItemTemplate>
            <HeaderTemplate>
                <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png"
                    OnClick="enableAdd" />
            </HeaderTemplate>
            <FooterTemplate>
                <asp:ImageButton ID="imbOK0" runat="server" ImageUrl="~/images/Icons/16X16/apply.png"
                    OnClick="Insert" />
                <asp:ImageButton ID="imbCancel0" runat="server" ImageUrl="~/images/Icons/16X16/cancel.png"
                    OnClick="Cancel" />
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
            <ItemStyle HorizontalAlign="Right" Wrap="False" />
        </asp:TemplateField>
    </Columns>
    <EditRowStyle BackColor="#CCCCCC" />
    <EmptyDataTemplate>
        <asp:Label ID="lblEmpty" runat="server"></asp:Label>
        &nbsp;<asp:ImageButton ID="imbAdd0" runat="server" ImageUrl="~/images/Icons/16X16/add.png"
            OnClick="enableAdd" />
    </EmptyDataTemplate>
    <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" HorizontalAlign="Right"
        Width="40" />
    <HeaderStyle BackColor="#666666" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" CssClass="gridviewPager" />
    <RowStyle BackColor="White" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <SortedAscendingCellStyle BackColor="#FDF5AC" />
    <SortedAscendingHeaderStyle BackColor="#4D0000" />
    <SortedDescendingCellStyle BackColor="#FCF6C0" />
    <SortedDescendingHeaderStyle BackColor="#820000" />
</asp:GridView>
<asp:SqlDataSource ID="dsAreas" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    SelectCommand="SELECT qaa.tblAreas.* FROM qaa.tblAreas"></asp:SqlDataSource>
