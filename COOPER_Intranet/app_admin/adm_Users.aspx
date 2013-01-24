<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/MasterEmpty.master" CodeFile="adm_Users.aspx.vb" Inherits="app_addIns_adm_adm_Users" %>
<%@ Register src="adm_Privs.ascx" tagname="adm_Privs" tagprefix="uc1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        
      
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    CellPadding="4" DataKeyNames="userId" DataSourceID="dsUsers" 
    ForeColor="#333333" GridLines="None" CssClass="gridview" 
    AllowPaging="True" AllowSorting="True" Width="100%">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:BoundField DataField="userId" HeaderText="userId" InsertVisible="False" 
            ReadOnly="True" SortExpression="userId" Visible="False" />
        <asp:TemplateField HeaderText="Usuario" SortExpression="userName" 
            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
            <EditItemTemplate>
                <asp:TextBox ID="txtUserName" runat="server" Text='<%# Bind("userName") %>' Width="100%" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("userName") %>'></asp:Label>
            </ItemTemplate>
               <FooterTemplate>
                <asp:TextBox ID="txtUserName" runat="server" Text="" Width="100%" cssclass="textbox" Font-Size="9" ></asp:TextBox>
            </FooterTemplate>

<HeaderStyle HorizontalAlign="Left"></HeaderStyle>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
        </asp:TemplateField>
         
        <asp:TemplateField HeaderText="Nombre" SortExpression="userFirstName">
            <EditItemTemplate>
                <asp:TextBox ID="txtUserFirstName" runat="server" Text='<%# Bind("userFirstName") %>' 
                    Width="100%" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("userFirstName") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
            <asp:TextBox ID="txtUserFirstName" runat="server" 
                    Width="100%" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Apellido" SortExpression="userLastName">
            <EditItemTemplate>
                <asp:TextBox ID="txtUserLastname" runat="server" Text='<%# Bind("userLastName") %>' 
                    Width="100%" cssclass="textbox" Font-Size="9" ></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("userLastName") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
            <asp:TextBox ID="txtUserLastname" runat="server"  
                   Width="100%" cssclass="textbox" Font-Size="9" ></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Language" SortExpression="userLang" 
            Visible="False">
            <EditItemTemplate>
                <asp:DropDownList ID="ddlUserLang" runat="server" selectedValue='<%# Eval("userLang").toString.Trim %>' Width="100%" cssclass="textbox" Font-Size="9" style="padding:1px">
                    <asp:ListItem Value="esp" >Español</asp:ListItem>
                    <asp:ListItem Value="eng" >English</asp:ListItem>
                </asp:DropDownList>
                
            </EditItemTemplate>
            <ItemTemplate> 
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("dspLang") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:DropDownList ID="ddlUserLang" runat="server" Width="100%" cssclass="textbox" Font-Size="9" style="padding:1px">
                    <asp:ListItem Value="esp" >Español</asp:ListItem>
                    <asp:ListItem Value="eng" >English</asp:ListItem>
                </asp:DropDownList>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="No. Emp" SortExpression="userEmployeeNo">
            <EditItemTemplate>
                <asp:TextBox ID="txtUserEmployeeNo" runat="server" Text='<%# Bind("userEmployeeNo") %>' 
                    Width="50" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("userEmployeeNo") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:TextBox ID="txtUserEmployeeNo" runat="server" 
                    Width="50" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Depto" SortExpression="userDept">
            <EditItemTemplate>
                <asp:DropDownList ID="ddlUserDept" runat="server" DataSourceID="dsDepts" 
                    DataTextField="deptoName" DataValueField="deptoID" 
                    SelectedValue='<%# Bind("userDept") %>' CssClass="textbox" Font-Size="9" style="padding:1px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsDepts" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:COOPER_IntranetConnectionString.ProviderName %>" 
                    
                    SelectCommand="SELECT 0 AS deptoID, '[Select]' AS deptoName UNION SELECT deptoID, deptoName FROM tblDeptos ORDER BY deptoName">
                </asp:SqlDataSource>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Eval("deptoName") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:DropDownList ID="ddlUserDept" runat="server" DataSourceID="dsDepts" 
                    DataTextField="deptoName" DataValueField="deptoID" CssClass="textbox" Font-Size="9" style="padding:1px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="dsDepts" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:COOPER_IntranetConnectionString.ProviderName %>" 
                    
                    SelectCommand="SELECT deptoID, deptoName FROM tblDeptos ORDER BY deptoName">
                </asp:SqlDataSource>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Area" SortExpression="userArea" Visible="False">
            <EditItemTemplate>
                <asp:TextBox ID="txtUserArea" runat="server" Text='<%# Bind("userArea") %>' 
                    Width="50" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Bind("userArea") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
              <asp:TextBox ID="txtUserArea" runat="server" 
                    Width="50" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Sexo" SortExpression="userGender">
            <EditItemTemplate>
                 <asp:DropDownList ID="ddlUserGender" runat="server" SelectedValue='<%# isnull(Eval("userGender"),"M").ToString.Trim %>' Width="100%" cssclass="textbox" Font-Size="9" style="padding:1px">
                    <asp:ListItem Value="M" >M</asp:ListItem>
                    <asp:ListItem Value="F" >F</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label8" runat="server" Text='<%# Bind("userGender") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
             <asp:DropDownList ID="ddlUserGender" runat="server" Width="100%" cssclass="textbox" Font-Size="9" style="padding:1px">
                    <asp:ListItem Value="M" >M</asp:ListItem>
                    <asp:ListItem Value="F" >F</asp:ListItem>
                </asp:DropDownList>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Dirección de correo" 
            SortExpression="userEMailAddress">
            <EditItemTemplate>
                <asp:TextBox ID="txtUserEmailAddress" runat="server" 
                    Text='<%# Bind("userEMailAddress") %>' Width="100%" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label9" runat="server" Text='<%# Bind("userEMailAddress") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                            <asp:TextBox ID="txtUserEmailAddress" runat="server" 
                   Width="100%" cssclass="textbox" Font-Size="9"></asp:TextBox>
            </FooterTemplate>
            <HeaderStyle HorizontalAlign="Left" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Adm" SortExpression="userIsAdmin">
            <EditItemTemplate>
             <asp:CheckBox ID="chkIsAdmin" runat="server" 
                    Checked='<%# isnull(Eval("userIsAdmin"),0) %>' AutoPostBack="True"  OnCheckedChanged="showHidePrivs" ToolTip="Intranet Administrator" />
                <asp:ImageButton ID="imbPrivs" runat="server" ImageUrl="~/images/Icons/16X16/options.png" OnClick="Privs" CommandArgument='<%# Bind("userID") %>' Visible='<%# not isnull(Eval("userIsAdmin"),0) %>' />
               
            </EditItemTemplate>
            <ItemTemplate>
                <asp:CheckBox ID="chkIsAdmin" runat="server" 
                    Checked='<%# isnull(Eval("userIsAdmin"),0) %>' Enabled="false" ToolTip="Intranet Administrator" />
            </ItemTemplate>
            <FooterTemplate>
             <asp:CheckBox ID="chkUserIsAdmin" runat="server" 
                    />
            </FooterTemplate>
            <ItemStyle Wrap="False" />
        </asp:TemplateField>
        <asp:TemplateField>
        <ItemTemplate>
        <asp:ImageButton ID="imbEdit" runat="server" ImageUrl="~/images/Icons/16X16/edit.png" CommandName="Edit"  />
        <asp:ImageButton ID="imbDelete" runat="server" ImageUrl="~/images/Icons/16X16/delete.png" CommandArgument='<%# Bind("userID") %>' OnClientClick="return confirm('¿Está seguro de eliminar este registro?');" OnClick="Delete" />
        </ItemTemplate>
        <EditItemTemplate>
         <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Update" CommandArgument='<%# Bind("userID") %>' />
        <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/images/Icons/16X16/cancel.png"  CommandName="Cancel" />
        </EditItemTemplate>
        <HeaderTemplate>
        
        <asp:ImageButton ID="imbAdd" runat="server" ImageUrl="~/images/Icons/16X16/add.png" OnClick="enableAdd" />
        </HeaderTemplate>
        <FooterTemplate>
          <asp:ImageButton ID="imbOK" runat="server" ImageUrl="~/images/Icons/16X16/apply.png" OnClick="Insert" />
        <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/images/Icons/16X16/cancel.png" OnClick="Cancel" />
        </FooterTemplate>
            <FooterStyle HorizontalAlign="Right" />
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
<asp:SqlDataSource ID="dsUsers" runat="server" 
    ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
    
        
        
        SelectCommand="SELECT tblUsers.userId, tblUsers.userName, tblUsers.userFirstName, tblUsers.userLastName, tblUsers.userLang, tblUsers.userEmployeeNo, ISNULL(tblDeptos.deptoID, 0) AS userDept, tblUsers.userArea, tblUsers.userBirthDate, tblUsers.userGender, tblUsers.userPassword, tblUsers.userEMailAddress, tblUsers.userIsAdmin, CASE WHEN userLang = 'esp' THEN 'Español' ELSE 'English' END AS dspLang, tblDeptos.deptoName, tblUsers.userDeleted, tblUsers.userTest FROM tblUsers LEFT OUTER JOIN tblDeptos ON tblUsers.userDept = tblDeptos.deptoID WHERE (tblUsers.userId &gt; 1) ORDER BY tblUsers.userName" >
 
</asp:SqlDataSource>

<uc1:adm_privs ID="adm_Privs1" runat="server" />

</asp:Content>
