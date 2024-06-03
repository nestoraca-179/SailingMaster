using System;
using System.Drawing;
using SailingMaster.Models;

namespace SailingMaster.Documentos
{
    public partial class Index : System.Web.UI.Page
    {
        private static string IDSelected;

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
                    if (Request.QueryString["new_doc"] != null)
                    {
                        string value = Request.QueryString["new_doc"].ToString();
                        PN_Success.Visible = true;

                        switch (value)
                        {
                            case "0":
                                LBL_Success.Text = "Documento generado con éxito";
                                break;
                            case "1":
                                LBL_Success.Text = "Documento aprobado con éxito";
                                break;
                            case "2":
                                LBL_Success.Text = "Documento revisado con éxito";
                                break;
                            case "3":
                                LBL_Success.Text = "Documento modificado con éxito";
                                break;
                            case "4":
                                LBL_Success.Text = "Documento cobrado con éxito";
                                break;
                            case "5":
                                LBL_Success.Text = "Documento liquidado con éxito";
                                break;
                            case "6":
                                LBL_Success.Text = "Documento cerrado con éxito";
                                break;
                            case "-1":
                                LBL_Success.Text = "Documento eliminado con éxito";
                                break;
                        }
                    }
                }
            }
            else
                Response.Redirect("/Login.aspx");
        }

        protected void BTN_AgregarDocumento_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Documentos/DocumentPage.aspx");
        }

        protected void GV_Documentos_RowCommand(object sender, DevExpress.Web.ASPxGridViewRowCommandEventArgs e)
        {
            IDSelected = e.KeyValue.ToString();
            if (e.CommandArgs.CommandName == "Revisar")
            {
                Response.Redirect("/Documentos/DocumentPage.aspx?ID=" + IDSelected);
            }
        }

        protected void GV_Documentos_HtmlRowPrepared(object sender, DevExpress.Web.ASPxGridViewTableRowEventArgs e)
        {
            if (e.RowType == DevExpress.Web.GridViewRowType.Data)
            {
                if (e.VisibleIndex % 2 == 0)
                    e.Row.BackColor = ColorTranslator.FromHtml("#26272a");
                else
                    e.Row.BackColor = ColorTranslator.FromHtml("#333438");
            }
        }

        protected void GV_Documentos_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e)
        {
            if (e.DataColumn.FieldName == "doc_status")
            {
                switch (e.CellValue.ToString())
                {
                    case "GENERADO":
                        e.Cell.BackColor = ColorTranslator.FromHtml("#04574B");
                        break;
                    case "APROBADO":
                        e.Cell.BackColor = ColorTranslator.FromHtml("#034426");
                        break;
                    case "REVISADO":
                        e.Cell.BackColor = ColorTranslator.FromHtml("#664f08");
                        break;
                    case "CORREGIDO":
                        e.Cell.BackColor = ColorTranslator.FromHtml("#424851");
                        break;
                    case "COBRADO":
                        e.Cell.BackColor = ColorTranslator.FromHtml("#062655");
                        break;
                    case "LIQUIDADO":
                        e.Cell.BackColor = ColorTranslator.FromHtml("#733f08");
                        break;
                    case "CERRADO":
                        e.Cell.BackColor = ColorTranslator.FromHtml("#60040d");
                        break;
                }
            }
        }
    }
}