using System;
using SailingMaster.Models;

namespace SailingMaster
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER"] != null)
            {
                Usuario user = Session["USER"] as Usuario;
                LBL_User.Text = user.des_usuario;

                if (user.tip_usuario != 0)
                {
                    item_users.Attributes.Add("class", "btn disabled");
                    item_prods.Attributes.Add("class", "btn disabled");
                    item_users.Attributes.Add("href", "#");
                    item_prods.Attributes.Add("href", "#");
                }

                item_reps.Attributes.Add("class", "btn disabled");
                item_ports.Attributes.Add("class", "btn disabled");
                item_banks.Attributes.Add("class", "btn disabled");
                item_currencies.Attributes.Add("class", "btn disabled");
                item_reps.Attributes.Add("href", "#");
                item_ports.Attributes.Add("href", "#");
                item_banks.Attributes.Add("href", "#");
                item_currencies.Attributes.Add("href", "#");
            }
            else
                Response.Redirect("/Login.aspx");
        }
    }
}