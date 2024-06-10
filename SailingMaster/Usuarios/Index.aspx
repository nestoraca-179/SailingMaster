<%@ Page Title="Usuarios | SailingMaster" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SailingMaster.Usuarios.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script>
    function openModalDelete() {
        setTimeout(function () { $("#modal-delete").modal("show"); }, 1);
    }
</script>
<form id="Form1" runat="server" class="container">
    <asp:Panel ID="PN_Success" runat="server" Width="100%" CssClass="mt-2" Visible="false">
        <div class="alert alert-success m-0">
            <dx:ASPxLabel ID="LBL_Success" runat="server" Width="100%" Font-Size="14px" CssClass="m-0"></dx:ASPxLabel>
        </div>
    </asp:Panel>
    <asp:Panel ID="PN_Error" runat="server" Width="100%" CssClass="mt-2" Visible="false">
        <div class="alert alert-danger m-0">
            <dx:ASPxLabel ID="LBL_Error" runat="server" Width="100%" Font-Size="14px" CssClass="m-0"></dx:ASPxLabel>
        </div>
    </asp:Panel>
    <asp:Panel ID="PN_ContainerForm" runat="server">
        <div class="row my-3">
            <div class="col d-flex">
                <asp:LinkButton ID="BTN_AgregarUsuario" runat="server" Text="Nuevo" CssClass="btn btn-info btn-new d-flex align-items-center" OnClick="BTN_AgregarUsuario_Click">
                    <i class="fas fa-user-plus mx-2"></i> Agregar Nuevo Usuario
                </asp:LinkButton>
            </div>
            <div class="col">
                <h2 class="text-center text-light">Usuarios</h2>
            </div>
            <div class="col"></div>
        </div>
        <hr />
        <div class="form-grid">
            <dx:ASPxGridView ID="GV_Usuarios" runat="server" Width="100%" Theme="Material" AutoGenerateColumns="False" DataSourceID="DS_Usuario" KeyFieldName="ID" 
                EnableTheming="True" OnRowCommand="GV_Usuarios_RowCommand" OnHtmlRowPrepared="GV_Usuarios_HtmlRowPrepared">
                <SettingsDataSecurity AllowDelete="False" AllowInsert="False" AllowEdit="False"></SettingsDataSecurity>
                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1">
                        <EditFormSettings Visible="False"></EditFormSettings>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="username" Caption="Usuario" VisibleIndex="2">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="des_usuario" Caption="Nombre" VisibleIndex="3">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="email" Caption="Correo" VisibleIndex="4">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataCheckColumn FieldName="activo" Caption="Activo" VisibleIndex="5">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataCheckColumn>
                    <dx:GridViewDataTextColumn FieldName="tip_usuario" Caption="Tipo de Usuario" VisibleIndex="6">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataColumn Width="30px" VisibleIndex="7" Caption="Editar">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_EditarUsuario" runat="server" CssClass="btn btn-primary" CommandName="Editar">
                                <i class="fas fa-edit"></i>
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Width="30px" VisibleIndex="8" Caption="Eliminar" >
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_ConfirmarEliminarUsuario" runat="server" CssClass="btn btn-danger" CommandName="Eliminar">
                                <i class="fas fa-trash"></i>
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
                <Styles>
                    <SearchPanel BackColor="#464C53" Font-Size="10px">
                        <Paddings Padding="0px"></Paddings>
                    </SearchPanel>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="DS_Usuario" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [username], [des_usuario], [email], [activo], case [tip_usuario] 
            WHEN 0 THEN 'Administrador'
            WHEN 1 THEN 'Generador'
            WHEN 2 THEN 'Aprobador'
            WHEN 3 THEN 'Cobrador'
            WHEN 4 THEN 'Liquidador'
            WHEN 5 THEN 'Observador'
            END as tip_usuario
            FROM [Usuario]"></asp:SqlDataSource>
        </div>
    </asp:Panel>
    <!-- MODAL DELETE -->
    <div class="modal fade" id="modal-delete" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-warning"></i>
                    <dx:ASPxLabel ID="LBL_Delete" runat="server" Font-Size="25px" Width="100%"></dx:ASPxLabel>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-danger" data-dismiss="modal">No</button>
                    <dx:ASPxButton ID="BTN_EliminarUsuario" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_EliminarUsuario_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
</form>
</asp:Content>