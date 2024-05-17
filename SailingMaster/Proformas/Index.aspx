<%@ Page Title="Proformas | SailingMaster" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SailingMaster.Proformas.Index" %>

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
                <asp:LinkButton ID="BTN_AgregarProforma" runat="server" Text="Nuevo" CssClass="btn btn-info d-flex align-items-center" OnClick="BTN_AgregarProforma_Click">
                    <i class="fas fa-plus mx-2"></i> Agregar Nueva Proforma
                </asp:LinkButton>
            </div>
            <div class="col">
                <h2 class="text-center text-light">Proformas</h2>
            </div>
            <div class="col"></div>
        </div>
        <div class="form-grid">

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
                    <dx:ASPxButton ID="BTN_EliminarProforma" runat="server" Text="Sí" CssClass="btn btn-success" OnClick="BTN_EliminarProforma_Click"></dx:ASPxButton>
                </div>
            </div>
        </div>
    </div>
</form>
</asp:Content>