using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SailingMaster.Controllers
{
    public class BancoController : Repository
    {
        public static Banco GetByID(string id)
        {
            return db.Banco.Single(s => s.ID == id);
        }
    }
}