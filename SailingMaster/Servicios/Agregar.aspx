<%@ Page Title="Agregar Servicio" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Agregar.aspx.cs" Inherits="SailingMaster.Servicios.Agregar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    #MainContent_DDL_Moneda_I, #MainContent_DDL_Moneda_ETC, 
    #MainContent_DDL_TipoServicio_I, #MainContent_DDL_TipoServicio_ETC {
        color: #F0F0F0;
    }
</style>
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
                <dx:ASPxButton ID="BTN_Guardar" runat="server" CssClass="btn btn-success mx-2" Text="Guardar" ValidationGroup="Servicio" OnClick="BTN_Guardar_Click" />
            </div>
            <div class="col">
                <dx:ASPxLabel ID="LBL_IDServicio" runat="server" Text="Agregar Servicio" Width="100%" Font-Size="24px" CssClass="title-screen text-center text-light"></dx:ASPxLabel>
            </div>
            <div class="col"></div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="controls">
                    <label>Código</label>
                    <dx:ASPxTextBox ID="TB_Code" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" ForeColor="#F0F0F0" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-9">
                <div class="controls">
                    <label>Descripción</label>
                    <dx:ASPxTextBox ID="TB_Descrip" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" ForeColor="#F0F0F0" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="controls">
                    <label>Tipo Servicio</label>
                    <dx:ASPxComboBox ID="DDL_TipoServicio" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" ValueField="ID" TextField="des_tipo" DataSourceID="DS_TipoServicio">
                        <Columns>
                            <dx:ListBoxColumn FieldName="ID" Width="40px" Caption="C&#243;digo"></dx:ListBoxColumn>
                            <dx:ListBoxColumn FieldName="des_tipo" Caption="Descripci&#243;n"></dx:ListBoxColumn>
                        </Columns>
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource runat="server" ID="DS_TipoServicio" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [des_tipo] FROM [TipoServicio]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="col-md-3">
                <div class="controls">
                    <label>Precio Base</label>
                    <dx:ASPxTextBox ID="TB_Price" runat="server" Theme="Material" Width="100%" AutoCompleteType="None" BackColor="#303030" Border-BorderColor="#303030" ForeColor="#F0F0F0" ValueType="System.Decimal">
                        <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-3">
                <div class="controls">
                    <label>Moneda</label>
                    <dx:ASPxComboBox ID="DDL_Moneda" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" ValueField="ID" TextField="descrip" DataSourceID="DS_Moneda">
                        <Columns>
                            <dx:ListBoxColumn FieldName="ID" Width="40px" Caption="C&#243;digo"></dx:ListBoxColumn>
                            <dx:ListBoxColumn FieldName="descrip" Caption="Descripci&#243;n"></dx:ListBoxColumn>
                        </Columns>
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource runat="server" ID="DS_Moneda" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [descrip] FROM [Moneda]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="col-md-3 d-flex align-items-center">
                <div class="controls">
                    <dx:ASPxCheckBox ID="CK_Activo" runat="server" Theme="Material" Width="100%" Text="Activo"></dx:ASPxCheckBox>
                </div>
            </div>
        </div>
    </asp:Panel>
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
</script>
</asp:Content>