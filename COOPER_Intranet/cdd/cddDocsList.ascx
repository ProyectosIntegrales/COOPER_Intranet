<%@ Control Language="VB" AutoEventWireup="false" CodeFile="cddDocsList.ascx.vb"
    Inherits="cdd_cddDocsList" %>
<%@ Register Src="cntrldocdetails.ascx" TagPrefix="uc" TagName="cntrlDocDetails" %>
<%@ Register Src="cddSelectArea.ascx" TagName="cddSelectArea" TagPrefix="uc1" %>
<%@ Register Src="cddSelectDocType.ascx" TagName="cddSelectDocType" TagPrefix="uc2" %>
<%@ Register Src="cddSelectLoad.ascx" TagName="cddSelectLoad" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register src="../app_controls/cntrlReports.ascx" tagname="cntrlReports" tagprefix="uc6" %>
<style type="text/css">
    .wm {color:Gray;}
</style>
<asp:Panel ID="pnlList" runat="server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td valign="top" style="padding-right: 10px;" rowspan="2">
            <uc1:cddSelectArea ID="cddSelectArea1" runat="server" />
            <asp:Panel ID="pnlSide" runat="server" Width="150px" style="padding-top:5px;">
            <div style="border-style: solid solid none solid; border-width: 1px; border-color: #C0C0C0; padding: 5px 2px 5px 2px; white-space: nowrap; background-color: #F0F0F0; height: 20px; vertical-align: middle;">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="textbox" Width="120px" 
                    Font-Size="8pt"></asp:TextBox>
                            <asp:TextBoxWatermarkExtender ID="txtSearch_TextBoxWatermarkExtender" 
                    runat="server" Enabled="True" TargetControlID="txtSearch" 
                    WatermarkText="Buscar" WatermarkCssClass="wm">
                </asp:TextBoxWatermarkExtender>
                            <asp:ImageButton ID="ImageButton2" runat="server" 
                    ImageUrl="~/images/Icons/16X16/file_find.png" ImageAlign="Middle" />
                            </div>
                
                <asp:Panel ID="pnlAdd" runat="server" Style="padding: 10px;" BackColor="Silver" Width="130px">
                    <asp:LinkButton ID="lnbAdd" runat="server" Text="<img src='../images/icons/16x16/add.png' border=0 align=middle > Cargar documento"></asp:LinkButton></asp:Panel>
                <asp:Panel ID="pnlBtnProceso" runat="server" Style="padding: 10px;" BackColor="Silver"
                    Width="130px">
                    <asp:LinkButton ID="lnbShow" runat="server" Text="<img src='../images/icons/16x16/ball_green.png' border=0 align=middle > Docs en proceso"></asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="pnlObsoletos" runat="server" Style="padding: 10px;" BackColor="Silver"
                    Width="130px">
                    <asp:LinkButton ID="lnbObsoletos" runat="server" Text="<img src='../images/icons/16x16/folder_green.png' border=0 align=middle > Docs obsoletos"></asp:LinkButton>
                   
                </asp:Panel>
            
                <uc6:cntrlReports ID="cntrlReports1" runat="server" 
                    Header="Reportes" ReportType="CDOCS" 
                    Visible="True" />
                    </asp:Panel>
                <asp:AlwaysVisibleControlExtender ID="pnlSide_AlwaysVisibleControlExtender" 
                    runat="server" Enabled="False" TargetControlID="pnlSide" 
                    VerticalSide="Bottom">
                </asp:AlwaysVisibleControlExtender>
            </td>
            <td valign="top" width="100%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td valign="top" width="100%" >
                            <uc2:cddSelectDocType ID="cddSelectDocType1" runat="server" />
                        </td>

                    </tr>
                </table>

                <asp:GridView ID="grvProduccion" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    BorderStyle="None" CellPadding="4" CssClass="gridview" DataKeyNames="documentId"
                    DataSourceID="dsDocs" ForeColor="#333333" GridLines="None" Width="100%" AllowPaging="True"
                    PageSize="15" PagerStyle-CssClass="pgr" Font-Size="8pt">
                    <Columns>
                        <asp:BoundField DataField="documentId" HeaderText="documentId" InsertVisible="False"
                            ReadOnly="True" SortExpression="documentId" Visible="False" />
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Documento" ItemStyle-HorizontalAlign="Left"
                            SortExpression="documentControlNo" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td valign="top" style="padding-right: 5px;">
                                            <asp:Image ID="imgDocumentType" runat="server" ImageAlign="Middle" ImageUrl='<%# "~/images/icons/files/" & getIcon(Eval("documentFinalFileType"), Eval("documentFileType")) & ".png" %>' />
                                        </td>
                                        <td nowrap="nowrap">
                                            <asp:HyperLink ID="hlkDocumentURL" runat="server" NavigateUrl='<%# Eval("documentFinalFileName") %>'
                                                Target="_blank" Text='<%# Eval("documentControlNo") %>'></asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="True" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rev" SortExpression="documentRev">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("documentRev") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Publicado" SortExpression="documentDate">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" 
                                    Text='<%# Bind("documentDate", "{0:d}") %>' ToolTip='<%# Bind("documentDate") %>'></asp:Label>
                            </ItemTemplate>
                        
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Descripción" SortExpression="documentDescription">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("documentDescription") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle VerticalAlign="Top" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="originator" HeaderText="Autor" SortExpression="originator">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField Visible="True" HeaderText="Aprob. por" >
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# CommaConcatenate(isnull(Eval("documentMgrApprName"),"") , isnull(Eval("documentMfgEngApprName"),"") , isnull(Eval("documentCalEngApprName"),"")) %>'></asp:Label>
                            </ItemTemplate>
                  
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            <ItemStyle HorizontalAlign="Left" Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="lblAuthor" runat="server" Text='<%# Bind("documentAuthor") %>' 
                                    Visible="false"></asp:Label>
                                <asp:ImageButton ID="imbEdit" runat="server" 
                                    CommandArgument='<%# Bind("documentID") %>' 
                                    ImageUrl="~/images/Icons/16X16/page_edit.png" OnClick="Modify" 
                                    Visible='<%# Session("editEnabled") %>' />
                                <asp:ImageButton ID="imbDelete" runat="server" 
                                    CommandArgument='<%# Bind("documentID") %>' 
                                    ImageUrl="~/images/Icons/16X16/page_delete.png" OnClick="Delete" 
                                    Visible="false" />
                            </ItemTemplate>
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Wrap="False" />
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <asp:Label ID="lblAdd1" runat="server" Text="No Documents Found in this area."></asp:Label>
                        <asp:Label ID="lblAdd2" runat="server" Text="No Documents Found in this area."></asp:Label>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle CssClass="gridviewHeader" Font-Bold="True" Font-Size="8pt" />
                    <PagerStyle CssClass="gridviewPager" BackColor="Silver" 
                        HorizontalAlign="Center" />
                    <RowStyle ForeColor="#333333" VerticalAlign="Top" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                </asp:GridView>
