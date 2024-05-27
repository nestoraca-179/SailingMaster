<%@ Page Title="Documentos | SailingMaster" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SailingMaster.Documentos.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
.dxgvHeader_Material {
    padding: inherit;
    background: #102140;
    border: 0;
}
.buttons-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}
.buttons-actions .btn {
    width: 40% !important;
}
.btn-approved, .btn-approved:hover, .btn-approved:active {
    background: #1f9547;
    border-color: #1f9547;
}
.btn-reviewed, .btn-reviewed:hover, .btn-reviewed:active {
    background: #61189D;
    border-color: #61189D;
}
.btn-liquidated, .btn-liquidated:hover, .btn-liquidated:active {
    background: #DB7B15;
    border-color: #DB7B15;
}
.btn-closed, .btn-closed:hover, .btn-closed:active {
    background: #34495E;
    border-color: #34495E;
}
</style>
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
                <asp:LinkButton ID="BTN_AgregarDocumento" runat="server" Text="Nuevo" CssClass="btn btn-info d-flex align-items-center" OnClick="BTN_AgregarDocumento_Click">
                    <i class="fas fa-plus mx-2"></i> Agregar Nuevo Documento
                </asp:LinkButton>
            </div>
            <div class="col">
                <h2 class="text-center text-light">Documentos</h2>
            </div>
            <div class="col"></div>
        </div>
        <hr />
        <div class="form-grid">
            <dx:ASPxGridView ID="GV_Documentos" runat="server" Theme="Material" Width="100%" AutoGenerateColumns="False" DataSourceID="DS_Documento" KeyFieldName="ID" 
                OnHtmlRowPrepared="GV_Documentos_HtmlRowPrepared" OnRowCommand="GV_Documentos_RowCommand">
                <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="cuenta_buq" ReadOnly="True" VisibleIndex="0" Caption="Cuenta de Buque">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="fecha" VisibleIndex="1" Caption="Fecha">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="cliente" VisibleIndex="2" Caption="Cliente">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="co_mone" VisibleIndex="3" Caption="Moneda">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="total" VisibleIndex="4" Caption="Total">
                        <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="doc_status" VisibleIndex="5" Caption="Status">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataColumn Width="110px" VisibleIndex="6" Caption="Editar">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_EditarDocumento" runat="server" CssClass="btn btn-primary" CommandName="Editar">
                                <i class="fas fa-pencil-alt" style="margin-right: 5px;"></i> Editar
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Width="110px" VisibleIndex="7" Caption="Eliminar">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_EliminarDocumento" runat="server" CssClass="btn btn-danger" CommandName="Eliminar">
                                <i class="fas fa-times" style="margin-right: 5px;"></i> Eliminar
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
                <Styles>
                    <DetailRow BackColor="#18181B"></DetailRow>
                    <DetailButton>
                        <Paddings Padding="5px" PaddingLeft="10px"></Paddings>
                    </DetailButton>
                    <SearchPanel BackColor="#464C53" Font-Size="10px">
                        <Paddings Padding="0px"></Paddings>
                    </SearchPanel>
                </Styles>
                <Templates>
                    <DetailRow>
                        <div class="row details-doc">
                            <div class="col">
                                Puerto: <dx:ASPxLabel runat="server" Text='<%# Eval("puerto") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Buque: <dx:ASPxLabel runat="server" Text='<%# Eval("buque") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Nro. Viaje: <dx:ASPxLabel runat="server" Text='<%# Eval("nro_viaje") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Nro. Toneladas: <dx:ASPxLabel runat="server" Text='<%# Eval("num_toneladas", "{0:N2}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                            </div>
                            <div class="col">
                                Moneda: <dx:ASPxLabel runat="server" Text='<%# Eval("co_mone", "{0:N2}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Tasa de Cambio: <dx:ASPxLabel runat="server" Text='<%# Eval("tasa") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Fecha Llegada: <dx:ASPxLabel runat="server" Text='<%# Eval("fec_llegada", "{0:dd/MM/yyyy}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Fecha Salida: <dx:ASPxLabel runat="server" Text='<%# Eval("fec_salida", "{0:dd/MM/yyyy}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                            </div>
                            <div class="col buttons-actions">
                                <asp:LinkButton ID="BTN_AprobarDocumento" runat="server" CssClass="btn btn-approved" CommandName="Aprobar">
                                    <i class="fas fa-check" style="margin-right: 5px;"></i> Aprobar
                                </asp:LinkButton>
                                <asp:LinkButton ID="BTN_RevisarDocumento" runat="server" CssClass="btn btn-reviewed" CommandName="Revisar">
                                    <i class="fas fa-search" style="margin-right: 5px;"></i> Revisar
                                </asp:LinkButton>
                                <asp:LinkButton ID="BTN_LiquidarDocumento" runat="server" CssClass="btn btn-liquidated" CommandName="Liquidar">
                                    <i class="fas fa-file-invoice-dollar" style="margin-right: 5px;"></i> Liquidar
                                </asp:LinkButton>
                                <asp:LinkButton ID="BTN_CerrarDocumento" runat="server" CssClass="btn btn-closed" CommandName="Cerrar">
                                    <i class="fas fa-times" style="margin-right: 5px;"></i> Cerrar
                                </asp:LinkButton>
                            </div>
                        </div>
                    </DetailRow>
                </Templates>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="DS_Documento" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="select ID, cuenta_buq, fecha, cliente, puerto, buque, nro_viaje, co_mone, tasa, fec_llegada, fec_salida, num_toneladas, total,
            case status
	            when 0 then 'GENERADO'
	            when 1 then 'APROBADO'
	            when 2 then 'REVISADO'
	            when 3 then 'LIQUIDADO'
	            when 4 then 'CERRADO'
            end as doc_status
            from Documento"></asp:SqlDataSource>
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
                    <dx:ASPxButton ID="BTN_EliminarDocumento" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_EliminarDocumento_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
</form>
</asp:Content>