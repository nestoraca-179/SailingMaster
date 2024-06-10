<%@ Page Title="Editar Servicio" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Editar.aspx.cs" Inherits="SailingMaster.Servicios.Editar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .col.d-flex > .btn {
        max-height: 45px;
    }
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
                <asp:LinkButton ID="BTN_Volver" runat="server" CssClass="btn btn-primary d-flex align-items-center" OnClick="BTN_Volver_Click">
                    <i class="fas fa-arrow-left" style="margin-right: 10px;"></i> Regresar
                </asp:LinkButton>
                <dx:ASPxButton ID="BTN_Guardar" runat="server" CssClass="btn btn-success mx-2" Text="Guardar" ValidationGroup="Usuario" OnClick="BTN_Guardar_Click" />
            </div>
            <div class="col">
                <dx:ASPxLabel ID="LBL_IDServicio" runat="server" Width="100%" Font-Size="24px" CssClass="title-screen text-center text-light"></dx:ASPxLabel>
            </div>
            <div class="col d-flex justify-content-center align-items-center">
                <div class="controls">
                    <dx:ASPxCheckBox ID="CK_Activo" runat="server" Theme="Material" Width="100%" Text="Activo"></dx:ASPxCheckBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="controls">
                    <label>Código</label>
                    <dx:ASPxTextBox ID="TB_Code" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None" Enabled="false">
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
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
            <div class="col-md-6">
                <div class="controls">
                    <label>Descripción</label>
                    <dx:ASPxTextBox ID="TB_Descrip" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
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
                    <label>Moneda</label>
                    <dx:ASPxComboBox ID="DDL_Moneda" runat="server" Theme="Material" Width="100%" BackColor="#303030" Border-BorderColor="#303030" ValueField="ID" TextField="des_mone" DataSourceID="DS_Moneda">
                        <Columns>
                            <dx:ListBoxColumn FieldName="ID" Width="40px" Caption="C&#243;digo"></dx:ListBoxColumn>
                            <dx:ListBoxColumn FieldName="des_mone" Caption="Descripci&#243;n"></dx:ListBoxColumn>
                        </Columns>
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                    <asp:SqlDataSource runat="server" ID="DS_Moneda" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [ID], [des_mone] FROM [Moneda]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="col-md-3">
                <div class="controls">
                    <label>Precio Minimo</label>
                    <dx:ASPxTextBox ID="TB_PrecioMin" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                        <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-3">
                <div class="controls">
                    <label>Precio Base</label>
                    <dx:ASPxTextBox ID="TB_PrecioBase" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                        <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col-md-3">
                <div class="controls">
                    <label>Precio Maximo</label>
                    <dx:ASPxTextBox ID="TB_PrecioMax" runat="server" Theme="Material" Width="100%" BackColor="#303030" ForeColor="#F0F0F0" Border-BorderColor="#303030" AutoCompleteType="None">
                        <ClientSideEvents KeyPress="function (s,e) { onlyNumbers(s, e); }" />
                        <ValidationSettings ValidationGroup="Servicio" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
        </div>
        <hr />
        <h4 class="my-3 text-light">Rangos de Precio</h4>
        <dx:ASPxGridView ID="GV_PrecioServicio" runat="server" Theme="Material" Width="100%" CssClass="my-3" AutoGenerateColumns="false" DataSourceID="DS_PrecioServicio" 
            OnHtmlRowPrepared="GV_PrecioServicio_HtmlRowPrepared">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="co_serv" Caption="Codigo" VisibleIndex="0">
                    <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                    <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                        <Paddings Padding="12px"></Paddings>
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="campo_valor" Caption="Campo" VisibleIndex="1">
                    <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px"></HeaderStyle>
                    <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                        <Paddings Padding="12px"></Paddings>
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="desde" Caption="Desde" VisibleIndex="2">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                    <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px" HorizontalAlign="Right"></HeaderStyle>
                    <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                        <Paddings Padding="12px"></Paddings>
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="hasta" Caption="Hasta" VisibleIndex="3">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                    <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px" HorizontalAlign="Right"></HeaderStyle>
                    <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                        <Paddings Padding="12px"></Paddings>
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="precio_min" Caption="Precio Min." VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                    <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px" HorizontalAlign="Right"></HeaderStyle>
                    <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                        <Paddings Padding="12px"></Paddings>
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="precio_base" Caption="Precio Base" VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                    <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px" HorizontalAlign="Right"></HeaderStyle>
                    <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                        <Paddings Padding="12px"></Paddings>
                    </CellStyle>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="precio_max" Caption="Precio Max." VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="{0:N2}"></PropertiesTextEdit>
                    <HeaderStyle BackColor="#102140" Border-BorderWidth="0px" ForeColor="#F0F0F0" Paddings-Padding="5px" HorizontalAlign="Right"></HeaderStyle>
                    <CellStyle ForeColor="#F0F0F0" Border-BorderWidth="0px">
                        <Paddings Padding="12px"></Paddings>
                    </CellStyle>
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource runat="server" ID="DS_PrecioServicio" ConnectionString='<%$ ConnectionStrings:SailingMasterConnectionString %>' SelectCommand="SELECT [co_serv], [campo_valor], [desde], [hasta], [precio_min], [precio_base], [precio_max] FROM [PrecioServicio] WHERE ([co_serv] = @co_serv)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="ID" Name="co_serv" Type="String"></asp:QueryStringParameter>
            </SelectParameters>
        </asp:SqlDataSource>
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