using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SailingMaster.Servicios
{
    public partial class Index : System.Web.UI.Page
    {
        private static string IDSelected;

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);

            if (user.tip_usuario != 0)
            {
                PN_ContainerForm.Visible = false;
                PN_Error.Visible = true;
                LBL_Error.Text = "No tienes acceso al área de tarifario";
            }
        }

        protected void BTN_AgregarServicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Servicios/Agregar.aspx");
        }

        protected void BTN_EliminarServicio_Click(object sender, EventArgs e)
        {
            
        }
    }
}