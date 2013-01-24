<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="cdd_adm_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../Styles.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="documentType" HeaderText="documentType" 
                    SortExpression="documentType" />
                <asp:TemplateField HeaderText="Final Filename" 
                    SortExpression="documentFinalFilename">
  
                    <ItemTemplate>
                        <asp:Hyperlink ID="Label1" runat="server" 
                            Text='<%# Bind("documentFinalFilename") %>' ></asp:Hyperlink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="EXT">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" 
                            ImageUrl='<%# "~/images/Icons/files/" & mid(Eval("documentFinalFileType"),1,3) & ".png" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PDF Name"><ItemTemplate>
                    <asp:Hyperlink ID="lblPDF" runat="server" Text="Label"></asp:Hyperlink></ItemTemplate>      </asp:TemplateField>
                <asp:TemplateField HeaderText="PDF Icon">
                
                <ItemTemplate>  <asp:Image ID="Image2" runat="server" 
                            ImageUrl="~/images/Icons/files/pdf.png" /></ItemTemplate></asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>" 
        
        
        SelectCommand="SELECT documentFinalFilename, documentFileName, documentType, documentFileType, documentFinalFileType FROM cdd.vDocuments WHERE (documentFinalFileType LIKE N'xls%') OR (documentFinalFileType LIKE N'ppt%') OR (documentFinalFileType LIKE N'doc%') OR (documentFinalFileType LIKE N'pub%')">
    </asp:SqlDataSource>
    </form>
</body>
</html>
