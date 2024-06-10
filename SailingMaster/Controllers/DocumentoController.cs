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

            using (SailingMasterEntities context = new SailingMasterEntities())
            {
                using (DbContextTransaction tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        Documento existing = GetByID(doc.ID);
                        string campos = GetChanges(existing, doc);
                        context.Entry(doc).State = EntityState.Modified;

                        foreach (DocumentoReng r in doc.DocumentoReng)
                        {
                            if (r.co_us_in == null) // NUEVO
                            {
                                r.co_us_in = r.co_us_mo;
                                r.fe_us_in = r.fe_us_mo;
                                context.DocumentoReng.Add(r);
                            }
                            else // EXISTENTE
                                context.Entry(r).State = EntityState.Modified;
                        }

                        context.SaveChanges();
                        tran.Commit();

                        LogController.CreateLog(doc.co_us_mo, "DOCUMENTO", doc.ID.ToString(), "M", campos);
                        result = 1;
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        IncidentController.CreateIncident(string.Format("ERROR MODIFICANDO DOCUMENTO N° {0}", doc.ID), ex);
                    }
                }
            }

            return result;
        }

        public static int Delete(int ID, string us)
        {
            int result = 0;
            Documento doc = GetByID(ID);

            try
            {
                Documento d = db.Documento.Remove(doc);
                db.SaveChanges();

                LogController.CreateLog(us, "DOCUMENTO", d.ID.ToString(), "E", null);
                result = 1;
            }
            catch (Exception ex)
            {
                IncidentController.CreateIncident(string.Format("ERROR ELIMINANDO DOCUMENTO N° {0}", doc.ID), ex);
            }

            return result;
        }

        public static int LiqReng(DocumentoReng reng)
        {
            int result = 0;

            using (SailingMasterEntities context = new SailingMasterEntities())
            {
                using (DbContextTransaction tran = context.Database.BeginTransaction())
                {
                    try
                    {
                        DocumentoReng existing = context.DocumentoReng.AsNoTracking().Single(r => r.co_doc == reng.co_doc && r.reng_num == reng.reng_num);
                        string campos = GetChangesReng(existing, reng);
                        context.Entry(reng).State = EntityState.Modified;
                        context.SaveChanges();
                        tran.Commit();

                        LogController.CreateLog(reng.co_us_mo, "DOCUMENTO RENGLON", string.Format("{0}-{1}", reng.co_doc, reng.reng_num), "M", campos);
                        result = 1;
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        IncidentController.CreateIncident(string.Format("ERROR MODIFICANDO DOCUMENTO RENGLON N° {0}-{1}", reng.co_doc, reng.reng_num), ex);
                    }
                }
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

        private static string GetChangesReng(DocumentoReng reng_v, DocumentoReng reng_n)
        {
            string campos = "";
            Type type = new DocumentoReng().GetType();

            foreach (PropertyInfo prop in type.GetProperties())
            {
                if (prop.Name != "fe_us_in" && prop.Name != "fe_us_mo")
                {
                    string valor1 = prop.GetValue(reng_v) == null ? "" : prop.GetValue(reng_n).ToString();
                    string valor2 = prop.GetValue(reng_v) == null ? "" : prop.GetValue(reng_n).ToString();

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