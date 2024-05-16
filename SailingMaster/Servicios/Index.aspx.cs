using SailingMaster.Controllers;
using SailingMaster.Models;
using System;
using System.Data;
using System.Web.UI;

namespace SailingMaster.Servicios
{
    public partial class Index : System.Web.UI.Page
    {
        private static string IDSelected;

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);

            if (Request.QueryString["new_serv"] != null)
            {
                PN_Success.Visible = true;
                LBL_Success.Text = "Servicio agregado con éxito";
            }

            if (Request.QueryString["edit_serv"] != null)
            {
                PN_Success.Visible = true;
                LBL_Success.Text = "Servicio modificado con éxito";
            }

            if (user.tip_usuario != 0)
            {
                PN_ContainerForm.Visible = false;
                PN_Error.Visible = true;
                LBL_Error.Text = "No tienes acceso al área de tarifario";
            }
        }

        protected void GV_Servicios_RowCommand(object sender, DevExpress.Web.ASPxGridViewRowCommandEventArgs e)
        {
            IDSelected = e.KeyValue.ToString();

            if (e.CommandArgs.CommandName == "Editar")
            {
                Response.Redirect("/Servicios/Editar.aspx?ID=" + IDSelected);
            }
            else if (e.CommandArgs.CommandName == "Eliminar")
            {
                string username = (GV_Servicios.GetRow(e.VisibleIndex) as DataRowView).Row.ItemArray[1].ToString();
                LBL_Delete.Text = string.Format("¿Desea eliminar el Servicio {0}?", username);

                ScriptManager.RegisterStartupScript(this, GetType(), "modal", "openModalDelete()", true);
            }
        }

        protected void BTN_AgregarServicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Servicios/Agregar.aspx");
        }

        protected void BTN_EliminarServicio_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int result = ServicioController.Delete(IDSelected, user.username);

            if (result == 1)
            {
                PN_Success.Visible = true;
                LBL_Success.Text = "Servicio eliminado con éxito";
                GV_Servicios.DataBind();
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
            }
        }
    }
}