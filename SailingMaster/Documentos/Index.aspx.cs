using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SailingMaster.Documentos
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BTN_AgregarDocumento_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Documentos/Agregar.aspx");
        }

        protected void BTN_EliminarDocumento_Click(object sender, EventArgs e)
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