using SailingMaster.Models;
using System.Linq;

namespace SailingMaster.Controllers
{
    public class MonedaController : Repository
    {
        public static Moneda GetByID(string id)
        {
            return db.Moneda.Single(m => m.ID == id);
        }
    }
}