using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SailingMaster.Proformas
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BTN_AgregarProforma_Click(object sender, EventArgs e)
        {
            //Response.Redirect("/Servicios/Agregar.aspx");
        }

        protected void BTN_EliminarProforma_Click(object sender, EventArgs e)
        {
            //Usuario user = (Session["USER"] as Usuario);
            //int result = ServicioController.Delete(IDSelected, user.username);

            //if (result == 1)
            //{
            //    PN_Success.Visible = true;
            //    LBL_Success.Text = "Servicio eliminado con éxito";
            //    GV_Servicios.DataBind();
            //}
            //else
            //{
            //    PN_Error.Visible = true;
            //    LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
            //}
        }
    }
}