<asp:Panel ID="pnlBottom" runat="server" >
                                <asp:Panel ID="pnlObsoletosList" runat="server" BackColor="#E5E5E5" BorderColor="#999999"
                    BorderStyle="Dotted" BorderWidth="1px"  Visible="False">
                    <table width="100%" bgcolor="#999999" cellpadding="3" cellspacing="0" 
                                        style="font-weight: bold; font-size: 11px">
                        <tr>
                            <td>
                                Listado de documentos obsoletos:
                            </td>
                            <td align="right" valign="top">
                                <asp:ImageButton ID="imbHide0" runat="server" ImageUrl="~/images/Icons/16X16/delete.png" />
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="grvObsoletos" runat="server" AllowSorting="True"
                        BorderStyle="None" CellPadding="4" CssClass="gridview" DataKeyNames="documentId"
                        DataSourceID="dsDocsObsol" ForeColor="#333333" GridLines="None" Width="100%" 
                        AllowPaging="True" PageSize="5" AutoGenerateColumns="False" Font-Size="8pt">
                        <Columns>
                            <asp:BoundField DataField="documentId" HeaderText="documentId" InsertVisible="False"
                                ReadOnly="True" SortExpression="documentId" Visible="False" />
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Documento" ItemStyle-HorizontalAlign="Left"
                                SortExpression="documentControlNo" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Image ID="imgDocumentType1" runat="server" ImageAlign="Middle" ImageUrl='<%# "~/images/icons/files/" & getIcon(Eval("documentFinalFileType") , Eval("documentFileType")) & ".png" %>' />
                                    &nbsp;
                                    <asp:Hyperlink ID="hlkDocumentURL1" runat="server" Text='<%# Eval("documentControlNo") %>' NavigateUrl='<%# Eval("documentFinalFilename") %>' ></asp:Hyperlink>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rev" SortExpression="documentRev">
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("documentRev") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fecha Publicación" SortExpression="documentDate">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("documentDate") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Descripción" SortExpression="documentDescription">
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("documentDescription") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="documentAuthorName" HeaderText="Autor" SortExpression="documentAuthorName">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="documentObsolete1Name" HeaderText="Obsoleto por" 
                                SortExpression="documentObsolete1Name" >
                            <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Autorizado por" 
                                SortExpression="documentObsolete2Name">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" 
                                        Text='<%# Eval("documentObsolete2Name") & iif(isnull(Eval("documentObsolete3Name"),"") <> "" , "<br>" & Eval("documentObsolete3Name"), "") %>'></asp:Label>
                                </ItemTemplate>
                                
                            </asp:TemplateField>
                            <asp:BoundField DataField="documentObsolete4Name" HeaderText="Realizado por" 
                                SortExpression="documentObsolete4Name" >
                            <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imbDelete1" runat="server" CommandArgument='<%# Bind("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_delete.png" OnClick="DeleteObs" OnClientClick="return confirm('Estás seguro de eliminar definitivamente este documento? ');"
                                        ToolTip="Eliminar permanentemente" Visible="false" />
                                    <asp:ImageButton ID="imbReactivate" runat="server" CommandArgument='<%# Bind("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_apply.png" OnClick="Reactivate" ToolTip="Reactivar Documento"
                                        Visible='<%# mee.PrivLevel = 9 And Session("editEnabled") and 0 %>' />
                                </ItemTemplate>
                                <HeaderTemplate>
                                </HeaderTemplate>
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Wrap="False" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No existen registros
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle Font-Bold="True" BackColor="#999999" Font-Size="8pt" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" 
                            CssClass="gridviewPager" />
                        <RowStyle ForeColor="#333333" VerticalAlign="Top" />
                    </asp:GridView>
                    
                </asp:Panel>
                <asp:Panel ID="pnlProceso" runat="server" BackColor="#E5E5E5" BorderColor="#999999"
                    BorderStyle="Dotted" BorderWidth="1px" Width="100%" >
                    <table width="100%" cellpadding="3" cellspacing="0" bgcolor="#999999" 
                        style="font-weight: bold; font-size: 11px">
                        <tr>
                            <td >
                                
                                    Listado de documentos en proceso:
                            </td>
                            <td align="right" style="padding-right: 10px">
                                <asp:LinkButton ID="lnbVerPaginas" runat="server" Visible="False">Ver por páginas</asp:LinkButton>
                                <asp:LinkButton ID="lnbVerTodoProc" runat="server">Lista completa</asp:LinkButton>
                            </td>
                            <td align="right" valign="top">
                                <asp:ImageButton ID="imbHide" runat="server" ImageUrl="~/images/Icons/16X16/delete.png" />
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="grvProceso" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        BorderStyle="None" CellPadding="4" CssClass="gridview" DataKeyNames="documentId"
                        DataSourceID="dsDocsProc" ForeColor="#333333" GridLines="None" 
                        Width="100%" PageSize="5" Font-Size="8pt" AllowPaging="True">
                        <Columns>
                            <asp:BoundField DataField="documentId" HeaderText="documentId" InsertVisible="False"
                                ReadOnly="True" SortExpression="documentId" Visible="False" />
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Documento" ItemStyle-HorizontalAlign="Left"
                                SortExpression="documentControlNo" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Image ID="imgDocumentType0" runat="server" ImageAlign="Middle" ImageUrl='<%# "~/images/icons/files/" & getIcon(Eval("documentFinalFileType"), Eval("documentFileType")) & ".png" %>' />
                                    &nbsp;
                                    <asp:Label ID="hlkDocumentURL0" runat="server" Text='<%# Eval("documentControlNo") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rev" SortExpression="documentRev">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("documentRev") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fecha " SortExpression="documentDate">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("documentDate") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="True" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Descripción" SortExpression="documentDescription">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# left(Eval("documentDescription"),50) %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle VerticalAlign="Top" />
                            </asp:TemplateField>
                            <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Estado">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# ApprovalStatus(Eval("documentID")) %>' />
                                </ItemTemplate>
                                <HeaderStyle Font-Underline="False" HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="documentAuthorName" HeaderText="Autor" 
                                SortExpression="documentAuthorName">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="documentInitializerName" HeaderText="Rev. por:" 
                                SortExpression="documentInitializerName" ItemStyle-Wrap="False" HeaderStyle-Wrap="False">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                           <asp:TemplateField HeaderText="Apr. por" SortExpression="Authorizer">
                                <ItemTemplate>
                                    <asp:Label ID="lblAppr" runat="server" Text='<%# ApprovalNames(Eval("documentID")) %>' ></asp:Label>
                                </ItemTemplate>
                           
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                <ItemStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                <asp:ImageButton ID="imbTraining" runat="server" CommandArgument='<%# Eval("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_star.png" OnClick="Training" ToolTip="Aprobar por Entrenamiento"
                                        Visible='<%# Eval("documentAuthLevel") = 3 and Eval("Training") = 0 and (mee.PrivLevel = 7 or mee.Privlevel = 9) And Session("editEnabled") %>' />
                                <asp:ImageButton ID="imbObs1" runat="server" CommandArgument='<%# Eval("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_bapply.png" OnClick="ObsoletAuthorize" ToolTip="Autorizar Obsolescencia"
                                        Visible='<%# ObsoleteAuthorizeVisible(Eval("documentID")) %>' />
                                        <asp:ImageButton ID="imbObs2" runat="server" CommandArgument='<%# Eval("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_obs.png" OnClick="ObsoletDone" ToolTip="Realizar Obsolescencia"
                                        Visible='<%# ObsoleteDoneVisible(Eval("documentID")) %>' />
                                    <asp:ImageButton ID="imbEdit" runat="server" CommandArgument='<%# Eval("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_edit.png" OnClick="Edit" ToolTip="Modificar"
                                        Visible='<%# Eval("documentAuthLevel") >= -2 and Eval("documentAuthLevel") <= 0 and Eval("documentAuthor").Trim.toUpper = Session("myUsername").trim.toupper %>' />
                                    <asp:ImageButton ID="imbDelete0" runat="server" CommandArgument='<%# Bind("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_delete.png" OnClick="Delete" OnClientClick="return confirm('Estás seguro de eliminar este documento?');"
                                        ToolTip="Eliminar" Visible='<%# Eval("documentAuthLevel") >= -2 and Eval("documentAuthLevel") <= 0 and Eval("documentAuthor").trim.toupper = Session("myUsername").trim.toupper %>' />

                                    <asp:Image ID="imgMessage" runat="server"
                                        ImageUrl="~/images/Icons/16X16/page_error.png" ToolTip='<%# Bind("documentMessage") %>'
                                        Visible='<%# Eval("documentAuthLevel") = -1 OR Eval("documentAuthLevel") = -2 %>' />
                                    <asp:ImageButton ID="imbLock" runat="server" CommandArgument='<%# Bind("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_key.png" OnClick="Lock" ToolTip="Revisar el documento y enviar para aprobación."
                                        Visible='<%# hflPrivLevel.value = 9 and Eval("documentAuthLevel") = 0  And Session("editEnabled") %>' />
                                    <asp:ImageButton ID="imbAprove" runat="server" CommandArgument='<%# Bind("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_apply.png" OnClick="Aprove" ToolTip="Aprobar Documento"
                                        Visible='<%# hflPrivLevel.value = 3 and Eval("documentAuthLevel") = 1 and mee.PrivLevel > 0 And Session("editEnabled") and Session("myUsername").trim.toupper <> Isnull(Eval("documentMgrAppr"),"").trim.toupper and Session("myUsername").trim.toupper <> IsNull(Eval("documentMfgEngAppr"),"").trim.toupper and Session("myUsername").trim.toupper <> IsNull(Eval("documentCalEngAppr"),"").trim.toupper %>' />
                                    <asp:ImageButton ID="imbPublish" runat="server" CommandArgument='<%# Bind("documentID") %>'
                                        ImageUrl="~/images/Icons/16X16/page_go.png" OnClick="Publish" ToolTip="Publicar Documento"
                                        Visible='<%# hflPrivLevel.value >= 8 and Eval("documentAuthLevel") = 2  and mee.PrivLevel > 0 And Session("editEnabled") %>' />
                                </ItemTemplate>
                                <HeaderTemplate> 
                                </HeaderTemplate>
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Bottom" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Wrap="False" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle Font-Bold="True" BackColor="#999999" Font-Size="8pt" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" 
                            CssClass="gridviewPager" Width="10px" />

                        <RowStyle ForeColor="#333333" VerticalAlign="Top" />
                    </asp:GridView>
                </asp:Panel>
                 </asp:Panel>
                <asp:AlwaysVisibleControlExtender ID="pnlBottom_AlwaysVisibleControlExtender" 
                    runat="server" Enabled="True" HorizontalOffset="160" 
                    TargetControlID="pnlBottom" VerticalSide="Bottom">
                </asp:AlwaysVisibleControlExtender>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:HiddenField ID="hflAreaID" runat="server" Value="0" />
