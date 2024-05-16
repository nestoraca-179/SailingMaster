<%@ Page Title="Agregar Usuario" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Agregar.aspx.cs" Inherits="SailingMaster.Usuarios.Agregar" %>

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
                <dx:ASPxButton ID="BTN_Guardar" runat="server" CssClass="btn btn-success mx-2" Text="Guardar" ValidationGroup="Usuario" OnClick="BTN_Guardar_Click" />
            </div>
            <div class="col">
                <dx:ASPxLabel ID="LBL_IDUsuario" runat="server" Text="Agregar Usuario" Width="100%" Font-Size="24px" CssClass="title-screen text-center text-light"></dx:ASPxLabel>
            </div>
            <div class="col"></div>
        </div>
        <div class="row">
            <div class="col">
                <div class="controls">
                    <label>Usuario</label>
                    <dx:ASPxTextBox ID="TB_Username" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Usuario" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col">
                <div class="controls">
                    <label>Nombre</label>
                    <dx:ASPxTextBox ID="TB_Descrip" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Usuario" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="controls">
                    <label>Clave</label>
                    <dx:ASPxTextBox ID="TB_Password" runat="server" Theme="Material" Width="100%" Password="true" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Usuario" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
            <div class="col">
                <div class="controls">
                    <label>Email</label>
                    <dx:ASPxTextBox ID="TB_Email" runat="server" Theme="Material" Width="100%" AutoCompleteType="None">
                        <ValidationSettings ValidationGroup="Usuario" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                            <RegularExpression ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorText="Correo Inválido" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="controls">
                    <div class="controls">
                    <label>Tipo Usuario</label>
                    <dx:ASPxComboBox ID="DDL_TipoUsuario" runat="server" Theme="Material" Width="100%" ValueType="System.Int32">
                        <Items>
                            <dx:ListEditItem Text="ADMINISTRADOR" Value="0"></dx:ListEditItem>
                            <dx:ListEditItem Text="GENERADOR" Value="1"></dx:ListEditItem>
                            <dx:ListEditItem Text="APROBADOR" Value="2"></dx:ListEditItem>
                            <dx:ListEditItem Text="OBSERVADOR" Value="3"></dx:ListEditItem>
                        </Items>
                        <ValidationSettings ValidationGroup="Usuario" ErrorText="" ValidateOnLeave="false" ErrorTextPosition="Bottom">
                            <RequiredField IsRequired="True" ErrorText="Campo Obligatorio" />
                        </ValidationSettings>
                    </dx:ASPxComboBox>
                </div>
                </div>
            </div>
            <div class="col d-flex align-items-center">
                <div class="controls">
                    <dx:ASPxCheckBox ID="CK_Activo" runat="server" Theme="Material" Width="100%" Text="Activo"></dx:ASPxCheckBox>
                </div>
            </div>
        </div>
    </asp:Panel>
</form>
</asp:Content>