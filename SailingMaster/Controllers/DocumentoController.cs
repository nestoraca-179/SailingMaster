using SailingMaster.Models;
using System;
using System.Data.Entity;
using System.Linq;

namespace SailingMaster.Controllers
{
    public class DocumentoController : Repository
    {
        public static Documento GetByID(int id)
        {
            Documento doc = db.Documento.AsNoTracking().Include("DocumentoReng").Single(d => d.ID == id);

            foreach (DocumentoReng r in doc.DocumentoReng)
                r.Documento = null;

            return doc;
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

                        LogController.CreateLog(d.co_us_in, "DOCUMENTO", d.ID.ToString(), "I", null);
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