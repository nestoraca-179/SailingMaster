﻿<%@ Page Title="Documento" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DocumentPage.aspx.cs" Inherits="SailingMaster.Documentos.DocumentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
.controls {
    display: flex;
}
.controls label {
    min-width: 130px;
}
form .row:not(.my-5) {
    margin-top: 3px;
}
.amounts {
    height: 100%;
    max-height: 220px;
    background: #242529;
    padding: 15px;
    border: solid 2px #2a2b2e;
    -webkit-box-shadow: -4px 4px 5px 0px rgb(38, 38, 38);
    -moz-box-shadow: -4px 4px 5px 0px rgb(38, 38, 38);
    box-shadow: -4px 4px 5px 0px rgb(38, 38, 38);
}
.amounts h5, .amounts h6 {
    margin-bottom: 10px;
}
#MainContent_DE_Fecha_I, #MainContent_DDL_Moneda_I,
#MainContent_DE_FechaLlegada_I, #MainContent_DE_FechaSalida_I, #MainContent_DE_FechaTransf_I, 
#MainContent_DE_Fecha_ETC, #MainContent_DDL_Moneda_ETC,
#MainContent_DE_FechaLlegada_ETC, #MainContent_DE_FechaSalida_ETC, #MainContent_DE_FechaTransf_ETC {
    color: #F0F0F0;
}
.buttons-actions {
    display: flex;
    justify-content: end;
    flex-wrap: wrap;
}
.btn-alert, .btn-alert:hover, .btn-alert:active, .btn-alert:focus {
    background: #DB7B15;
    border-color: #DB7B15;
    color: #F0F0F0;
}
.btn-alert:focus {
    outline: 0;
    box-shadow: 0 0 0 0.25rem rgba(253, 145, 49, .5);
}
.btn.btn-success.dxbDisabled_MetropolisBlue, .btn.btn-primary.dxbDisabled_MetropolisBlue {
    color: var(--bs-btn-hover-color);
    background-color: var(--bs-btn-hover-bg);
    border: 0;
}
</style>
<script>
    function endCallback(s, e) {
        $("#items").text(grid.GetVisibleRowsOnPage());

        var price_total = 0;
        for (var i = 0; i < grid.GetVisibleRowsOnPage(); i++) {
            var elem_parent = grid.GetRow(i).getElementsByTagName("td")[4];
            var elem_last = elem_parent.lastElementChild;
            var elem_f = elem_last ?? elem_parent;

            var r = parseFloat(elem_f.innerHTML.replaceAll(".", "").replaceAll(",", "."));
            price_total += r;
        }
        $("#total_doc").text(price_total.toLocaleString("es-ES", { minimumFractionDigits: 2, maximumFractionDigits: 2, useGrouping: true }));

        $("span").click(function () {
            if (this.innerHTML == "Eliminar") {
                setTimeout(function () {
                    if (grid.batchEditApi.HasChanges()) {
                        grid.UpdateEdit();
                    }
                }, 10)
            }
        });
    }
</script>
<asp:Panel ID="PN_Error" runat="server" Width="100%" CssClass="mt-2" Visible="false">
    <div class="alert alert-danger m-0">
        <dx:ASPxLabel ID="LBL_Error" runat="server" Width="100%" Font-Size="14px" CssClass="m-0"></dx:ASPxLabel>
    </div>
