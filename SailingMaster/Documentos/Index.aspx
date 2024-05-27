<%@ Page Title="Documentos | SailingMaster" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SailingMaster.Documentos.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
.dxgvHeader_Material {
    padding: inherit;
    background: #102140;
    border: 0;
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
                <asp:LinkButton ID="BTN_AgregarDocumento" runat="server" Text="Nuevo" CssClass="btn btn-info btn-new d-flex align-items-center" OnClick="BTN_AgregarDocumento_Click">
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
                    <dx:GridViewDataTextColumn FieldName="co_mone" VisibleIndex="1" Caption="Moneda">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="total" VisibleIndex="2" Caption="Total">
                        <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="doc_status" VisibleIndex="3" Caption="Status">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="fecha" VisibleIndex="4" Caption="Fec. Generacion">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="approved_date" VisibleIndex="5" Caption="Fec. Aprobacion">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="collected_date" VisibleIndex="6" Caption="Fec. Cobro">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="liquidated_date" VisibleIndex="7" Caption="Fec. Liquidacion">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="closed_date" VisibleIndex="8" Caption="Fec. Cerrada">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataColumn Width="110px" VisibleIndex="9" Caption="Revisar">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_RevisarDocumento" runat="server" CssClass="btn btn-primary" CommandName="Revisar">
                                <i class="fas fa-search" style="margin-right: 5px;"></i>
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <%--<dx:GridViewDataColumn Width="110px" VisibleIndex="10" Caption="Eliminar">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_EliminarDocumento" runat="server" CssClass="btn btn-danger" CommandName="Eliminar">
                                <i class="fas fa-times" style="margin-right: 5px;"></i> Eliminar
                            </asp:LinkButton>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>--%>
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
                                Cliente: <dx:ASPxLabel runat="server" Text='<%# Eval("cliente") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
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
                                Generado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("co_us_in") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                            </div>
                            <div class="col">
                                Aprobado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("approved_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Revisado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("reviewed_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Observacion: <dx:ASPxLabel runat="server" Text='<%# Eval("reviewed_observ") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Liquidado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("liquidated_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Cerrado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("closed_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                            </div>
                            <div class="col">
                                ¿Cobrado?: <dx:ASPxLabel runat="server" Text='<%# Convert.ToInt32(Eval("status")) >= 3 ? "SI" : "NO" %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Cobrado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Monto Recibido: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_amount") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Fec. Transferencia: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_date_transf") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Nro. Referencia: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_nref_transf") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                            </div>
                            <div class="col">
                                <asp:LinkButton ID="BTN_CobrarDocumento" runat="server" CssClass="btn btn-primary" Width="100px" CommandName="Cobrar">
                                    <i class="fa-solid fa-hand-holding-dollar" style="margin-right: 5px;"></i> Cobrar
                                </asp:LinkButton>
                            </div>
                            <%--<div class="col buttons-actions">
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
                            </div>--%>
                        </div>
                    </DetailRow>
                </Templates>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="DS_Documento" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="select ID, cuenta_buq, fecha, cliente, puerto, buque, nro_viaje, co_mone, tasa, fec_llegada, fec_salida, num_toneladas, total, approved_date, reviewed_date, collected_date, 
            liquidated_date, closed_date, co_us_in, approved_by, reviewed_by, reviewed_observ, collected_by, collected_amount, collected_date_transf, collected_nref_transf, liquidated_by, closed_by, status,
            case status
	            when 0 then 'GENERADO'
	            when 1 then 'APROBADO'
	            when 2 then 'REVISADO'
	            when 3 then 'COBRADO'
	            when 4 then 'LIQUIDADO'
	            when 5 then 'CERRADO'
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