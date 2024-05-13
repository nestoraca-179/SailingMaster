using System;
using SailingMaster.Models;

namespace SailingMaster.Controllers
{
    public class LogController : Repository
    {
        public static void CreateLog(string user, string item, int id_item, string action, string campos)
        {
            using (SailingMasterEntities context = new SailingMasterEntities())
            {
                Log log = new Log();

                log.fecha = DateTime.Now;
                log.usuario = user;
                log.item = item;
                log.id_item = id_item;
                log.accion = action;
                log.campos = campos;

                context.Log.Add(log);
                context.SaveChanges();
            }
        }
    }
}