</asp:Panel>
<form id="Form1" runat="server" class="container">
    <asp:Panel ID="PN_ContainerForm" runat="server" CssClass="form-header">
        <div class="row mt-5">
            <div class="col d-flex">
                <asp:LinkButton ID="BTN_Volver" runat="server" CssClass="btn btn-primary d-flex align-items-center" OnClick="BTN_Volver_Click">
                    <i class="fas fa-arrow-left" style="margin-right: 5px;"></i> Regresar
                </asp:LinkButton>
                <dx:ASPxButton ID="BTN_Agregar" runat="server" CssClass="btn btn-success mx-2" Text="Agregar" ValidationGroup="Documento" OnClick="BTN_Agregar_Click" />
                <dx:ASPxButton ID="BTN_Guardar" runat="server" CssClass="btn btn-success mx-2" Text="Guardar" ValidationGroup="Documento" OnClick="BTN_Guardar_Click"  Visible="false" />
            </div>
            <div class="col">
                <dx:ASPxLabel ID="LBL_IDDocumento" runat="server" Text="Agregar Documento" Width="100%" Font-Size="24px" CssClass="title-screen text-center text-light"></dx:ASPxLabel>
            </div>
            <div class="col">
                <div class="controls">
                    <label>Fecha</label>
                    <dx:ASPxDateEdit ID="DE_Fecha" runat="server" Theme="Material" BackColor="#303030" Border-BorderColor="#303030" EditFormat="Date" Width="100%">
                        <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </div>
            </div>
        </div>
        <hr />
        <asp:Panel ID="PN_ButtonsActions" runat="server" Visible="false" CssClass="row mx-0 my-3">
            <div class="col d-flex">
                <h5 class="m-0 text-light">Status: <dx:ASPxLabel ID="LBL_Status" runat="server" Font-Bold="true" Font-Size="Large" CssClass="mx-3 my-0 text-light"></dx:ASPxLabel></h5>
            </div>
            <div class="col buttons-actions p-0">
                <asp:LinkButton ID="BTN_PreRevisarDocumento" runat="server" CssClass="btn btn-sm btn-warning mx-1" data-toggle="modal" data-target="#modalRevisar">
                    <i class="fas fa-search" style="margin-right: 5px;"></i> Revisar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_PreAprobarDocumento" runat="server" CssClass="btn btn-sm btn-success" data-toggle="modal" data-target="#modalAprobar">
                    <i class="fas fa-check" style="margin-right: 5px;"></i> Aprobar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_PreCobrarDocumento" runat="server" CssClass="btn btn-sm btn-primary mx-1" data-toggle="modal" data-target="#modalCobrar">
                    <i class="fa-solid fa-hand-holding-dollar" style="margin-right: 5px;"></i> Cobrar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_PreLiquidarDocumento" runat="server" CssClass="btn btn-sm btn-alert" data-toggle="modal" data-target="#modalLiquidar">
                    <i class="fas fa-file-invoice-dollar" style="margin-right: 5px;"></i> Liquidar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_PreCerrarDocumento" runat="server" CssClass="btn btn-sm btn-secondary mx-1" data-toggle="modal" data-target="#modalCerrar">
                    <i class="fas fa-times" style="margin-right: 5px;"></i> Cerrar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_PreEliminarDocumento" runat="server" CssClass="btn btn-sm btn-danger" data-toggle="modal" data-target="#modal-delete">
                    <i class="fas fa-trash" style="margin-right: 5px;"></i> Eliminar
                </asp:LinkButton>
            </div>
            <hr class="m-0 mt-3" />
        </asp:Panel>
        <div class="row">
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-12">
                        <div class="controls">
                            <label>Cuenta de Buque</label>
                            <dx:ASPxTextBox ID="TB_CuentaBuque" runat="server" Theme="Material" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" Width="100%" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="controls">
                            <label>Cliente</label>
                            <dx:ASPxTextBox ID="TB_Cliente" runat="server" Theme="Material" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" Width="100%" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Buque</label>
                            <dx:ASPxTextBox ID="TB_Buque" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Flag</label>
                            <dx:ASPxTextBox ID="TB_Flag" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Puerto</label>
                            <dx:ASPxTextBox ID="TB_Puerto" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Muelle</label>
                            <dx:ASPxTextBox ID="TB_Muelle" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Tiempo en muelle (Horas)</label>
                            <dx:ASPxTextBox ID="TB_Horas" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Int32" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Valor U.T</label>
                            <dx:ASPxTextBox ID="TB_ValorUT" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>L.O.A.</label>
                            <dx:ASPxTextBox ID="TB_LOA" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>G.R.T.</label>
                            <dx:ASPxTextBox ID="TB_GRT" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>N.R.T.</label>
                            <dx:ASPxTextBox ID="TB_NRT" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Int32" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>S.D.W.T.</label>
                            <dx:ASPxTextBox ID="TB_SDWT" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Int32" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Fecha Llegada</label>
                            <dx:ASPxDateEdit ID="DE_FechaLlegada" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" EditFormat="Date">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxDateEdit>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Fecha Salida</label>
                            <dx:ASPxDateEdit ID="DE_FechaSalida" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" EditFormat="Date">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxDateEdit>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Nro. Viaje</label>
                            <dx:ASPxTextBox ID="TB_Viaje" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Toneladas</label>
                            <dx:ASPxTextBox ID="TB_Toneladas" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None" ValueType="System.Decimal">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Tasa USD/BSD</label>
                            <dx:ASPxTextBox ID="TB_TasaUSD" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Tasa EUR/BSD</label>
                            <dx:ASPxTextBox ID="TB_TasaEUR" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Tasa PTR/BSD</label>
                            <dx:ASPxTextBox ID="TB_TasaPTR" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Tasa EUR/USD</label>
                            <dx:ASPxTextBox ID="TB_TasaEURUSD" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true">
                                <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="amounts">
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Items:</h6>
                        <h5 class="text-white" id="items" style="margin: 0 5px 10px 0;"></h5>
                    </div>
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Total Documento:</h6>
                        <div class="d-flex align-items-center">
                            <dx:ASPxLabel ID="LBL_SignoTD" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                            <h5 class="text-white" id="total_doc" style="margin: 0 5px 10px 0;"></h5>
                        </div>
                    </div>
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Total Monto Recibido:</h6>
                        <div class="d-flex align-items-center">
                            <dx:ASPxLabel ID="LBL_SignoTR" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                            <dx:ASPxLabel ID="LBL_TotalRecibido" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                        </div>
                    </div>
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Total Monto Cancelado:</h6>
                        <div class="d-flex align-items-center">
                            <dx:ASPxLabel ID="LBL_SignoTC" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                            <dx:ASPxLabel ID="LBL_TotalCancelado" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                        </div>
                    </div>
                    <hr class="my-2 text-light" />
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Balance:</h6>
                        <div class="d-flex align-items-center">
                            <dx:ASPxLabel ID="LBL_SignoBC" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                            <dx:ASPxLabel ID="LBL_Balance" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col">
                <dx:ASPxGridView ID="GV_DocumentoReng" runat="server" Theme="Material" Width="100%" ClientInstanceName="grid" AutoGenerateColumns="False" KeyFieldName="reng_num"
                    OnRowInserting="GV_DocumentoReng_RowInserting" OnRowUpdating="GV_DocumentoReng_RowUpdating" OnRowDeleting="GV_DocumentoReng_RowDeleting" 
                    OnInitNewRow="GV_DocumentoReng_InitNewRow" OnHtmlRowPrepared="GV_DocumentoReng_HtmlRowPrepared" OnHtmlDataCellPrepared="GV_DocumentoReng_HtmlDataCellPrepared">
                    <ClientSideEvents EndCallback="endCallback" />
                    <SettingsPager PageSize="5"></SettingsPager>
                    <SettingsEditing Mode="Batch" NewItemRowPosition="Bottom">
                        <BatchEditSettings EditMode="Row" ShowConfirmOnLosingChanges="false" KeepChangesOnCallbacks="False" />
                    </SettingsEditing>
                    <Columns>
                        <dx:GridViewCommandColumn Width="100" ShowNewButtonInHeader="True" ShowEditButton="True" ShowDeleteButton="True" VisibleIndex="0">
                            <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                            <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                                <Paddings Padding="12px"></Paddings>
                            </CellStyle>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Width="50" FieldName="reng_num" Caption="Renglon" VisibleIndex="1" ReadOnly="True">
                            <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                            <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                                <Paddings Padding="12px"></Paddings>
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="co_serv" Caption="Codigo" VisibleIndex="2">
                            <PropertiesComboBox DataSourceID="DS_Servicio" ValueField="ID" TextField="descrip" TextFormatString="{0}">
                                <Columns>
                                    <dx:ListBoxColumn FieldName="ID" Caption="ID"></dx:ListBoxColumn>
                                    <dx:ListBoxColumn FieldName="descrip" Caption="Servicio" Width="250"></dx:ListBoxColumn>
                                </Columns>
                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" />
                            </PropertiesComboBox>
                            <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                            <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                                <Paddings Padding="12px"></Paddings>
                            </CellStyle>
                            <PropertiesComboBox DataSourceID="DS_Servicio" ValueType="System.String" ValueField="ID" TextField="ID" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn Width="550" FieldName="des_serv" Caption="Descripcion" VisibleIndex="3" ReadOnly="True">
                            <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                            <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                                <Paddings Padding="12px"></Paddings>
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="price_serv" Caption="Monto Presupuestado" VisibleIndex="4" ReadOnly="true">
                            <PropertiesTextEdit DisplayFormatString="{0:n}"></PropertiesTextEdit>
                            <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                            <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                                <Paddings Padding="12px"></Paddings>
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Monto Liquidado" VisibleIndex="5" ReadOnly="true">
                            <PropertiesTextEdit DisplayFormatString="{0:n}"></PropertiesTextEdit>
                            <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                            <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                                <Paddings Padding="12px"></Paddings>
                            </CellStyle>
                            <DataItemTemplate>
                                <span class="mx-1">0,00</span>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Subir Soporte" VisibleIndex="6" ReadOnly="true">
                            <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                            <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                                <Paddings Padding="12px"></Paddings>
                            </CellStyle>
                            <DataItemTemplate>
                                <dx:ASPxButton ID="BTN_AgregarSoporte" runat="server" CssClass="btn btn-primary p-1" ForeColor="#F0F0F0" Text="..." AutoPostBack="false" 
                                    data-toggle="modal" data-target="#modalAgregarSoporte"></dx:ASPxButton>
                            </DataItemTemplate>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <Settings ShowFooter="true" />
                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="price_serv" SummaryType="Sum" DisplayFormat="Total: {0:n}" />
                    </TotalSummary>
                </dx:ASPxGridView>
                <asp:SqlDataSource runat="server" ID="DS_Servicio" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [descrip] FROM [Servicio] ORDER BY [ID]"></asp:SqlDataSource>
            </div>
        </div>
    </asp:Panel>
    <br />
    <!-- MODAL APROBAR -->
    <div class="modal fade modal-warning" id="modalAprobar" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-warning"></i>
                    <dx:ASPxLabel ID="LBL_AprobarDocumento" runat="server" Font-Size="25px" Width="100%" Text="¿Deseas aprobar el documento?"></dx:ASPxLabel>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-danger" data-dismiss="modal">No</button>
                    <dx:ASPxButton ID="BTN_AprobarDocumento" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_AprobarDocumento_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL REVISAR -->
    <div class="modal fade" id="modalRevisar" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="m-0 text-light">Revisión</h5>
                </div>
                <div class="modal-body" style="text-align: left !important;">
                    <label class="text-light my-1">Observación</label>
                    <dx:ASPxMemo ID="MM_Observ" runat="server" Rows="5" Width="100%" CssClass="form-control" Theme="Material" BackColor="#303030" Border-BorderWidth="0" ForeColor="#F0F0F0" 
                        style="padding: 5px; border-radius: 5px; resize: none;">
                        <ValidationSettings Display="Dynamic" ValidationGroup="Revisar" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxMemo>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <dx:ASPxButton ID="BTN_RevisarDocumento" runat="server" Text="Guardar" CssClass="btn btn-primary" ValidationGroup="Revisar" OnClick="BTN_RevisarDocumento_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL COBRAR -->
    <div class="modal fade" id="modalCobrar" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="m-0 text-light">Registrar Cobro</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Monto Transf.</label>
                                <dx:ASPxTextBox ID="TB_MontoTransf" runat="server" Width="100%" CssClass="form-control" Theme="Material" BackColor="#303030" Border-BorderWidth="0" ForeColor="#F0F0F0">
                                    <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                    <ValidationSettings Display="Dynamic" ValidationGroup="Cobrar" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Banco</label>
                                <dx:ASPxTextBox ID="TB_BancoTransf" runat="server" Width="100%" CssClass="form-control" Theme="Material" BackColor="#303030" Border-BorderWidth="0" ForeColor="#F0F0F0">
                                    <ValidationSettings Display="Dynamic" ValidationGroup="Cobrar" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Fec. Transf.</label>
                                <dx:ASPxDateEdit ID="DE_FechaTransf" runat="server" Width="100%" CssClass="form-control" EditFormat="Date" Theme="Material" BackColor="#303030" Border-BorderWidth="0">
                                    <ValidationSettings Display="Dynamic" ValidationGroup="Cobrar" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Ref. Transf.</label>
                                <dx:ASPxTextBox ID="TB_RefTransf" runat="server" Width="100%" CssClass="form-control" Theme="Material" BackColor="#303030" Border-BorderWidth="0" ForeColor="#F0F0F0">
                                    <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                    <ValidationSettings Display="Dynamic" ValidationGroup="Cobrar" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-group" style="text-align: left !important;">
                                <label class="my-2">Subir comprobante</label>
                                <asp:FileUpload ID="FU_CompTransf" runat="server" CssClass="form-control" Width="100%" BackColor="#303030" BorderWidth="0" ForeColor="#F0F0F0" accept=".pdf" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <dx:ASPxButton ID="BTN_CobrarDocumento" runat="server" Text="Guardar" CssClass="btn btn-primary" ValidationGroup="Cobrar" OnClick="BTN_CobrarDocumento_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL LIQUIDAR -->
    <div class="modal fade modal-warning" id="modalLiquidar" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-warning"></i>
                    <dx:ASPxLabel ID="LBL_LiquidarDocumento" runat="server" Font-Size="25px" Width="100%" Text="¿Deseas liquidar el documento?"></dx:ASPxLabel>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-danger" data-dismiss="modal">No</button>
                    <dx:ASPxButton ID="BTN_LiquidarDocumento" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_LiquidarDocumento_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL CERRAR -->
    <div class="modal fade modal-warning" id="modalCerrar" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-warning"></i>
                    <dx:ASPxLabel ID="LBL_CerrarDocumento" runat="server" Font-Size="25px" Width="100%" Text="¿Deseas cerrar el documento?"></dx:ASPxLabel>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-danger" data-dismiss="modal">No</button>
                    <dx:ASPxButton ID="BTN_CerrarDocumento" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_CerrarDocumento_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL DELETE -->
    <div class="modal fade" id="modal-delete" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-warning"></i>
                    <dx:ASPxLabel ID="LBL_EliminarDocumento" runat="server" Font-Size="25px" Width="100%" Text="¿Deseas eliminar el documento?"></dx:ASPxLabel>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-danger" data-dismiss="modal">No</button>
                    <dx:ASPxButton ID="BTN_EliminarDocumento" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_EliminarDocumento_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
    <!-- MODAL AGREGAR SOPORTE -->
    <div class="modal fade" id="modalAgregarSoporte" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="m-0 text-light">Subir Soporte de Pago</h5>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Monto Pagado</label>
                                <dx:ASPxTextBox ID="TB_MontoReng" runat="server" Width="100%" CssClass="form-control" BackColor="#303030" Border-BorderWidth="0" ForeColor="#F0F0F0">
                                    <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                </dx:ASPxTextBox>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Moneda</label>
                                <dx:ASPxComboBox ID="DDL_MonedaReng" runat="server" Theme="Material" CssClass="form-control" Width="100%" BackColor="#303030" Border-BorderWidth="0" 
                                    ValueField="ID" TextField="descrip" DataSourceID="DS_Moneda">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="ID" Width="70px" Caption="C&#243;digo"></dx:ListBoxColumn>
                                        <dx:ListBoxColumn FieldName="descrip" Width="160px" Caption="Descripci&#243;n"></dx:ListBoxColumn>
                                    </Columns>
                                </dx:ASPxComboBox>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Fecha</label>
                                <dx:ASPxDateEdit ID="DE_FechaReng" runat="server" Width="100%" CssClass="form-control" EditFormat="Date" Theme="Material" BackColor="#303030" Border-BorderWidth="0"></dx:ASPxDateEdit>
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group-h" style="text-align: left !important;">
                                <label class="my-1">Referencia</label>
                                <dx:ASPxTextBox ID="TB_RefReng" runat="server" Width="100%" CssClass="form-control" BackColor="#303030" Border-BorderWidth="0" ForeColor="#F0F0F0">
                                    <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                                </dx:ASPxTextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-group my-3" style="text-align: left !important;">
                                <label class="my-1">Subir Archivo</label>
                                <asp:FileUpload ID="FU_TransfReng" runat="server" CssClass="form-control" Width="100%" BackColor="#303030" BorderWidth="0" ForeColor="#F0F0F0" accept=".pdf" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button class="btn btn-primary">Guardar</button>
                </div>
            </div>
        </div>
    </div>
