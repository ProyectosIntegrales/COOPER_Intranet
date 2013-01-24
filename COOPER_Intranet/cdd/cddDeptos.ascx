<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddDeptos.ascx.vb" Inherits="cddDeptos" %>
<%@ Register src="cddAreas.ascx" tagname="cddAreas" tagprefix="uc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
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
</style>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
    DataKeyNames="deptoID" DataSourceID="dsDeptos" ForeColor="#333333" GridLines="None"
    CssClass="gridview" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="#F2F2F2" />
    <Columns>
        <asp:BoundField DataField="deptoID" HeaderText="deptoId" InsertVisible="False" ReadOnly="True"
            SortExpression="deptoId" Visible="False" />
        <asp:TemplateField HeaderText="Depto." SortExpression="deptoShort">
            <EditItemTemplate>
                <asp:TextBox ID="txtDeptoMnemonic" runat="server" Text='<%# Bind("deptoMnemonic") %>'
                    Width="80" CssClass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("deptoMnemonic") %>' Font-Bold="True"></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtDeptoMnemonic" runat="server" Text="" Width="80" CssClass="textbox"
                    Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Nombre" SortExpression="deptoName" ItemStyle-HorizontalAlign="Left"
            HeaderStyle-HorizontalAlign="Left">
            <EditItemTemplate>
                <asp:TextBox ID="txtdeptoName" runat="server" Text='<%# Bind("deptoName") %>' Width="100%"
                    CssClass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("deptoName") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtdeptoName" runat="server" Text="" Width="100%" CssClass="textbox"
                    Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            <ItemStyle HorizontalAlign="Left"></ItemStyle>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Gerente/Supervisor" SortExpression="Managername">
            <EditItemTemplate>
                <asp:TextBox ID="txtdeptomanagerNo" runat="server" Text='<%# Bind("deptoManagerNo") %>'
                    Width="40px" CssClass="textbox" Font-Size="9" AutoPostBack="True" OnTextChanged="MgrnoChanged"></asp:TextBox>
                <asp:TextBoxWatermarkExtender ID="txtdeptomanagerNo_TextBoxWatermarkExtender" 
                    runat="server" Enabled="True" TargetControlID="txtdeptomanagerNo" 
                    WatermarkCssClass="textboxdim" WatermarkText="Mgr No.">
                </asp:TextBoxWatermarkExtender>
                <asp:Label ID="lblMgrname" runat="server" Text='<%#  New Employee(Eval("deptoManagerNo")).FullName %>'></asp:Label>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:Label ID="lblMgrname" runat="server"></asp:Label>
                <asp:TextBox ID="txtdeptomanagerNo" runat="server" Text="" Width="40px" CssClass="textbox"
                    Font-Size="9" AutoPostBack="True" OnTextChanged="MgrnoChanged"></asp:TextBox>
            </FooterTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("deptoManagerNo") & " " & New Employee(Eval("deptoManagerNo")).FullName %>' Font-Bold="True"></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtdeptomanagerNo" runat="server" Width="100%" CssClass="textbox"
                    Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Areas">
            <EditItemTemplate>
                <uc1:cddAreas ID="cddAreas1" runat="server" 
                    DeptoID='<%# Bind("deptoID") %>' Mode="E" />
            </EditItemTemplate>
            <ItemTemplate>
                <uc1:cddAreas ID="cddAreas1" runat="server" DeptoID='<%# Bind("deptoID") %>' Mode="I" />
            </ItemTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png"
                    CommandName="Edit" />
                <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png"
                    CommandArgument='<%# Bind("deptoID") %>' OnClientClick="return confirm('¿Está seguro de eliminar este registro?');"
                    OnClick="Delete" />
            </ItemTemplate>
            <EditItemTemplate>
                <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png"
                    OnClick="Update" CommandArgument='<%# Bind("deptoID") %>' />
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
    <EditRowStyle BackColor="#CCCCCC" VerticalAlign="Top" />
    <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#666666" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="White" ForeColor="#333333" VerticalAlign="Top" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <SortedAscendingCellStyle BackColor="#FDF5AC" />
    <SortedAscendingHeaderStyle BackColor="#4D0000" />
    <SortedDescendingCellStyle BackColor="#FCF6C0" />
    <SortedDescendingHeaderStyle BackColor="#820000" />
</asp:GridView>
<asp:SqlDataSource ID="dsDeptos" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    SelectCommand="SELECT * FROM [vDeptos] ORDER BY [deptoMnemonic]"></asp:SqlDataSource>
