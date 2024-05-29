using SailingMaster.Models;
using System;
using System.Data.Entity;
using System.Linq;
using System.Reflection;

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

        public static int Edit(Documento doc)
        {
            int result = 0;

            try
            {
                Documento existing = GetByID(doc.ID);
                string campos = GetChanges(existing, doc);
                db.Entry(doc).State = EntityState.Modified;
                db.SaveChanges();

                LogController.CreateLog(doc.co_us_mo, "DOCUMENTO", doc.ID.ToString(), "M", campos);
                result = 1;
            }
            catch (Exception ex)
            {
                IncidentController.CreateIncident(string.Format("ERROR MODIFICANDO DOCUMENTO N° {0}", doc.ID), ex);
            }

            return result;
        }

        private static string GetChanges(Documento doc_v, Documento doc_n)
        {
            string campos = "";
            Type type = new Documento().GetType();

            foreach (PropertyInfo prop in type.GetProperties())
            {
                if (prop.Name != "fe_us_in" && prop.Name != "fe_us_mo")
                {
                    string valor1 = prop.GetValue(doc_v) == null ? "" : prop.GetValue(doc_v).ToString();
                    string valor2 = prop.GetValue(doc_n) == null ? "" : prop.GetValue(doc_n).ToString();

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