using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SailingMaster.Controllers
{
    public class BuqueController : Repository
    {
        public static Buque GetByID(int id)
        {
            return db.Buque.Single(s => s.ID == id);
        }
    }
}