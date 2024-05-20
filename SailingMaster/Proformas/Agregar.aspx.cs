using DevExpress.Web;
using SailingMaster.Controllers;
using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SailingMaster.Proformas
{
    public partial class Agregar : System.Web.UI.Page
    {
        // Simulación de base de datos en memoria
        private static List<ProformaReng> rengs = new List<ProformaReng>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);

            if (user.tip_usuario != 0)
            {
                PN_ContainerForm.Visible = false;
                PN_Error.Visible = true;
                LBL_Error.Text = "No tienes acceso al área de proformas";
            }
            else
            {
                if (!IsPostBack)
                {
                    BindGrid(rengs);
                }
            }
        }

        protected void BTN_Volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Proformas/Index.aspx");
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            //Servicio serv = new Servicio();

            //try
            //{
            //    Moneda mon = MonedaController.GetByID(DDL_Moneda.Value.ToString());
            //    decimal price = decimal.Parse(TB_Price.Value.ToString());

            //    serv.ID = TB_Code.Text;
            //    serv.descrip = TB_Descrip.Text;
            //    serv.precio_base = mon.@base ? price : price * mon.tasa;
            //    serv.activo = CK_Activo.Checked;
            //    serv.co_us_in = (Session["USER"] as Usuario).username;
            //    serv.fe_us_in = DateTime.Now;
            //    serv.co_us_mo = (Session["USER"] as Usuario).username;
            //    serv.fe_us_mo = DateTime.Now;

            //    int result = ServicioController.Add(serv);

            //    if (result == 1)
            //    {
            //        Response.Redirect("/Servicios/Index.aspx?new_serv=1");
            //    }
            //    else
            //    {
            //        PN_Error.Visible = true;
            //        LBL_Error.Text = "Ha ocurrido un error al agregar el Servicio. Ver tabla de Incidentes";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    PN_Error.Visible = true;
            //    LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
            //    IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DEL SERVICIO {0}", serv.ID), ex);
            //}
        }

        protected void GV_ProformaReng_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            var newRow = new ProformaReng
            {
                reng_num = rengs.Count + 1,
                co_serv = e.NewValues["co_serv"] as string,
                des_serv = ServicioController.GetByID(e.NewValues["co_serv"] as string).descrip,
                price_serv = Convert.ToDecimal(e.NewValues["price_serv"])
            };

            rengs.Add(newRow);
            e.Cancel = true;
            BindGrid(rengs);
            GV_ProformaReng.CancelEdit();
        }

        protected void GV_ProformaReng_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int reng_num = Convert.ToInt32(e.Keys["reng_num"]);
            var row = rengs.Find(r => r.reng_num == reng_num);

            if (row != null)
            {
                row.co_serv = e.NewValues["co_serv"] as string;
                row.des_serv = ServicioController.GetByID(e.NewValues["co_serv"] as string).descrip;
                row.price_serv = Convert.ToDecimal(e.NewValues["price_serv"]);
            }

            e.Cancel = true;
            BindGrid(rengs);
            GV_ProformaReng.CancelEdit();
        }

        protected void GV_ProformaReng_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int reng_num = Convert.ToInt32(e.Keys["reng_num"]);
            var row = rengs.Find(r => r.reng_num == reng_num);

            if (row != null)
                rengs.Remove(row);

            e.Cancel = true;
            BindGrid(rengs);
        }

        protected void GV_ProformaReng_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            // Configuración inicial para una nueva fila si es necesario
        }

        private void BindGrid(List<ProformaReng> data)
        {
            GV_ProformaReng.DataSource = data;
            GV_ProformaReng.DataBind();
        }
    }
}