<asp:HiddenField ID="hflCeldaID" runat="server" Value="0" />
<asp:HiddenField ID="hflDeptID" runat="server" Value="0" />
<asp:HiddenField ID="hflDocType" runat="server" Value="0" />
<asp:HiddenField ID="hflPrivLevel" runat="server" />
<asp:SqlDataSource ID="dsDocs" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    
    
    
    SelectCommand="SELECT cdd.vDocuments.documentID, cdd.vDocuments.documentFileName, ISNULL(cdd.vDocuments.documentType, 0) AS documentType, cdd.vDocuments.documentFileType, cdd.vDocuments.documentDate, cdd.vDocuments.documentRev, cdd.vDocuments.documentAuthor, cdd.vDocuments.documentAuthLevel, cdd.vDocuments.documentRelease, cdd.vDocuments.documentReleaseDate, ISNULL(cdd.vDocuments.documentDeptoID, 0) AS documentDeptoID, ISNULL(cdd.vDocuments.documentAreaID, 0) AS documentAreaID, ISNULL(cdd.vDocuments.documentCeldaID, 0) AS documentCeldaID, CASE WHEN NOT tblUsers_1.userFirstName IS NULL THEN tblUsers_1.userFirstName + ' ' + tblUsers_1.userLastName ELSE documentAuthor END AS originator, cdd.vDocuments.documentFinalFilename, cdd.vDocuments.documentFinalFileType, cdd.vDocuments.documentControlNo, cdd.vDocuments.documentDescription, cdd.vDocuments.celdaMnemonic, cdd.vDocuments.areaMnemonic, cdd.vDocuments.deptoMnemonic, cdd.vDocuments.typeFolderName, cdd.vDocuments.documentType AS Expr1, cdd.vDocuments.documentDeptoID AS Expr2, cdd.vDocuments.documentAreaID AS Expr3, cdd.vDocuments.documentCeldaID AS Expr4, cdd.vDocuments.deptoManagerName, cdd.vDocuments.mgrApproval, cdd.vDocuments.mfgEngApproval, cdd.vDocuments.documentMfgEngApprName, cdd.vDocuments.documentMfgEngAppr, cdd.vDocuments.documentMgrAppr, cdd.vDocuments.documentMgrApprDate, cdd.vDocuments.deptoManagerNo, cdd.vDocuments.documentMfgEngApprDate, cdd.vDocuments.areaMfgEng, cdd.vDocuments.areaMfgEngName, cdd.vDocuments.calEngApproval, cdd.vDocuments.documentCalEngAppr, cdd.vDocuments.documentCalEngApprName, cdd.vDocuments.documentCalEngApprDate, cdd.vDocuments.areaCalEng, cdd.vDocuments.areaCalEngName, cdd.vDocuments.celdaName, cdd.vDocuments.areaName, cdd.vDocuments.deptoName, cdd.vDocuments.documentMgrApprName FROM cdd.vDocuments LEFT OUTER JOIN tblUsers AS tblUsers_1 ON cdd.vDocuments.documentAuthor = tblUsers_1.userName WHERE (cdd.vDocuments.documentAuthLevel = 3) AND (ISNULL(cdd.vDocuments.documentDeptoID, 0) = @documentDeptoID OR @documentDeptoID = 0) AND (ISNULL(cdd.vDocuments.documentAreaID, 0) = @documentAreaID OR @documentAreaID = 0) AND (ISNULL(cdd.vDocuments.documentCeldaID, 0) = @documentCeldaID OR @documentCeldaID = 0) AND (ISNULL(cdd.vDocuments.documentType, 0) = @documentType OR @documentType = 0) AND (cdd.vDocuments.documentDescription LIKE '%' + RTRIM(ISNULL(@search, '.')) + '%' OR ISNULL(@search, '.') = '.' OR cdd.vDocuments.documentControlNo LIKE '%' + RTRIM(ISNULL(@search, '.')) + '%') ORDER BY cdd.vDocuments.documentControlNo">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflDeptID" Name="documentDeptoID" PropertyName="Value"
            DefaultValue="0" />
        <asp:ControlParameter ControlID="hflAreaID" Name="documentAreaID" PropertyName="Value"
            DefaultValue="0" />
        <asp:ControlParameter ControlID="hflCeldaID" Name="documentCeldaId" PropertyName="Value" />
        <asp:ControlParameter ControlID="hflDocType" DefaultValue="0" Name="documentType"
            PropertyName="Value" />
        <asp:ControlParameter ControlID="txtSearch" DefaultValue="." Name="search" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="dsDocsProc" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    
    
    
    
    
    
    
    
    SelectCommand="cdd.spSelectDocumentsInProc" 
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflPrivLevel" Name="privLevel" PropertyName="Value"
            DefaultValue="" />
        <asp:ControlParameter ControlID="hflDeptID" Name="documentDeptoID" PropertyName="Value" />
        <asp:ControlParameter ControlID="hflAreaID" Name="documentAreaID" 
            PropertyName="Value" Type="Int32" />
        <asp:ControlParameter ControlID="hflCeldaID" Name="documentCeldaID" 
            PropertyName="Value" Type="Int32" />
        <asp:ControlParameter ControlID="hflDocType" Name="documentType" PropertyName="Value" />
        <asp:SessionParameter Name="username" SessionField="myUsername" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="dsDocsObsol" runat="server" ConnectionString="<%$ ConnectionStrings:COOPER_IntranetConnectionString %>"
    
    
    
    
    
    SelectCommand="SELECT documentID, documentControlNo, documentFileName, documentType, documentFileType, documentDescription, documentDate, documentRev, documentAuthor, documentAuthLevel, documentDeptoID, documentMessage, documentFinalFilename, documentFinalFileType, authLevelDescription, documentMgrAppr, documentMgrApprName, documentMfgEngAppr, documentMfgEngApprName, documentCalEngAppr, documentCalEngApprName, documentAuthorName, documentObsolete1Name, documentObsolete2Name, documentObsolete3Name, documentObsolete4Name FROM cdd.vDocuments WHERE (documentType = @documentType OR @documentType = 0) AND (@privLevel = 9) AND (documentDeptoID = @documentDeptoID OR @documentDeptoID = 0) AND (documentAuthLevel = - 100)">
    <SelectParameters>
        <asp:ControlParameter ControlID="hflDocType" Name="documentType" PropertyName="Value" />
        <asp:ControlParameter ControlID="hflPrivLevel" Name="privLevel" PropertyName="Value"
            DefaultValue="0" />
        <asp:ControlParameter ControlID="hflDeptID" Name="documentDeptoID" PropertyName="Value" />
    </SelectParameters>
</asp:SqlDataSource>

<uc:cntrlDocDetails ID="cntrlDocDetails1" runat="server" Visible="False" />
