<%@ Page Title="Agregar Documento" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Agregar.aspx.cs" Inherits="SailingMaster.Documentos.Agregar" %>

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
#MainContent_DE_Date_I, #MainContent_DDL_Moneda_I,
#MainContent_DE_DateArrived_I, #MainContent_DE_DateSailed_I,
#MainContent_DE_Date_ETC, #MainContent_DDL_Moneda_ETC,
#MainContent_DE_DateArrived_ETC, #MainContent_DE_DateSailed_ETC {
    color: #F0F0F0;
}
.buttons-actions {
    display: flex;
    justify-content: end;
    /*align-items: center;*/
    flex-wrap: wrap;
}
.buttons-actions .btn {
    
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
                <dx:ASPxButton ID="BTN_Guardar" runat="server" CssClass="btn btn-success mx-2" Text="Guardar" ValidationGroup="Documento" OnClick="BTN_Guardar_Click" />
            </div>
            <div class="col">
                <dx:ASPxLabel ID="LBL_IDDocumento" runat="server" Text="Agregar Documento" Width="100%" Font-Size="24px" CssClass="title-screen text-center text-light"></dx:ASPxLabel>
            </div>
            <div class="col">
                <div class="controls">
                    <label>Fecha</label>
                    <dx:ASPxDateEdit ID="DE_Date" runat="server" Theme="Material" BackColor="#303030" Border-BorderColor="#303030" EditFormat="Date" Width="100%">
                        <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </div>
            </div>
        </div>
        <hr />
        <asp:Panel ID="PN_ButtonsActions" runat="server" Visible="false" CssClass="row mx-0 my-3">
            <div class="col buttons-actions p-0">
                <asp:LinkButton ID="BTN_PreAprobarDocumento" runat="server" CssClass="btn btn-info mx-1" data-toggle="modal" data-target="#modalAprobar">
                    <i class="fas fa-check" style="margin-right: 5px;"></i> Aprobar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_RevisarDocumento" runat="server" CssClass="btn btn-warning" CommandName="Revisar">
                    <i class="fas fa-search" style="margin-right: 5px;"></i> Revisar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_LiquidarDocumento" runat="server" CssClass="btn btn-danger mx-1" CommandName="Liquidar">
                    <i class="fas fa-file-invoice-dollar" style="margin-right: 5px;"></i> Liquidar
                </asp:LinkButton>
                <asp:LinkButton ID="BTN_CerrarDocumento" runat="server" CssClass="btn btn-dark" CommandName="Cerrar">
                    <i class="fas fa-times" style="margin-right: 5px;"></i> Cerrar
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
                            <dx:ASPxTextBox ID="TB_Code" runat="server" Theme="Material" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" Width="100%" AutoCompleteType="None">
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
                            <dx:ASPxTextBox ID="TB_Client" runat="server" Theme="Material" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" Width="100%" AutoCompleteType="None">
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
                            <label>Moneda</label>
                            <dx:ASPxComboBox ID="DDL_Moneda" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" 
                                ValueField="ID" TextField="descrip" DataSourceID="DS_Moneda" AutoPostBack="true" OnSelectedIndexChanged="DDL_Moneda_SelectedIndexChanged">
                                <Columns>
                                    <dx:ListBoxColumn FieldName="ID" Width="70px" Caption="C&#243;digo"></dx:ListBoxColumn>
                                    <dx:ListBoxColumn FieldName="descrip" Width="160px" Caption="Descripci&#243;n"></dx:ListBoxColumn>
                                </Columns>
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxComboBox>
                            <asp:SqlDataSource runat="server" ID="DS_Moneda" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [descrip] FROM [Moneda]"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Tasa de Cambio</label>
                            <dx:ASPxTextBox ID="TB_Rate" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" 
                                AutoCompleteType="None" ValueType="System.Decimal" AutoPostBack="true" OnTextChanged="TB_Rate_TextChanged">
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
                            <dx:ASPxDateEdit ID="DE_DateArrived" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" EditFormat="Date">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxDateEdit>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Fecha Salida</label>
                            <dx:ASPxDateEdit ID="DE_DateSailed" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" EditFormat="Date">
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
                            <label>Puerto</label>
                            <dx:ASPxTextBox ID="TB_Port" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Buque</label>
                            <dx:ASPxTextBox ID="TB_Vessel" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
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
                            <label>Nro. Viaje</label>
                            <dx:ASPxTextBox ID="TB_Voyage" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                                <ValidationSettings Display="Dynamic" ValidationGroup="Documento" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                    <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="controls">
                            <label>Toneladas</label>
                            <dx:ASPxTextBox ID="TB_Tons" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None" ValueType="System.Decimal">
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
                            <dx:ASPxLabel ID="LBL_SignTD" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                            <h5 class="text-white" id="total_doc" style="margin: 0 5px 10px 0;"></h5>
                        </div>
                    </div>
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Total Monto Recibido:</h6>
                        <div class="d-flex align-items-center">
                            <dx:ASPxLabel ID="LBL_SignTR" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                            <dx:ASPxLabel ID="LBL_TotalReceived" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                        </div>
                    </div>
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Total Monto Cancelado:</h6>
                        <div class="d-flex align-items-center">
                            <dx:ASPxLabel ID="LBL_SignTC" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                            <dx:ASPxLabel ID="LBL_TotalCancelled" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
                        </div>
                    </div>
                    <hr class="my-2 text-light" />
                    <div class="w-100 d-flex justify-content-between">
                        <h6 class="text-white" style="font-weight: 100">Balance:</h6>
                        <div class="d-flex align-items-center">
                            <dx:ASPxLabel ID="LBL_SignBC" runat="server" CssClass="text-light" style="font-size: 1.25rem; margin: 0 5px 10px 0;"></dx:ASPxLabel>
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
                    OnInitNewRow="GV_DocumentoReng_InitNewRow" OnHtmlRowPrepared="GV_DocumentoReng_HtmlRowPrepared">
                    <ClientSideEvents EndCallback="endCallback" />
                    <SettingsPager PageSize="100" Visible="False"></SettingsPager>
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
    <!-- Modal Aprobar -->
    <div class="modal fade modal-warning" id="modalAprobar" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-warning"></i>
                    <dx:ASPxLabel ID="LBL_Delete" runat="server" Font-Size="25px" Width="100%" Text="¿Deseas aprobar el documento?"></dx:ASPxLabel>
                </div>
                <div class="modal-footer buttons">
                    <button class="btn btn-danger" data-dismiss="modal">No</button>
                    <dx:ASPxButton ID="BTN_AprobarDocumento" runat="server" Text="Sí" CssClass="btn btn-success"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Agregar -->
    <div class="modal fade modal-warning" id="modalAgregarSoporte" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="m-0">Agregar Soporte</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group" style="text-align: left !important;">
                        <label class="text-dark my-1">Monto</label>
                        <input type="text" class="form-control" name="name" />
                    </div>
                    <div class="form-group my-3" style="text-align: left !important;">
                        <label class="text-dark my-1">Fecha</label>
                        <input type="text" class="form-control" name="name" />
                    </div>
                    <div class="form-group" style="text-align: left !important;">
                        <label class="text-dark my-1">Referencia</label>
                        <input type="text" class="form-control" name="name" />
                    </div>
                    <div class="form-group my-3" style="text-align: left !important;">
                        <label class="text-dark my-1">Subir Archivo</label>
                        <input type="file" class="form-control" id="formFile" />
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