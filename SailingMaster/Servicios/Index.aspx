<%@ Page Title="Servicios | SailingMaster" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SailingMaster.Servicios.Index" %>

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
                <asp:LinkButton ID="BTN_AgregarServicio" runat="server" Text="Nuevo" CssClass="btn btn-info btn-new d-flex align-items-center" OnClick="BTN_AgregarServicio_Click">
                    <i class="fas fa-plus mx-2"></i> Agregar Nuevo Servicio
                </asp:LinkButton>
            </div>
            <div class="col">
                <h2 class="text-center text-light">Tarifario</h2>
            </div>
            <div class="col"></div>
        </div>
        <hr />
        <div class="form-grid">
            <dx:ASPxGridView ID="GV_Servicios" runat="server" Width="100%" Theme="Material" AutoGenerateColumns="False" DataSourceID="DS_Servicio" KeyFieldName="ID"
                EnableTheming="True" OnRowCommand="GV_Servicios_RowCommand" OnHtmlRowPrepared="GV_Servicios_HtmlRowPrepared">
                <SettingsDataSecurity AllowDelete="False" AllowInsert="False" AllowEdit="False"></SettingsDataSecurity>
                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Caption="Código">
                        <EditFormSettings Visible="False"></EditFormSettings>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="descrip" VisibleIndex="1" Caption="Descripción">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="precio_bsd" ReadOnly="True" VisibleIndex="2" UnboundType="Decimal" Caption="Precio BSD">
                        <PropertiesTextEdit DisplayFormatString="Bs. D {0:n}"></PropertiesTextEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="precio_usd" ReadOnly="True" VisibleIndex="3" UnboundType="Decimal" Caption="Precio USD">
                        <PropertiesTextEdit DisplayFormatString="${0:n}"></PropertiesTextEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="precio_eur" ReadOnly="True" VisibleIndex="4" UnboundType="Decimal" Caption="Precio EUR">
                        <PropertiesTextEdit DisplayFormatString="€{0:n}"></PropertiesTextEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataCheckColumn FieldName="activo" VisibleIndex="5" Caption="Activo">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataCheckColumn>
                    <dx:GridViewDataColumn Width="110px" VisibleIndex="7" Caption="Editar">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_EditarServicio" runat="server" CssClass="btn btn-primary" CommandName="Editar">
                                <i class="fas fa-edit"></i> Editar
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Width="110px" VisibleIndex="8" Caption="Eliminar" >
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_ConfirmarEliminarServicio" runat="server" CssClass="btn btn-danger" CommandName="Eliminar">
                                <i class="fas fa-times"></i> Eliminar
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
                <Styles>
                    <SearchPanel BackColor="#464C53"></SearchPanel>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="DS_Servicio" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT ID,
	               descrip,
	               cast(precio_base as decimal(18, 2)) as precio_bsd,
	               cast((precio_base / (select tasa from Moneda where ID = 'USD')) as decimal(18, 2)) as precio_usd,
	               cast((precio_base / (select tasa from Moneda where ID = 'EUR')) as decimal(18, 2)) as precio_eur,
	               activo
            FROM Servicio"></asp:SqlDataSource>
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
                    <dx:ASPxButton ID="BTN_EliminarServicio" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_EliminarServicio_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
</form>
</asp:Content>