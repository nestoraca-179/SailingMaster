using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Reflection;

namespace SailingMaster.Controllers
{
    public class ServicioController : Repository
    {
        public static Servicio GetByID(string id)
        {
            return db.Servicio.Single(s => s.ID == id);
        }

        public static int Add(Servicio serv)
        {
            int result = 0;

            using (SailingMasterEntities context = new SailingMasterEntities())
            {
                using (DbContextTransaction tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        Servicio s = context.Servicio.Add(serv);
                        context.SaveChanges();
                        tran.Commit();

                        LogController.CreateLog(s.co_us_in, "SERVICIO", s.ID, "I", null);
                        result = 1;
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        IncidentController.CreateIncident(string.Format("ERROR AGREGANDO SERVICIO N° {0}", serv.ID), ex);
                    }
                }
            }

            return result;
        }

        public static int Edit(Servicio serv)
        {
            int result = 0;

            try
            {
                Servicio existing = GetByID(serv.ID);
                serv.co_us_in = existing.co_us_in;
                serv.fe_us_in = existing.fe_us_in;

                string campos = GetChanges(existing, serv);

                db.Entry(existing).CurrentValues.SetValues(serv);
                db.SaveChanges();

                LogController.CreateLog(serv.co_us_mo, "SERVICIO", serv.ID, "M", campos);
                result = 1;
            }
            catch (Exception ex)
            {
                IncidentController.CreateIncident(string.Format("ERROR MODIFICANDO SERVICIO N° {0}", serv.ID), ex);
            }

            return result;
        }

        public static int Delete(string ID, string us)
        {
            int result = 0;
            Servicio serv = GetByID(ID);

            try
            {
                Servicio s = db.Servicio.Remove(serv);
                db.SaveChanges();

                LogController.CreateLog(us, "SERVICIO", s.ID, "E", null);
                result = 1;
            }
            catch (Exception ex)
            {
                IncidentController.CreateIncident(string.Format("ERROR ELIMINANDO SERVICIO N° {0}", serv.ID), ex);
            }

            return result;
        }

        public static bool HasRange(string id)
        {
            return db.PrecioServicio.Any(ps => ps.co_serv.Equals(id, StringComparison.OrdinalIgnoreCase));
        }

        public static decimal GetPriceServ(string id, Buque buque)
        {
            // Por defecto, siempre vamos a tomar el primer campo
            string campo = db.PrecioServicio.AsNoTracking().Where(p => p.co_serv == id).Select(p => p.campo_valor).Distinct().ToList()[0];
            decimal valor = 0;

            if (campo == "GRT")
                valor = buque.grt;
            else if (campo == "LOA")
                valor = buque.loa;

            PrecioServicio precio = db.PrecioServicio.AsNoTracking().Single(p => p.co_serv == id && p.desde <= valor && p.hasta >= valor);

            return precio.precio_base;
        }

        private static string GetChanges(Servicio user_v, Servicio user_n)
        {
            string campos = "";
            Type type = new Servicio().GetType();

            foreach (PropertyInfo prop in type.GetProperties())
            {
                if (prop.Name != "fe_us_in" && prop.Name != "fe_us_mo")
                {
                    string valor1 = prop.GetValue(user_v) == null ? "" : prop.GetValue(user_v).ToString();
                    string valor2 = prop.GetValue(user_n) == null ? "" : prop.GetValue(user_n).ToString();

                    if (valor1 != valor2)
                    {
                        campos += string.Format("{0}: {1} -> {2}; ", prop.Name, valor1, valor2);
                    }
                }
            }

            return campos;
        }
    }
}