</form>
<script>
    $(document).ready(function () {
        $("#items").text(grid.GetVisibleRowsOnPage());

        var price_total = 0;
        for (var i = 0; i < grid.GetVisibleRowsOnPage(); i++) {
            var elem_parent = grid.GetRow(i).getElementsByTagName("td")[4];
            var elem_last = elem_parent.lastElementChild;
            var elem_f = elem_last ?? elem_parent;

            var r = parseFloat(elem_f.innerHTML.replaceAll(".", "").replaceAll(",", "."));
            price_total += r;
        }
        $("#total_doc").text(price_total.toLocaleString("es-ES", { minimumFractionDigits: 2, maximumFractionDigits: 2, useGrouping: true }));

        $("span").click(function () {
            if (this.innerHTML == "Eliminar") {
                setTimeout(function () {
                    if (grid.batchEditApi.HasChanges()) {
                        grid.UpdateEdit();
                    }
                }, 10)
            }
        });
    });

    window.onkeydown = function (e) {
        if (e.keyCode == 13) {
            e.preventDefault();

            setTimeout(function () {
                if (grid.batchEditApi.HasChanges()) {
                    grid.UpdateEdit();
                }
            }, 10);
        }
    }

    function onlyNumbers(_, e) {
        var event = e.htmlEvent || window.event;
        var key = event.keyCode || event.which;
        var regex = /[0-9.,]/;

        key = String.fromCharCode(key);

        if (!regex.test(key)) {
            event.returnValue = false;

            if (event.preventDefault)
                event.preventDefault();
        }
    }
</script>
</asp:Content>