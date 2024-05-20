﻿<%@ Page Title="Agregar Proforma" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Agregar.aspx.cs" Inherits="SailingMaster.Proformas.Agregar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<asp:Panel ID="PN_Error" runat="server" Width="100%" CssClass="mt-2" Visible="false">
    <div class="alert alert-danger m-0">
        <dx:ASPxLabel ID="LBL_Error" runat="server" Width="100%" Font-Size="14px" CssClass="m-0"></dx:ASPxLabel>
    </div>
</asp:Panel>
<form id="Form1" runat="server" class="container">
    <asp:Panel ID="PN_ContainerForm" runat="server" CssClass="form-header">
        <div class="row my-5">
            <div class="col d-flex">
                <asp:LinkButton ID="BTN_Volver" runat="server" CssClass="btn btn-primary" OnClick="BTN_Volver_Click">
                    <i class="fas fa-arrow-left"></i> Regresar
                </asp:LinkButton>
                <dx:ASPxButton ID="BTN_Guardar" runat="server" CssClass="btn btn-success mx-2" Text="Guardar" ValidationGroup="Proforma" OnClick="BTN_Guardar_Click" />
            </div>
            <div class="col">
                <dx:ASPxLabel ID="LBL_IDUsuario" runat="server" Text="Agregar Proforma" Width="100%" Font-Size="24px" CssClass="title-screen text-center text-light"></dx:ASPxLabel>
            </div>
            <div class="col"></div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="controls">
                    <label>Nro. Proforma</label>
                    <dx:ASPxTextBox ID="TB_Code" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-4">
                <div class="controls">
                    <label>Cliente</label>
                    <dx:ASPxTextBox ID="TB_Client" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-4">
                <div class="controls">
                    <div class="controls">
                    <label>Fecha</label>
                    <dx:ASPxDateEdit ID="DE_Date" runat="server" Theme="Material" EditFormat="Date" Width="100%">
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxDateEdit>
                </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="controls">
                    <label>Puerto</label>
                    <dx:ASPxTextBox ID="TB_Port" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-4">
                <div class="controls">
                    <label>Buque</label>
                    <dx:ASPxTextBox ID="TB_Vessel" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-4">
                <div class="controls">
                    <label>Nro. Viaje</label>
                    <dx:ASPxTextBox ID="TB_Voyage" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="controls">
                    <label>Moneda</label>
                    <dx:ASPxComboBox ID="DDL_Moneda" runat="server" Theme="Material" Width="100%" ValueField="ID" TextField="descrip" DataSourceID="DS_Moneda">
                        <Columns>
                            <dx:ListBoxColumn FieldName="ID" Width="40px" Caption="C&#243;digo"></dx:ListBoxColumn>
                            <dx:ListBoxColumn FieldName="descrip" Caption="Descripci&#243;n"></dx:ListBoxColumn>
                        </Columns>
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource runat="server" ID="DS_Moneda" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [descrip] FROM [Moneda]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="col-md-4">
                <div class="controls">
                    <label>Tasa de Cambio</label>
                    <dx:ASPxTextBox ID="TB_Rate" runat="server" Theme="Material" Width="100%" AutoCompleteType="None" ValueType="System.Decimal">
                        <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-4">
                <div class="controls">
                    <label>Toneladas Manejadas</label>
                    <dx:ASPxTextBox ID="TB_Tons" runat="server" Theme="Material" Width="100%" AutoCompleteType="None" ValueType="System.Decimal">
                        <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                        <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="controls">
                    <div class="controls">
                        <label>Fecha Llegada</label>
                        <dx:ASPxDateEdit ID="DE_DateArrived" runat="server" Theme="Material" EditFormat="Date" Width="100%">
                            <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                            </ValidationSettings>
                        </dx:ASPxDateEdit>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="controls">
                    <div class="controls">
                        <label>Fecha Salida</label>
                        <dx:ASPxDateEdit ID="DE_DateSailed" runat="server" Theme="Material" EditFormat="Date" Width="100%">
                            <ValidationSettings ValidationGroup="Proforma" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                                <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                            </ValidationSettings>
                        </dx:ASPxDateEdit>
                    </div>
                </div>
            </div>
        </div>
        <hr />
        <div class="row">
            <div class="col">
                <dx:ASPxGridView ID="GV_ProformaReng" runat="server" Theme="Material" Width="100%" ClientInstanceName="grid" AutoGenerateColumns="False" KeyFieldName="reng_num"
                OnRowInserting="GV_ProformaReng_RowInserting" OnRowUpdating="GV_ProformaReng_RowUpdating"
                OnRowDeleting="GV_ProformaReng_RowDeleting" OnInitNewRow="GV_ProformaReng_InitNewRow">
                    <SettingsEditing Mode="Batch" NewItemRowPosition="Bottom">
                        <BatchEditSettings EditMode="Row" ShowConfirmOnLosingChanges="false" KeepChangesOnCallbacks="False" />
                    </SettingsEditing>
                    <Columns>
                        <dx:GridViewCommandColumn Width="100" ShowNewButtonInHeader="True" ShowEditButton="True" ShowDeleteButton="True" VisibleIndex="0">
                            <HeaderStyle BackColor="#191c24" ForeColor="#F0F0F0"></HeaderStyle>
                            <CellStyle BackColor="#17181C" ForeColor="#F0F0F0" Border-BorderColor="#3E4753"></CellStyle>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="reng_num" Caption="Renglon" VisibleIndex="1" ReadOnly="True">
                            <HeaderStyle BackColor="#191c24" ForeColor="#F0F0F0"></HeaderStyle>
                            <CellStyle BackColor="#17181C" ForeColor="#F0F0F0" Border-BorderColor="#3E4753"></CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn FieldName="co_serv" Caption="Codigo" VisibleIndex="2">
                            <PropertiesComboBox DataSourceID="DS_Servicio" ValueField="ID" TextField="descrip" TextFormatString="{0}">
                                <Columns>
                                    <dx:ListBoxColumn FieldName="ID" Caption="ID"></dx:ListBoxColumn>
                                    <dx:ListBoxColumn FieldName="descrip" Caption="Servicio" Width="250"></dx:ListBoxColumn>
                                </Columns>
                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" />
                            </PropertiesComboBox>
                            <HeaderStyle BackColor="#191c24" ForeColor="#F0F0F0"></HeaderStyle>
                            <CellStyle BackColor="#17181C" ForeColor="#F0F0F0" Border-BorderColor="#3E4753"></CellStyle>
                            <PropertiesComboBox DataSourceID="DS_Servicio" ValueType="System.String" ValueField="ID" TextField="ID" />
                        </dx:GridViewDataComboBoxColumn>
                        <dx:GridViewDataTextColumn Width="600" FieldName="des_serv" Caption="Descripcion" VisibleIndex="3" ReadOnly="True">
                            <HeaderStyle BackColor="#191c24" ForeColor="#F0F0F0"></HeaderStyle>
                            <CellStyle BackColor="#17181C" ForeColor="#F0F0F0" Border-BorderColor="#3E4753"></CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="price_serv" Caption="Precio" VisibleIndex="4">
                            <PropertiesTextEdit>
                                <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" />
                            </PropertiesTextEdit>
                            <PropertiesTextEdit DisplayFormatString="{0:n}"></PropertiesTextEdit>
                            <HeaderStyle BackColor="#191c24" ForeColor="#F0F0F0"></HeaderStyle>
                            <CellStyle BackColor="#17181C" ForeColor="#F0F0F0" Border-BorderColor="#3E4753"></CellStyle>
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource runat="server" ID="DS_Servicio" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [descrip] FROM [Servicio] ORDER BY [ID]"></asp:SqlDataSource>
            </div>
        </div>
    </asp:Panel>
    <br />
</form>
<script>
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
</script>
</asp:Content>