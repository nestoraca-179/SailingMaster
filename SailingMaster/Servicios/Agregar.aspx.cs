using SailingMaster.Controllers;
using SailingMaster.Models;
using System;

namespace SailingMaster.Servicios
{
    public partial class Agregar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER"] != null)
            {
                Usuario user = (Session["USER"] as Usuario);

                if (user.tip_usuario != 0)
                {
                    PN_ContainerForm.Visible = false;
                    PN_Error.Visible = true;
                    LBL_Error.Text = "No tienes acceso al área de usuarios";
                }
                else
                {
                    CK_Activo.Checked = true;
                }
            }
            else
                Response.Redirect("/Login.aspx");
        }

        protected void BTN_Volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Servicios/Index.aspx");
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            Servicio serv = new Servicio();

            try
            {
                Moneda mon = MonedaController.GetByID(DDL_Moneda.Value.ToString());
                decimal price = decimal.Parse(TB_Price.Value.ToString());

                serv.ID = TB_Code.Text;
                serv.des_serv = TB_Descrip.Text;
                serv.tip_serv = int.Parse(DDL_TipoServicio.Value.ToString());
                serv.precio_base = decimal.Parse(TB_Price.Text.Replace(".", ","));
                serv.co_mone = DDL_Moneda.Value.ToString();
                serv.activo = CK_Activo.Checked;
                serv.co_us_in = (Session["USER"] as Usuario).username;
                serv.fe_us_in = DateTime.Now;
                serv.co_us_mo = (Session["USER"] as Usuario).username;
                serv.fe_us_mo = DateTime.Now;

                int result = ServicioController.Add(serv);

                if (result == 1)
                {
                    Response.Redirect("/Servicios/Index.aspx?new_serv=1");
                }
                else
                {
                    PN_Error.Visible = true;
                    LBL_Error.Text = "Ha ocurrido un error al agregar el Servicio. Ver tabla de Incidentes";
                }
            }
            catch (Exception ex)
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
                IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DEL SERVICIO {0}", serv.ID), ex);
            }
        }
    }
}