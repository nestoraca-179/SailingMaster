﻿using DevExpress.Web;
using SailingMaster.Controllers;
using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SailingMaster.Documentos
{
    public partial class Agregar : System.Web.UI.Page
    {
        private static readonly List<DocumentoReng> rengs = new List<DocumentoReng>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);

            if (user.tip_usuario != 0)
            {
                PN_ContainerForm.Visible = false;
                PN_Error.Visible = true;
                LBL_Error.Text = "No tienes acceso al área de documentos";
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
            Response.Redirect("/Documentos/Index.aspx");
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            Documento prof = new Documento();

            try
            {
                Moneda mon = MonedaController.GetByID(DDL_Moneda.Value.ToString());

                prof.ID = TB_Code.Text;
                prof.cliente = TB_Client.Text;
                prof.fecha = DateTime.Parse(DE_Date.Value.ToString());
                prof.puerto = TB_Port.Text;
                prof.buque = TB_Vessel.Text;
                prof.nro_viaje = TB_Voyage.Text;
                prof.co_mone = DDL_Moneda.Value.ToString();
                prof.tasa = decimal.Parse(TB_Rate.Text);
                prof.num_toneladas = int.Parse(TB_Tons.Text);
                //prof.fecha_llegada = DateTime.Parse(DE_DateArrived.Value.ToString());
                //prof.fecha_salida = DateTime.Parse(DE_DateSailed.Value.ToString());
                //prof.co_us_mo = (Session["USER"] as Usuario).username;
                //prof.fe_us_mo = DateTime.Now;

                //int result = ServicioController.Add(serv);

                //if (result == 1)
                //{
                //    Response.Redirect("/Servicios/Index.aspx?new_serv=1");
                //}
                //else
                //{
                //    PN_Error.Visible = true;
                //    LBL_Error.Text = "Ha ocurrido un error al agregar el Servicio. Ver tabla de Incidentes";
                //}
            }
            catch (Exception ex)
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
                IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DE LA Documento {0}", prof.ID), ex);
            }
        }

        protected void GV_DocumentoReng_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            var newRow = new DocumentoReng
            {
                reng_num = rengs.Count + 1,
                co_serv = e.NewValues["co_serv"] as string,
                des_serv = ServicioController.GetByID(e.NewValues["co_serv"] as string).descrip,
                price_serv = Convert.ToDecimal(e.NewValues["price_serv"])
            };

            rengs.Add(newRow);
            e.Cancel = true;
            BindGrid(rengs);
            GV_DocumentoReng.CancelEdit();
        }

        protected void GV_DocumentoReng_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
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
            GV_DocumentoReng.CancelEdit();
        }

        protected void GV_DocumentoReng_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int reng_num = Convert.ToInt32(e.Keys["reng_num"]);
            var row = rengs.Find(r => r.reng_num == reng_num);

            if (row != null)
                rengs.Remove(row);

            e.Cancel = true;
            BindGrid(rengs);
        }

        protected void GV_DocumentoReng_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            // Configuración inicial para una nueva fila si es necesario
        }

        private void BindGrid(List<DocumentoReng> data)
        {
            GV_DocumentoReng.DataSource = data;
            GV_DocumentoReng.DataBind();
        }
    }
}