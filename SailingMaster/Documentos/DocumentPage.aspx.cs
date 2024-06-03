using DevExpress.Web;
using SailingMaster.Controllers;
using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SailingMaster.Documentos
{
    public partial class DocumentPage : System.Web.UI.Page
    {
        private static List<DocumentoReng> rengs = new List<DocumentoReng>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER"] != null)
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
                    //string moneda = DDL_Moneda.Value?.ToString();
                    //if (string.IsNullOrEmpty(moneda))
                    //    moneda = "BSD";

                    //Moneda mone;
                    //if (Request.QueryString["ID"] != null) // EDITANDO
                    //{
                    //    Documento doc = DocumentoController.GetByID(int.Parse(Request.QueryString["ID"].ToString()));
                    //    mone = MonedaController.GetByID(doc.co_mone);

                    //    BlockAllItems(doc.status);
                    //    if (doc.status < 4)
                    //    {
                    //        LBL_TotalRecibido.Text = "0,00";
                    //        LBL_TotalCancelado.Text = "0,00";
                    //        LBL_Balance.Text = "0,00";
                    //    }
                    //    else
                    //    {
                    //        NumberFormatInfo formato = new NumberFormatInfo();
                    //        formato.NumberDecimalSeparator = ",";
                    //        formato.NumberGroupSeparator = ".";

                    //        LBL_TotalRecibido.Text = doc.collected_amount.Value.ToString("N2", formato);
                    //        LBL_TotalCancelado.Text = "0,00";
                    //        LBL_Balance.Text = doc.collected_amount.Value.ToString("N2", formato);
                    //    }

                    //    string status;
                    //    switch (doc.status)
                    //    {
                    //        case 0:
                    //            status = "GENERADO";
                    //            break;
                    //        case 1:
                    //            status = "APROBADO";
                    //            break;
                    //        case 2:
                    //            status = "REVISADO";
                    //            break;
                    //        case 3:
                    //            status = "CORREGIDO";
                    //            break;
                    //        case 4:
                    //            status = "COBRADO";
                    //            break;
                    //        case 5:
                    //            status = "LIQUIDADO";
                    //            break;
                    //        case 6:
                    //            status = "CERRADO";
                    //            break;
                    //        default:
                    //            status = "";
                    //            break;
                    //    }

                    //    Page.Title = "Documento #" + doc.ID;
                    //    LBL_IDDocumento.Text = "Documento #" + doc.ID;
                    //    BTN_Agregar.Visible = false;
                    //    BTN_Guardar.Visible = true;
                    //    PN_ButtonsActions.Visible = true;
                    //    LBL_Status.Text = status;

                    //    if (!IsPostBack)
                    //        CargarDocumento(doc);
                    //}
                    //else // AGREGANDO
                    //{
                    //    mone = MonedaController.GetByID(moneda);
                    //    LBL_TotalRecibido.Text = "0,00";
                    //    LBL_TotalCancelado.Text = "0,00";
                    //    LBL_Balance.Text = "0,00";

                    //    if (!IsPostBack)
                    //        rengs = new List<DocumentoReng>();
                    //}

                    //LBL_SignoTD.Text = mone.signo;
                    //LBL_SignoTR.Text = mone.signo;
                    //LBL_SignoTC.Text = mone.signo;
                    //LBL_SignoBC.Text = mone.signo;

                    //BindGrid(rengs);
                }
            }
            else
                Response.Redirect("/Login.aspx");
        }

        protected void BTN_Volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Documentos/Index.aspx");
        }

        protected void BTN_Agregar_Click(object sender, EventArgs e)
        {
            Documento doc = new Documento();

            try
            {
                //Moneda mon = MonedaController.GetByID(DDL_Moneda.Value.ToString());

                //doc.cuenta_buq = TB_CuentaBuque.Text;
                //doc.fecha = DateTime.Parse(DE_Fecha.Value.ToString());
                //doc.cliente = TB_Cliente.Text;
                //doc.co_mone = DDL_Moneda.Value.ToString();
                //doc.tasa = decimal.Parse(TB_Tasa.Text.Replace(".", ","));
                //doc.fec_llegada = DateTime.Parse(DE_FechaLlegada.Value.ToString());
                //doc.fec_salida = DateTime.Parse(DE_FechaSalida.Value.ToString());
                //doc.puerto = TB_Puerto.Text;
                //doc.buque = TB_Buque.Text;
                //doc.nro_viaje = TB_Viaje.Text;
                //doc.num_toneladas = int.Parse(TB_Toneladas.Text);
                //doc.co_us_in = (Session["USER"] as Usuario).username;
                //doc.fe_us_in = DateTime.Now;
                //doc.co_us_mo = (Session["USER"] as Usuario).username;
                //doc.fe_us_mo = DateTime.Now;
                //doc.total = rengs.Select(r => r.price_serv.Value).Sum();
                //doc.DocumentoReng = rengs;

                //if (rengs.Count == 0)
                //{
                //    PN_Error.Visible = true;
                //    LBL_Error.Text = "Debes agregar items al documento";
                //}
                //else
                //{
                //    foreach (DocumentoReng r in doc.DocumentoReng)
                //    {
                //        r.co_doc = doc.ID;
                //        r.co_us_in = (Session["USER"] as Usuario).username;
                //        r.fe_us_in = DateTime.Now;
                //        r.co_us_mo = (Session["USER"] as Usuario).username;
                //        r.fe_us_mo = DateTime.Now;
                //    }

                //    int result = DocumentoController.Add(doc);
                //    if (result == 1)
                //    {
                //        Response.Redirect("/Documentos/Index.aspx?new_doc=0");
                //    }
                //    else
                //    {
                //        PN_Error.Visible = true;
                //        LBL_Error.Text = "Ha ocurrido un error al agregar el Documento. Ver tabla de Incidentes";
                //    }
                //}
            }
            catch (Exception ex)
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
                IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DEL DOCUMENTO {0}", doc.ID), ex);
            }
        }

        protected void BTN_AprobarDocumento_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int id = int.Parse(Request.QueryString["ID"].ToString());

            Documento doc = DocumentoController.GetByID(id);
            doc.status = 1; // APROBADO
            doc.approved_by = user.username;
            doc.approved_date = DateTime.Now;
            doc.co_us_mo = user.username;
            doc.fe_us_mo = DateTime.Now;

            int result = DocumentoController.Edit(doc);

            if (result == 1)
            {
                Response.Redirect("/Documentos/Index.aspx?new_doc=1");
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error al revisar el Documento. Ver tabla de Incidentes";
            }
        }

        protected void BTN_RevisarDocumento_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int id = int.Parse(Request.QueryString["ID"].ToString());

            Documento doc = DocumentoController.GetByID(id);
            doc.status = 2; // REVISADO
            doc.reviewed_by = user.username;
            doc.reviewed_date = DateTime.Now;
            doc.reviewed_observ = MM_Observ.Text;
            doc.co_us_mo = user.username;
            doc.fe_us_mo = DateTime.Now;

            int result = DocumentoController.Edit(doc);

            if (result == 1)
            {
                Response.Redirect("/Documentos/Index.aspx?new_doc=2");
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error al revisar el Documento. Ver tabla de Incidentes";
            }
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int id = int.Parse(Request.QueryString["ID"].ToString());

            Documento doc = DocumentoController.GetByID(id);

            try
            {
                //Moneda mon = MonedaController.GetByID(DDL_Moneda.Value.ToString());

                //doc.cuenta_buq = TB_CuentaBuque.Text;
                //doc.fecha = DateTime.Parse(DE_Fecha.Value.ToString());
                //doc.cliente = TB_Cliente.Text;
                //doc.co_mone = DDL_Moneda.Value.ToString();
                //doc.tasa = decimal.Parse(TB_Tasa.Text.Replace(".", ","));
                //doc.fec_llegada = DateTime.Parse(DE_FechaLlegada.Value.ToString());
                //doc.fec_salida = DateTime.Parse(DE_FechaSalida.Value.ToString());
                //doc.puerto = TB_Puerto.Text;
                //doc.buque = TB_Buque.Text;
                //doc.nro_viaje = TB_Viaje.Text;
                //doc.num_toneladas = int.Parse(TB_Toneladas.Text);
                //doc.status = doc.status == 2 ? 3 : 0; // CORREGIDO - GENERADO
                //doc.corrected_by = user.username;
                //doc.corrected_date = DateTime.Now;
                //doc.co_us_mo = (Session["USER"] as Usuario).username;
                //doc.fe_us_mo = DateTime.Now;
                //doc.total = rengs.Select(r => r.price_serv.Value).Sum();
                //doc.DocumentoReng = rengs;

                //if (rengs.Count == 0)
                //{
                //    PN_Error.Visible = true;
                //    LBL_Error.Text = "Debes agregar items al documento";
                //}
                //else
                //{
                //    foreach (DocumentoReng r in doc.DocumentoReng)
                //    {
                //        r.co_us_mo = (Session["USER"] as Usuario).username;
                //        r.fe_us_mo = DateTime.Now;
                //    }

                //    int result = DocumentoController.Edit(doc);
                //    if (result == 1)
                //    {
                //        Response.Redirect("/Documentos/Index.aspx?new_doc=3");
                //    }
                //    else
                //    {
                //        PN_Error.Visible = true;
                //        LBL_Error.Text = "Ha ocurrido un error al modificar el Documento. Ver tabla de Incidentes";
                //    }
                //}
            }
            catch (Exception ex)
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
                IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DEL DOCUMENTO {0}", doc.ID), ex);
            }
        }

        protected void BTN_CobrarDocumento_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int id = int.Parse(Request.QueryString["ID"].ToString());

            Documento doc = DocumentoController.GetByID(id);
            doc.status = 4; // COBRADO
            doc.collected_by = user.username;
            doc.collected_date = DateTime.Now;
            doc.collected_amount = decimal.Parse(TB_MontoTransf.Text.Replace(".", ","));
            doc.collected_bank = TB_BancoTransf.Text;
            doc.collected_date_transf = DateTime.Parse(DE_FechaTransf.Value.ToString());
            doc.collected_nref_transf = TB_RefTransf.Text;
            doc.co_us_mo = user.username;
            doc.fe_us_mo = DateTime.Now;

            //if (FU_CompTransf.HasFile)
            //{
            //    string fileName = FU_CompTransf.FileName;
            //    string contentType = FU_CompTransf.PostedFile.ContentType;
            //    byte[] fileData = FU_CompTransf.FileBytes;
            //}

            int result = DocumentoController.Edit(doc);

            if (result == 1)
            {
                Response.Redirect("/Documentos/Index.aspx?new_doc=4");
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error al revisar el Documento. Ver tabla de Incidentes";
            }
        }

        protected void BTN_LiquidarDocumento_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int id = int.Parse(Request.QueryString["ID"].ToString());

            Documento doc = DocumentoController.GetByID(id);
            doc.status = 5; // LIQUIDADO
            doc.liquidated_by = user.username;
            doc.liquidated_date = DateTime.Now;
            doc.co_us_mo = user.username;
            doc.fe_us_mo = DateTime.Now;

            int result = DocumentoController.Edit(doc);

            if (result == 1)
            {
                Response.Redirect("/Documentos/Index.aspx?new_doc=5");
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error al revisar el Documento. Ver tabla de Incidentes";
            }
        }

        protected void BTN_CerrarDocumento_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int id = int.Parse(Request.QueryString["ID"].ToString());

            Documento doc = DocumentoController.GetByID(id);
            doc.status = 6; // CERRADO
            doc.closed_by = user.username;
            doc.closed_date = DateTime.Now;
            doc.co_us_mo = user.username;
            doc.fe_us_mo = DateTime.Now;

            int result = DocumentoController.Edit(doc);

            if (result == 1)
            {
                Response.Redirect("/Documentos/Index.aspx?new_doc=6");
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error al revisar el Documento. Ver tabla de Incidentes";
            }
        }

        protected void BTN_EliminarDocumento_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            int result = DocumentoController.Delete(int.Parse(Request.QueryString["ID"].ToString()), user.username);

            if (result == 1)
            {
                Response.Redirect("/Documentos/Index.aspx?new_doc=-1");
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error al eliminar el Documento. Ver tabla de Incidentes";
            }
        }

        protected void DDL_Moneda_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string moneda = DDL_Moneda.Value?.ToString();
            //if (string.IsNullOrEmpty(moneda))
            //    moneda = "BSD";

            //Servicio serv;
            //Moneda mone = MonedaController.GetByID(moneda);
            //TB_Tasa.Text = mone.tasa.ToString();

            //foreach (DocumentoReng r in rengs)
            //{
            //    serv = ServicioController.GetByID(r.co_serv);
            //    r.price_serv = Math.Round(serv.precio_base / mone.tasa, 2);
            //}

            //BindGrid(rengs);
        }

        protected void TB_Tasa_TextChanged(object sender, EventArgs e)
        {
            //decimal tasa;
            //if (!string.IsNullOrEmpty(TB_Tasa.Text))
            //    tasa = decimal.Parse(TB_Tasa.Text.Replace(".", ","));
            //else
            //    tasa = 1;

            //Servicio serv;
            //foreach (DocumentoReng r in rengs)
            //{
            //    serv = ServicioController.GetByID(r.co_serv);
            //    r.price_serv = Math.Round(serv.precio_base / tasa, 2);
            //}

            //BindGrid(rengs);
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

        protected void GV_DocumentoReng_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.DataColumn.Caption == "Subir Soporte")
            {
                ASPxButton button = GV_DocumentoReng.FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "BTN_AgregarSoporte") as ASPxButton;
                DisableButton(button);
            }
        }

        protected void GV_DocumentoReng_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            //string moneda = DDL_Moneda.Value?.ToString();
            //if (string.IsNullOrEmpty(moneda))
            //    moneda = "BSD";

            //Servicio serv = ServicioController.GetByID(e.NewValues["co_serv"] as string);
            //Moneda mone = MonedaController.GetByID(moneda);

            //decimal tasa;
            //if (!string.IsNullOrEmpty(TB_Tasa.Text))
            //    tasa = decimal.Parse(TB_Tasa.Text.Replace(".", ","));
            //else
            //    tasa = mone.tasa;

            //var newRow = new DocumentoReng
            //{
            //    reng_num = rengs.Count + 1,
            //    co_serv = e.NewValues["co_serv"] as string,
            //    des_serv = serv.descrip,
            //    price_serv = Math.Round(serv.precio_base / tasa, 2)
            //};
            //rengs.Add(newRow);

            //BindGrid(rengs);
            //e.Cancel = true;
            //GV_DocumentoReng.CancelEdit();
        }

        protected void GV_DocumentoReng_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            //int reng_num = Convert.ToInt32(e.Keys["reng_num"]);
            //var row = rengs.Find(r => r.reng_num == reng_num);

            //string moneda = DDL_Moneda.Value?.ToString();
            //if (string.IsNullOrEmpty(moneda))
            //    moneda = "BSD";

            //Servicio serv = ServicioController.GetByID(row.co_serv);
            //Moneda mone = MonedaController.GetByID(moneda);

            //decimal tasa;
            //if (!string.IsNullOrEmpty(TB_Tasa.Text))
            //    tasa = decimal.Parse(TB_Tasa.Text.Replace(".", ","));
            //else
            //    tasa = mone.tasa;

            //if (row != null)
            //{
            //    row.co_serv = e.NewValues["co_serv"] as string;
            //    row.des_serv = ServicioController.GetByID(e.NewValues["co_serv"] as string).descrip;
            //    row.price_serv = Math.Round(serv.precio_base / tasa, 2);
            //}

            //e.Cancel = true;
            //BindGrid(rengs);
            //GV_DocumentoReng.CancelEdit();
        }

        protected void GV_DocumentoReng_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int reng_num = Convert.ToInt32(e.Keys["reng_num"]);
            var row = rengs.Find(r => r.reng_num == reng_num);

            if (row != null)
                rengs.Remove(row);

            int i = 1;
            foreach (DocumentoReng r in rengs.OrderBy(r => r.reng_num))
            {
                r.reng_num = i;
                i++;
            }

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
        
        private void CargarDocumento(Documento doc)
        {
            //TB_CuentaBuque.Text = doc.cuenta_buq;
            //DE_Fecha.Value = doc.fecha;
            //TB_Cliente.Text = doc.cliente;
            //DDL_Moneda.Value = doc.co_mone;
            //TB_Tasa.Text = doc.tasa.ToString();
            //DE_FechaLlegada.Value = doc.fec_llegada;
            //DE_FechaSalida.Value = doc.fec_salida;
            //TB_Puerto.Text = doc.puerto;
            //TB_Buque.Text = doc.buque;
            //TB_Viaje.Text = doc.nro_viaje;
            //TB_Toneladas.Text = doc.num_toneladas.ToString();
            //doc.total = doc.DocumentoReng.Select(r => r.price_serv.Value).Sum();
            //rengs = doc.DocumentoReng.ToList();

            //foreach (ListEditItem item in DDL_Moneda.Items)
            //{
            //    item.Selected = doc.co_mone.ToString() == item.Value.ToString();
            //}
        }

        private void BlockAllItems(int status)
        {
            if (status == 6)
            {
                // COLUMNA
                GV_DocumentoReng.SettingsEditing.Mode = GridViewEditingMode.EditForm;
                GV_DocumentoReng.Columns[0].Visible = false;

                // BOTONES
                DisableButton(BTN_Guardar);
                DisableButton(BTN_PreRevisarDocumento);
                DisableButton(BTN_PreAprobarDocumento);
                DisableButton(BTN_PreCobrarDocumento);
                DisableButton(BTN_PreLiquidarDocumento);
                DisableButton(BTN_PreCerrarDocumento);
                DisableButton(BTN_PreEliminarDocumento);

                // CAMPOS
                TB_CuentaBuque.Enabled = false;
                DE_Fecha.Enabled = false;
                TB_Cliente.Enabled = false;
                //DDL_Moneda.Enabled = false;
                //TB_Tasa.Enabled = false;
                DE_FechaLlegada.Enabled = false;
                DE_FechaSalida.Enabled = false;
                TB_Puerto.Enabled = false;
                TB_Buque.Enabled = false;
                TB_Viaje.Enabled = false;
                TB_Toneladas.Enabled = false;
            }
        }

        private void DisableButton(WebControl control)
        {
            control.Attributes.Add("class", "btn disabled");
            control.Attributes.Add("style", "opacity: 0.5");
            control.Attributes.Remove("href");
            control.Attributes.Remove("data-toggle");
            control.Attributes.Remove("data-target");
            control.Attributes.CssStyle[HtmlTextWriterStyle.Cursor] = "default";
            control.Enabled = false;
        }
    }
}