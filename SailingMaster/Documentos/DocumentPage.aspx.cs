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
        private static int IDSelected;
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
                    if (Request.QueryString["ID"] != null) // EDITANDO
                    {
                        Documento doc = DocumentoController.GetByID(int.Parse(Request.QueryString["ID"].ToString()));
                        BlockAllFields(doc.status);

                        if (doc.status < 4)
                        {
                            LBL_TotalRecibido.Text = "0,00";
                            LBL_TotalRecibido_USD.Text = "0,00";
                            LBL_TotalCancelado.Text = "0,00";
                            LBL_TotalCancelado_USD.Text = "0,00";
                            LBL_Balance.Text = "0,00";
                            LBL_Balance_USD.Text = "0,00";
                        }
                        else
                        {
                            SetAmounts(doc);
                        }

                        string status;
                        switch (doc.status)
                        {
                            case 0:
                                status = "GENERADO";
                                break;
                            case 1:
                                status = "APROBADO";
                                break;
                            case 2:
                                status = "REVISADO";
                                break;
                            case 3:
                                status = "CORREGIDO";
                                break;
                            case 4:
                                status = "COBRADO";
                                break;
                            case 5:
                                status = "LIQUIDADO";
                                break;
                            case 6:
                                status = "CERRADO";
                                break;
                            default:
                                status = "";
                                break;
                        }

                        Page.Title = "Documento #" + doc.ID;
                        LBL_IDDocumento.Text = "Documento #" + doc.ID;
                        BTN_Agregar.Visible = false;
                        BTN_Guardar.Visible = true;
                        PN_ButtonsActions.Visible = true;
                        LBL_Status.Text = status;

                        if (!IsPostBack)
                            CargarDocumento(doc);
                    }
                    else // AGREGANDO
                    {
                        InitAllFields();
                        if (!IsPostBack)
                            rengs = new List<DocumentoReng>();
                    }

                    BindGrid(rengs);
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
                doc.fecha = DateTime.Parse(DE_Fecha.Value.ToString());
                doc.co_cli = DDL_Cliente.Value.ToString();
                doc.nro_viaje = TB_NroViaje.Text;
                doc.co_buque = int.Parse(DDL_Buque.Value.ToString());
                doc.flag = TB_Flag.Text;
                doc.co_puerto = DDL_Puerto.Value.ToString();
                doc.muelle = TB_Muelle.Text;
                doc.horas = int.Parse(TB_Horas.Text);
                doc.valor_ut = decimal.Parse(TB_ValorUT.Text);
                doc.loa = decimal.Parse(TB_LOA.Text);
                doc.grt = decimal.Parse(TB_GRT.Text);
                doc.nrt = decimal.Parse(TB_NRT.Text);
                doc.sdwt = decimal.Parse(TB_SDWT.Text);
                doc.fec_llegada = GetDateTime(DE_FechaLlegada.Value.ToString(), TE_HoraLlegada.Value.ToString());
                doc.fec_salida = GetDateTime(DE_FechaSalida.Value.ToString(), TE_HoraSalida.Value.ToString());
                doc.tasa_usd = decimal.Parse(TB_TasaUSD.Text.Replace(".", ","));
                doc.tasa_eur = decimal.Parse(TB_TasaEUR.Text.Replace(".", ","));
                doc.tasa_ptr = decimal.Parse(TB_TasaPTR.Text.Replace(".", ","));
                doc.status = 0; // GENERADO
                doc.co_us_in = (Session["USER"] as Usuario).username;
                doc.fe_us_in = DateTime.Now;
                doc.co_us_mo = (Session["USER"] as Usuario).username;
                doc.fe_us_mo = DateTime.Now;
                doc.total = rengs.Select(r => r.price_bsd).Sum();
                doc.total_usd = rengs.Select(r => r.price_usd).Sum();
                doc.DocumentoReng = rengs;

                if (rengs.Count == 0)
                {
                    PN_Error.Visible = true;
                    LBL_Error.Text = "Debes agregar items al documento";
                }
                else
                {
                    foreach (DocumentoReng r in doc.DocumentoReng)
                    {
                        r.co_doc = doc.ID;
                        r.co_us_in = (Session["USER"] as Usuario).username;
                        r.fe_us_in = DateTime.Now;
                        r.co_us_mo = (Session["USER"] as Usuario).username;
                        r.fe_us_mo = DateTime.Now;
                    }

                    int result = DocumentoController.Add(doc);
                    if (result == 1)
                    {
                        Response.Redirect("/Documentos/Index.aspx?new_doc=0");
                    }
                    else
                    {
                        PN_Error.Visible = true;
                        LBL_Error.Text = "Ha ocurrido un error al agregar el Documento. Ver tabla de Incidentes";
                    }
                }
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
                doc.fecha = DateTime.Parse(DE_Fecha.Value.ToString());
                doc.co_cli = DDL_Cliente.Value.ToString();
                doc.nro_viaje = TB_NroViaje.Text;
                doc.co_buque = int.Parse(DDL_Buque.Value.ToString());
                doc.flag = TB_Flag.Text;
                doc.co_puerto = DDL_Puerto.Value.ToString();
                doc.muelle = TB_Muelle.Text;
                doc.horas = int.Parse(TB_Horas.Text);
                doc.valor_ut = decimal.Parse(TB_ValorUT.Text);
                doc.loa = decimal.Parse(TB_LOA.Text);
                doc.grt = decimal.Parse(TB_GRT.Text);
                doc.nrt = decimal.Parse(TB_NRT.Text);
                doc.sdwt = decimal.Parse(TB_SDWT.Text);
                doc.fec_llegada = GetDateTime(DE_FechaLlegada.Value.ToString(), TE_HoraLlegada.Value.ToString());
                doc.fec_salida = GetDateTime(DE_FechaSalida.Value.ToString(), TE_HoraSalida.Value.ToString());
                doc.tasa_usd = decimal.Parse(TB_TasaUSD.Text.Replace(".", ","));
                doc.tasa_eur = decimal.Parse(TB_TasaEUR.Text.Replace(".", ","));
                doc.tasa_ptr = decimal.Parse(TB_TasaPTR.Text.Replace(".", ","));
                doc.status = doc.status == 2 ? 3 : 0; // CORREGIDO - GENERADO
                doc.co_us_mo = (Session["USER"] as Usuario).username;
                doc.fe_us_mo = DateTime.Now;
                doc.total = rengs.Select(r => r.price_bsd).Sum();
                doc.total_usd = rengs.Select(r => r.price_usd).Sum();
                doc.DocumentoReng = rengs;

                if (doc.status == 3)
                {
                    doc.corrected_by = user.username;
                    doc.corrected_date = DateTime.Now;
                }

                if (rengs.Count == 0)
                {
                    PN_Error.Visible = true;
                    LBL_Error.Text = "Debes agregar items al documento";
                }
                else
                {
                    foreach (DocumentoReng r in doc.DocumentoReng)
                    {
                        r.co_doc = doc.ID;
                        r.co_us_mo = (Session["USER"] as Usuario).username;
                        r.fe_us_mo = DateTime.Now;
                    }

                    int result = DocumentoController.Edit(doc);
                    if (result == 1)
                    {
                        Response.Redirect("/Documentos/Index.aspx?new_doc=3");
                    }
                    else
                    {
                        PN_Error.Visible = true;
                        LBL_Error.Text = "Ha ocurrido un error al modificar el Documento. Ver tabla de Incidentes";
                    }
                }
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
            string co_mone = BancoController.GetByID(DDL_BancoTransf.Value.ToString()).co_mone;

            Documento doc = DocumentoController.GetByID(id);
            doc.status = 4; // COBRADO
            doc.collected_by = user.username;
            doc.collected_date = DateTime.Now;
            doc.collected_amount = decimal.Parse(TB_MontoTransf.Text.Replace(".", ",")) * (co_mone == "USD" ? doc.tasa_usd : 1);
            doc.collected_bank = DDL_BancoTransf.Value.ToString();
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

        protected void BTN_AgregarSoporteReng_Click(object sender, EventArgs e)
        {
            Usuario user = (Session["USER"] as Usuario);
            Documento doc = DocumentoController.GetByID(int.Parse(Request.QueryString["ID"].ToString()));
            DocumentoReng reng = doc.DocumentoReng.Single(r => r.reng_num == IDSelected);
            
            string co_mone = MonedaController.GetByID(DDL_MonedaReng.Value.ToString()).ID;
            int index = doc.DocumentoReng.ToList().IndexOf(reng);

            reng.mone_liq = co_mone;
            reng.price_liq = decimal.Parse(TB_MontoReng.Text.Replace(".", ",")) * (co_mone == "USD" ? doc.tasa_usd : 1);
            reng.co_us_mo = user.username;
            reng.fe_us_mo = DateTime.Now;

            int result = DocumentoController.LiqReng(reng);

            if (result == 1)
            {
                reng.price_liq = decimal.Parse(TB_MontoReng.Text.Replace(".", ","));
                rengs[index] = reng;
                SetAmounts(doc);
                BindGrid(rengs);

                PN_Success.Visible = true;
                LBL_Success.Text = "Renglon liquidado con éxito";
            }
            else
            {
                PN_Error.Visible = true;
                LBL_Error.Text = "Ha ocurrido un error al revisar el Documento. Ver tabla de Incidentes";
            }
        }

        protected void DDL_Buque_SelectedIndexChanged(object sender, EventArgs e)
        {
            Buque buque = BuqueController.GetByID(int.Parse(DDL_Buque.Value.ToString()));

            TB_LOA.Text = buque.loa.ToString();
            TB_GRT.Text = buque.grt.ToString();
            TB_NRT.Text = buque.nrt.ToString();
            TB_SDWT.Text = buque.sdwt.ToString();

            foreach (DocumentoReng reng in rengs)
            {
                Servicio serv = ServicioController.GetByID(reng.co_serv);
                if (ServicioController.HasRange(reng.co_serv))
                {
                    serv.precio_base = ServicioController.GetPriceServ(reng.co_serv, buque, reng.tip_precio);
                }

                reng.price_serv = serv.precio_base;
                reng.price_bsd = (reng.co_mone == "BSD" ? reng.price_serv : MonedaController.ConvertToBSD(serv)) * reng.cantidad;
                reng.price_usd = (reng.co_mone == "USD" ? reng.price_serv : MonedaController.ConvertToUSD(serv)) * reng.cantidad;
                reng.price_eur = (reng.co_mone == "EUR" ? reng.price_serv : MonedaController.ConvertToEUR(serv)) * reng.cantidad;
            }

            BindGrid(rengs);
        }

        protected void TB_DateHour_ValueChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(DE_FechaLlegada.Text) && !string.IsNullOrEmpty(TE_HoraLlegada.Text) &&
                !string.IsNullOrEmpty(DE_FechaSalida.Text) && !string.IsNullOrEmpty(TE_HoraSalida.Text))
            {
                DateTime fec_llegada = GetDateTime(DE_FechaLlegada.Value.ToString(), TE_HoraLlegada.Value.ToString());
                DateTime fec_salida = GetDateTime(DE_FechaSalida.Value.ToString(), TE_HoraSalida.Value.ToString());

                TimeSpan diff = fec_salida.Subtract(fec_llegada);
                TB_Horas.Text = ((diff.Days * 24) + diff.Hours).ToString();
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

        protected void GV_DocumentoReng_HtmlDataCellPrepared(object sender, ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.DataColumn.Caption == "Soporte")
            {
                if (Request.QueryString["ID"] != null)
                {
                    Documento doc = DocumentoController.GetByID(int.Parse(Request.QueryString["ID"].ToString()));
                    DocumentoReng reng = rengs.Single(r => r.reng_num == Convert.ToInt32(e.KeyValue ?? "1"));

                    if (doc.status != 5 || reng.price_liq > 0)
                    {
                        ASPxButton button = GV_DocumentoReng.FindRowCellTemplateControl(e.VisibleIndex, e.DataColumn, "BTN_AgregarSoporte") as ASPxButton;
                        DisableButton(button);
                    }
                }
            }
        }

        protected void GV_DocumentoReng_RowCommand(object sender, ASPxGridViewRowCommandEventArgs e)
        {
            IDSelected = int.Parse(e.KeyValue.ToString());
            ScriptManager.RegisterStartupScript(this, GetType(), "modal", "openModalReng()", true);
        }

        protected void GV_DocumentoReng_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            Servicio serv = ServicioController.GetByID(e.NewValues["co_serv"] as string);
            int cantidad = Convert.ToInt32(e.NewValues["cantidad"]);
            string tip_precio = e.NewValues["tip_precio"] as string;

            if (ServicioController.HasRange(serv.ID))
            {
                if (DDL_Buque.Value == null)
                    throw new Exception("El servicio seleccionado depende de los valores del buque. Por favor, seleccione un buque.");
                else
                {
                    Buque buque = BuqueController.GetByID(Convert.ToInt32(DDL_Buque.Value));
                    serv.precio_base = ServicioController.GetPriceServ(serv.ID, buque, tip_precio);
                }
            }

            var newRow = new DocumentoReng
            {
                reng_num = rengs.Count + 1,
                co_serv = e.NewValues["co_serv"] as string,
                des_serv = serv.des_serv,
                cantidad = cantidad,
                co_mone = serv.co_mone,
                price_serv = serv.precio_base,
                tip_precio = tip_precio,
                price_bsd = (serv.co_mone == "BSD" ? serv.precio_base : MonedaController.ConvertToBSD(serv)) * cantidad,
                price_usd = (serv.co_mone == "USD" ? serv.precio_base : MonedaController.ConvertToUSD(serv)) * cantidad,
                price_eur = (serv.co_mone == "EUR" ? serv.precio_base : MonedaController.ConvertToEUR(serv)) * cantidad,
                price_liq = 0
            };
            rengs.Add(newRow);

            BindGrid(rengs);
            e.Cancel = true;
            GV_DocumentoReng.CancelEdit();
        }

        protected void GV_DocumentoReng_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            int reng_num = Convert.ToInt32(e.Keys["reng_num"]);
            var row = rengs.Find(r => r.reng_num == reng_num);

            Servicio serv = ServicioController.GetByID(e.NewValues["co_serv"].ToString());
            Moneda mone = MonedaController.GetByID(serv.co_mone);

            int cantidad = Convert.ToInt32(e.NewValues["cantidad"]);
            string tip_precio = e.NewValues["tip_precio"] as string;
            decimal tasa_usd = MonedaController.GetByID("USD").tasa;
            decimal tasa_eur = MonedaController.GetByID("EUR").tasa;

            if (ServicioController.HasRange(serv.ID))
            {
                if (DDL_Buque.Value == null)
                    throw new Exception("El servicio seleccionado depende de los valores del buque. Por favor, seleccione un buque.");
                else
                {
                    Buque buque = BuqueController.GetByID(Convert.ToInt32(DDL_Buque.Value));
                    serv.precio_base = ServicioController.GetPriceServ(serv.ID, buque, tip_precio);
                }
            }

            if (row != null)
            {
                row.co_serv = e.NewValues["co_serv"] as string;
                row.des_serv = serv.des_serv;
                row.cantidad = cantidad;
                row.co_mone = serv.co_mone;
                row.price_serv = serv.precio_base;
                row.tip_precio = tip_precio;
                row.price_bsd = (serv.co_mone == "BSD" ? serv.precio_base : MonedaController.ConvertToBSD(serv)) * cantidad;
                row.price_usd = (serv.co_mone == "USD" ? serv.precio_base : MonedaController.ConvertToUSD(serv)) * cantidad;
                row.price_eur = (serv.co_mone == "EUR" ? serv.precio_base : MonedaController.ConvertToEUR(serv)) * cantidad;
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
            DE_Fecha.Value = doc.fecha;
            DDL_Cliente.Value = doc.co_cli;
            TB_NroViaje.Text = doc.nro_viaje;
            DDL_Buque.Value = doc.co_buque.ToString();
            TB_Flag.Text = doc.flag;
            DDL_Puerto.Value = doc.co_puerto;
            TB_Muelle.Text = doc.muelle;
            TB_Horas.Text = doc.horas.ToString();
            TB_ValorUT.Text = doc.valor_ut.ToString();
            TB_LOA.Text = doc.loa.ToString();
            TB_GRT.Text = doc.grt.ToString();
            TB_NRT.Text = doc.nrt.ToString();
            TB_SDWT.Text = doc.sdwt.ToString();
            DE_FechaLlegada.Value = doc.fec_llegada;
            TE_HoraLlegada.Value = doc.fec_llegada;
            DE_FechaSalida.Value = doc.fec_salida;
            TE_HoraSalida.Value = doc.fec_salida;
            TB_TasaUSD.Text = doc.tasa_usd.ToString();
            TB_TasaEUR.Text = doc.tasa_eur.ToString();
            TB_TasaPTR.Text = doc.tasa_ptr.ToString();
            TB_TasaEURUSD.Text = Math.Round(doc.tasa_eur / doc.tasa_usd, 2).ToString();
            rengs = doc.DocumentoReng.ToList();

            foreach (ListEditItem item in DDL_Cliente.Items)
            {
                item.Selected = doc.co_cli.ToString() == item.Value.ToString();
            }

            foreach (ListEditItem item in DDL_Buque.Items)
            {
                item.Selected = doc.co_buque.ToString() == item.Value.ToString();
            }

            foreach (ListEditItem item in DDL_Puerto.Items)
            {
                item.Selected = doc.co_puerto.ToString() == item.Value.ToString();
            }

            foreach (DocumentoReng reng in rengs)
            {
                if (reng.mone_liq == "USD")
                    reng.price_liq = Math.Round(reng.price_liq.Value / doc.tasa_usd, 2);
            }
        }

        private void InitAllFields()
        {
            Moneda usd = MonedaController.GetByID("USD");
            Moneda eur = MonedaController.GetByID("EUR");
            Moneda utv = MonedaController.GetByID("UTV");

            DE_Fecha.Value = DateTime.Now;
            TB_TasaUSD.Text = usd.tasa.ToString();
            TB_TasaEUR.Text = eur.tasa.ToString();
            TB_TasaPTR.Text = (60 * usd.tasa).ToString();
            TB_TasaEURUSD.Text = Math.Round(eur.tasa / usd.tasa, 2).ToString();
            TB_ValorUT.Text = utv.tasa.ToString();
            LBL_TotalRecibido.Text = "0,00";
            LBL_TotalRecibido_USD.Text = "0,00";
            LBL_TotalCancelado.Text = "0,00";
            LBL_TotalCancelado_USD.Text = "0,00";
            LBL_Balance.Text = "0,00";
            LBL_Balance_USD.Text = "0,00";
            GV_DocumentoReng.Columns[11].Visible = false;
            GV_DocumentoReng.Columns[12].Visible = false;
            GV_DocumentoReng.Columns[13].Visible = false;
        }

        private void BlockAllFields(int status)
        {
            if (status == 0 || status == 3)
            {
                DisableButton(BTN_PreCobrarDocumento);
                DisableButton(BTN_PreLiquidarDocumento);
                DisableButton(BTN_PreCerrarDocumento);

                if (status == 3)
                    DisableButton(BTN_PreEliminarDocumento);
            }

            if (status == 1 || status == 4 || status == 5 || status == 6)
            {
                GV_DocumentoReng.SettingsEditing.Mode = GridViewEditingMode.EditForm;
                GV_DocumentoReng.Columns[0].Visible = false;

                DisableButton(BTN_Guardar);
                DisableButton(BTN_PreRevisarDocumento);
                DisableButton(BTN_PreAprobarDocumento);

                if (status != 1)
                    DisableButton(BTN_PreCobrarDocumento);

                if (status != 4)
                    DisableButton(BTN_PreLiquidarDocumento);

                if (status != 5)
                    DisableButton(BTN_PreCerrarDocumento);

                DisableButton(BTN_PreEliminarDocumento);

                DE_Fecha.Enabled = false;
                DDL_Cliente.Enabled = false;
                DDL_Buque.Enabled = false;
                TB_Flag.Enabled = false;
                DDL_Puerto.Enabled = false;
                TB_Muelle.Enabled = false;
                TB_Horas.Enabled = false;
                TB_ValorUT.Enabled = false;
                TB_LOA.Enabled = false;
                TB_GRT.Enabled = false;
                TB_NRT.Enabled = false;
                TB_SDWT.Enabled = false;
                DE_FechaLlegada.Enabled = false;
                DE_FechaSalida.Enabled = false;
                TB_TasaUSD.Enabled = false;
                TB_TasaEUR.Enabled = false;
                TB_TasaPTR.Enabled = false;
                TB_TasaEURUSD.Enabled = false;
            }

            if (status == 2)
            {
                DisableButton(BTN_PreRevisarDocumento);
                DisableButton(BTN_PreAprobarDocumento);
                DisableButton(BTN_PreCobrarDocumento);
                DisableButton(BTN_PreLiquidarDocumento);
                DisableButton(BTN_PreCerrarDocumento);
                DisableButton(BTN_PreEliminarDocumento);
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

        private DateTime GetDateTime(string date, string time)
        {
            DateTime d = DateTime.Parse(date);
            DateTime t = DateTime.Parse(time);

            return new DateTime(d.Year, d.Month, d.Day, t.Hour, t.Minute, 0);
        }

        private void SetAmounts(Documento doc)
        {
            NumberFormatInfo formato = new NumberFormatInfo();
            formato.NumberDecimalSeparator = ",";
            formato.NumberGroupSeparator = ".";

            decimal tasa_usd = doc.tasa_usd;
            decimal cancelled = doc.DocumentoReng.ToList().Select(r => r.price_liq ?? 0).Sum();
            decimal balance = doc.collected_amount.Value - cancelled;

            LBL_TotalRecibido.Text = doc.collected_amount.Value.ToString("N2", formato);
            LBL_TotalRecibido_USD.Text = Math.Round(doc.collected_amount.Value / tasa_usd, 2).ToString("N2", formato);
            LBL_TotalCancelado.Text = cancelled.ToString("N2", formato);
            LBL_TotalCancelado_USD.Text = Math.Round(cancelled / tasa_usd, 2).ToString("N2", formato); ;
            LBL_Balance.Text = balance.ToString("N2", formato);
            LBL_Balance_USD.Text = Math.Round(balance / tasa_usd, 2).ToString("N2", formato);
        }
    }
}