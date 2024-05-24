using SailingMaster.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace SailingMaster.Controllers
{
    public class DocumentoController : Repository
    {
        public static Documento GetByID(string id)
        {
            return db.Documento.Single(d => d.ID == id);
        }

        public static int Add(Documento doc)
        {
            int result = 0;

            using (SailingMasterEntities context = new SailingMasterEntities())
            {
                using (DbContextTransaction tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        Documento d = context.Documento.Add(doc);
                        context.DocumentoReng.AddRange(doc.DocumentoReng);
                        context.SaveChanges();
                        tran.Commit();

                        LogController.CreateLog(d.co_us_in, "DOCUMENTO", d.ID, "I", null);
                        result = 1;
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        IncidentController.CreateIncident(string.Format("ERROR AGREGANDO DOCUMENTO N° {0}", doc.ID), ex);
                    }
                }
            }

            return result;
        }
    }
}