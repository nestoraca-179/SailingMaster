﻿using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SailingMaster.Servicios
{
    public partial class Agregar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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

        protected void BTN_Volver_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Servicios/Index.aspx");
        }

        protected void BTN_Guardar_Click(object sender, EventArgs e)
        {
            //Usuario user = new Usuario();

            //try
            //{
            //    user.username = TB_Username.Text;
            //    user.password = SecurityController.Encrypt(TB_Password.Text);
            //    user.descrip = TB_Descrip.Text;
            //    user.email = TB_Email.Text;
            //    user.activo = CK_Activo.Checked;
            //    user.tip_usuario = byte.Parse(DDL_TipoUsuario.Value.ToString());
            //    user.co_us_in = (Session["USER"] as Usuario).username;
            //    user.fe_us_in = DateTime.Now;
            //    user.co_us_mo = (Session["USER"] as Usuario).username;
            //    user.fe_us_mo = DateTime.Now;

            //    int result = UsuarioController.Add(user);

            //    if (result == 1)
            //    {
            //        Response.Redirect("/Usuarios/Index.aspx?new_user=1");
            //    }
            //    else
            //    {
            //        PN_Error.Visible = true;
            //        LBL_Error.Text = "Ha ocurrido un error al agregar el Usuario. Ver tabla de Incidentes";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    PN_Error.Visible = true;
            //    LBL_Error.Text = "Ha ocurrido un error. Ver tabla de Incidentes";
            //    IncidentController.CreateIncident(string.Format("ERROR PROCESANDO DATOS DEL USUARIO {0}", user.ID), ex);
            //}
        }
    }
}