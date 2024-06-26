﻿using DevExpress.Web;
using SailingMaster.Controllers;
using SailingMaster.Models;
using System;
using System.Drawing;

namespace SailingMaster.Servicios
{
    public partial class Editar : System.Web.UI.Page
    {
        private static string IDServ;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["ID"] != null)
            {
                Usuario user = (Session["USER"] as Usuario);

                if (user.tip_usuario != 0)
                {
                    PN_ContainerForm.Visible = false;
                    PN_Error.Visible = true;
                    LBL_Error.Text = "No tienes acceso al área de servicios";
                }
                else
                {
                    Servicio serv = ServicioController.GetByID(Request.QueryString["ID"].ToString());

                    if (!IsPostBack)
                        CargarServicio(serv);

                    IDServ = Request.QueryString["ID"].ToString();
                    LBL_IDServicio.Text = "Editar Servicio " + serv.des_serv;
                }
            }
            else
            {
                BTN_Guardar.Visible = false;
                BTN_Volver.Visible = false;
                PN_ContainerForm.Visible = false;
                PN_Error.Visible = true;
                LBL_Error.Text = "El ID del servicio no puede ser nulo";
            }
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
                serv.ID = IDServ;
                serv.tip_serv = int.Parse(DDL_TipoServicio.Value.ToString());
                serv.des_serv = TB_Descrip.Text;
                serv.precio_min = decimal.Parse(TB_PrecioMin.Text.Replace(".", ","));
                serv.precio_base = decimal.Parse(TB_PrecioBase.Text.Replace(".", ","));
                serv.precio_max = decimal.Parse(TB_PrecioMax.Text.Replace(".", ","));
                serv.co_mone = DDL_Moneda.Value.ToString();
                serv.activo = CK_Activo.Checked;
                serv.co_us_mo = (Session["USER"] as Usuario).username;
                serv.fe_us_mo = DateTime.Now;

                int result = ServicioController.Edit(serv);

                if (result == 1)
                {
                    Response.Redirect("/Servicios/Index.aspx?edit_serv=1");
                }
                else
                {
                    PN_Error.Visible = true;
                    LBL_Error.Text = "Ha ocurrido un error al modificar el Servicio. Ver tabla de Incidentes";
                }
            }
            catch (Exception ex)
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
                IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DEL SERVICIO {0}", serv.ID), ex);
            }
        }

        protected void GV_PrecioServicio_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == DevExpress.Web.GridViewRowType.Data)
            {
                if (e.VisibleIndex % 2 == 0)
                    e.Row.BackColor = ColorTranslator.FromHtml("#26272a");
                else
                    e.Row.BackColor = ColorTranslator.FromHtml("#333438");
            }
        }

        private void CargarServicio(Servicio serv)
        {
            TB_Code.Text = serv.ID;
            DDL_TipoServicio.Value = serv.tip_serv.ToString();
            TB_Descrip.Text = serv.des_serv;
            TB_PrecioMin.Text = Math.Round(serv.precio_min, 2).ToString();
            TB_PrecioBase.Text = Math.Round(serv.precio_base, 2).ToString();
            TB_PrecioMax.Text = Math.Round(serv.precio_max, 2).ToString();
            DDL_Moneda.Value = serv.co_mone;
            CK_Activo.Checked = serv.activo;

            foreach (ListEditItem item in DDL_TipoServicio.Items)
            {
                item.Selected = item.Value.ToString() == serv.tip_serv.ToString();
            }

            foreach (ListEditItem item in DDL_Moneda.Items)
            {
                item.Selected = item.Value.ToString() == serv.co_mone;
            }
        }
    }
}