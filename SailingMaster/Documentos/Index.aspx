<%@ Page Title="Documentos | SailingMaster" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SailingMaster.Documentos.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
.dxgvHeader_Material {
    padding: inherit;
    background: #102140;
    border: 0;
    font-size: 11px;
}
.dxgvTable_Material tr.dxgvDataRow_Material td {
    font-size: 11px;
}
</style>
<script>
    function openModalDelete() {
        setTimeout(function () { $("#modal-delete").modal("show"); }, 1);
    }
</script>
<form id="Form1" runat="server" class="container-fluid">
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
                OnHtmlRowPrepared="GV_Documentos_HtmlRowPrepared" OnHtmlDataCellPrepared="GV_Documentos_HtmlDataCellPrepared" OnRowCommand="GV_Documentos_RowCommand">
                <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="des_buque" ReadOnly="True" VisibleIndex="0" Caption="Buque" Width="150px">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="nro_viaje" VisibleIndex="1" Caption="Nro. Viaje">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="total" VisibleIndex="2" Caption="Total BSD">
                        <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px" HorizontalAlign="Left">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="total_usd" VisibleIndex="3" Caption="Total USD">
                        <PropertiesTextEdit DisplayFormatString="${0:N2}"></PropertiesTextEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px" HorizontalAlign="Left">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="doc_status" VisibleIndex="4" Caption="Status">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px" Font-Bold="true">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="fecha" VisibleIndex="5" Caption="Fec. Generacion">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm"></PropertiesDateEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="approved_date" VisibleIndex="6" Caption="Fec. Aprobacion">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm"></PropertiesDateEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="reviewed_date" VisibleIndex="7" Caption="Fec. Revision">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm"></PropertiesDateEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="corrected_date" VisibleIndex="8" Caption="Fec. Correccion">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm"></PropertiesDateEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="collected_date" VisibleIndex="9" Caption="Fec. Cobro">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm"></PropertiesDateEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="liquidated_date" VisibleIndex="10" Caption="Fec. Liquidacion">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm"></PropertiesDateEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="closed_date" VisibleIndex="11" Caption="Fec. Cerrada">
                        <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy HH:mm"></PropertiesDateEdit>
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataColumn VisibleIndex="12" Caption="Revisar">
                        <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                        <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                            <Paddings Padding="12px"></Paddings>
                        </CellStyle>
                        <DataItemTemplate>
                            <asp:LinkButton ID="BTN_RevisarDocumento" runat="server" CssClass="btn btn-primary" CommandName="Revisar">
                                <i class="fas fa-search"></i>
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
                                Cliente: <dx:ASPxLabel runat="server" Text='<%# Eval("des_cli") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Nro. Viaje: <dx:ASPxLabel runat="server" Text='<%# Eval("nro_viaje") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Buque: <dx:ASPxLabel runat="server" Text='<%# Eval("des_buque") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Flag: <dx:ASPxLabel runat="server" Text='<%# Eval("flag") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Puerto: <dx:ASPxLabel runat="server" Text='<%# Eval("co_puerto") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Muelle: <dx:ASPxLabel runat="server" Text='<%# Eval("muelle") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Horas: <dx:ASPxLabel runat="server" Text='<%# Eval("horas") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Fecha Llegada: <dx:ASPxLabel runat="server" Text='<%# Eval("fec_llegada", "{0:dd/MM/yyyy HH:mm}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Fecha Salida: <dx:ASPxLabel runat="server" Text='<%# Eval("fec_salida", "{0:dd/MM/yyyy HH:mm}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Generado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("co_us_in") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                            </div>
                            <div class="col">
                                Aprobado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("approved_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Revisado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("reviewed_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Ult. Observacion: <dx:ASPxLabel runat="server" Text='<%# Eval("reviewed_observ") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <hr class="w-75" />
                                Corregido Por: <dx:ASPxLabel runat="server" Text='<%# Eval("corrected_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <hr class="w-75" />
                                Liquidado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("liquidated_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Cerrado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("closed_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                            </div>
                            <div class="col">
                                ¿Cobrado?: <dx:ASPxLabel runat="server" Text='<%# Convert.ToInt32(Eval("status")) >= 4 ? "SI" : "NO" %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Cobrado Por: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_by") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Monto Recibido: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_amount", "{0:N2}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Banco Destino: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_bank") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Fec. Transferencia: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_date_transf", "{0:dd/MM/yyyy}") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                                <br />
                                Nro. Referencia: <dx:ASPxLabel runat="server" Text='<%# Eval("collected_nref_transf") %>' Font-Bold="true" ForeColor="#F0F0F0" />
                            </div>
                        </div>
                    </DetailRow>
                </Templates>
            </dx:ASPxGridView>
            <asp:SqlDataSource runat="server" ID="DS_Documento" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="select D.ID, D.fecha, 
            C.des_cli, D.nro_viaje, B.des_buque, D.flag, D.co_puerto, D.muelle, D.horas, D.fec_llegada, D.fec_salida, D.total, D.total_usd, D.approved_date, D.reviewed_date, 
            D.corrected_date, D.collected_date, D.liquidated_date, D.closed_date, D.co_us_in, D.approved_by, D.reviewed_by, D.reviewed_observ, D.corrected_by, D.collected_by, 
            D.collected_amount, D.collected_bank, D.collected_date_transf, D.collected_nref_transf, D.liquidated_by, D.closed_by, D.status,
            case D.status
                 when 0 then 'GENERADO'
                 when 1 then 'APROBADO'
                 when 2 then 'REVISADO'
                 when 3 then 'CORREGIDO'
                 when 4 then 'COBRADO'
                 when 5 then 'LIQUIDADO'
                 when 6 then 'CERRADO'
            end as doc_status
            from Documento D
            inner join Buque B on B.ID = D.co_buque
            inner join Cliente C on C.ID = D.co_cli
            order by D.fe_us_in desc"></asp:SqlDataSource>
        </div>
    </asp:Panel>
</form>
</asp:Content>