using DevExpress.Web;
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
            Documento doc = new Documento();

            try
            {
                Moneda mon = MonedaController.GetByID(DDL_Moneda.Value.ToString());

                doc.ID = TB_Code.Text;
                doc.fecha = DateTime.Parse(DE_Date.Value.ToString());
                doc.cliente = TB_Client.Text;
                doc.co_mone = DDL_Moneda.Value.ToString();
                doc.tasa = decimal.Parse(TB_Rate.Text);
                doc.fec_llegada = DateTime.Parse(DE_DateArrived.Value.ToString());
                doc.fec_salida = DateTime.Parse(DE_DateSailed.Value.ToString());
                doc.puerto = TB_Port.Text;
                doc.buque = TB_Vessel.Text;
                doc.nro_viaje = TB_Voyage.Text;
                doc.num_toneladas = int.Parse(TB_Tons.Text);
                doc.co_us_in = (Session["USER"] as Usuario).username;
                doc.fe_us_in = DateTime.Now;
                doc.co_us_mo = (Session["USER"] as Usuario).username;
                doc.fe_us_mo = DateTime.Now;
                doc.total = rengs.Select(r => r.price_serv.Value).Sum();

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
                IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DEL DOCUMENTO {0}", doc.ID), ex);
            }
        }

        protected void GV_DocumentoReng_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == DevExpress.Web.GridViewRowType.Data)
            {
                if (e.VisibleIndex % 2 == 0)
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#26272a");
                }
                else
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#333438");
                }
            }
        }

        protected void GV_DocumentoReng_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            string moneda = DDL_Moneda.Value?.ToString();
            if (string.IsNullOrEmpty(moneda))
                moneda = "BSD";

            Servicio serv = ServicioController.GetByID(e.NewValues["co_serv"] as string);
            Moneda mone = MonedaController.GetByID(moneda);

            var newRow = new DocumentoReng
            {
                reng_num = rengs.Count + 1,
                co_serv = e.NewValues["co_serv"] as string,
                des_serv = serv.descrip,
                price_serv = Math.Round(serv.precio_base / mone.tasa, 2)
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

            string moneda = DDL_Moneda.Value?.ToString();
            if (string.IsNullOrEmpty(moneda))
                moneda = "BSD";

            Servicio serv = ServicioController.GetByID(row.co_serv);
            Moneda mone = MonedaController.GetByID(moneda);

            if (row != null)
            {
                row.co_serv = e.NewValues["co_serv"] as string;
                row.des_serv = ServicioController.GetByID(e.NewValues["co_serv"] as string).descrip;
                row.price_serv = Math.Round(serv.precio_base / mone.tasa, 2);
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