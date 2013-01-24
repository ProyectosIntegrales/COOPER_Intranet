<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddUsers.ascx.vb" Inherits="cdd_users" %>
<style type="text/css">


a
{
    color: #990000;
    text-decoration: none;
}

</style>
        
      
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    CellPadding="4" DataKeyNames="userId" DataSourceID="dsUsers" 
    ForeColor="#333333" GridLines="None" CssClass="gridview" 
    AllowPaging="True" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:BoundField DataField="userId" HeaderText="userId" InsertVisible="False" 
            ReadOnly="True" SortExpression="typeId" Visible="False" />
            <asp:TemplateField HeaderText="No. Empl" SortExpression="userEmployeeNo" >

            <ItemTemplate>
            <asp:Label ID="lblEmployeeNo" runat="server" Text='<%# Bind("userEmployeeNo") %>' Font-Bold="True"></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
            <asp:TextBox ID="txtEmployeeNo" runat="server" Width="60px" cssclass="textbox" 
                    Font-Size="9" OnTextChanged="getEmployeeInfo" AutoPostBack="True"></asp:TextBox>
            </FooterTemplate>
                <FooterStyle HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Left" />
            </asp:TemplateField>
        <asp:TemplateField HeaderText="Usuario" SortExpression="userName" 
            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
            
            <ItemTemplate>
                <asp:Label ID="lblUsername" runat="server" Text='<%# Bind("userName") %>'></asp:Label>
            </ItemTemplate>
               <FooterTemplate>
               <asp:label ID="lblUsername" runat="server" ></asp:label>
            </FooterTemplate>

            <FooterStyle HorizontalAlign="Left" />

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
        </asp:TemplateField>
         
        <asp:TemplateField HeaderText="Nombre" SortExpression="userFullName">
            <ItemTemplate>
                <asp:Label ID="lblFullname" runat="server" Text='<%# Bind("userFullName") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="lblFullName" runat="server" ></asp:Label>
            </FooterTemplate>
            <FooterStyle HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        
        <asp:TemplateField SortExpression="privLevelDescription" 
            HeaderText="Tipo de Acceso">
            <EditItemTemplate>
            <asp:DropDownList id="ddlPrivLevel" runat="server" CssClass="textbox" 
                    DataSourceID="dsPrivs" DataTextField="privLevelDescription" 
                    DataValueField="privLevelID" Font-Size="9pt" SelectedValue='<%# Bind("privLevel") %>'>
            </asp:DropDownList>

                <asp:SqlDataSource ID="dsPrivs" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:COOPER_IntranetConnectionString.ProviderName %>" 
                    SelectCommand="SELECT privLevelID, privLevelDescription FROM cdd.tblPrivs">
                </asp:SqlDataSource>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("privLevelDescription") %>' Font-Bold="True"></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:DropDownList id="ddlPrivLevel" runat="server" CssClass="textbox" 
                    DataSourceID="dsPrivs" DataTextField="privLevelDescription" 
                    DataValueField="privLevelID" Font-Size="9pt" >
            </asp:DropDownList>

                <asp:SqlDataSource ID="dsPrivs" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:COOPER_IntranetConnectionString.ProviderName %>" 
                    SelectCommand="SELECT privLevelID, privLevelDescription FROM cdd.tblPrivs">
                </asp:SqlDataSource>
            </FooterTemplate>
            <FooterStyle HorizontalAlign="Left" />
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        
        <asp:TemplateField>
        <ItemTemplate>
        <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png" CommandName="Edit"  />
        <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png" CommandArgument='<%# Bind("userID") %>' OnClientClick="return confirm('Are you sure you want to delete this user?');" OnClick="Delete" />
        </ItemTemplate>
        <EditItemTemplate>
         <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Update" CommandArgument='<%# Bind("userID") %>' />
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
            &nbsp;<asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png" OnClick="enableAdd" />
        </EmptyDataTemplate>
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
<asp:SqlDataSource ID="dsUsers" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    ProviderName="<%$ ConnectionStrings:COOPER_IntranetConnectionString.ProviderName %>" 
    
    
    
    
    SelectCommand="SELECT cdd.vUsers.userName, cdd.vUsers.userFullname, cdd.vUsers.userEmployeeNo, cdd.vUsers.userDept, cdd.vUsers.userEMailAddress, cdd.vUsers.userID, cdd.vUsers.privLevel, cdd.tblPrivs.privLevelDescription FROM cdd.vUsers INNER JOIN cdd.tblPrivs ON cdd.vUsers.privLevel = cdd.tblPrivs.privLevelID WHERE (cdd.vUsers.userID &gt; 1)"></asp:SqlDataSource>

