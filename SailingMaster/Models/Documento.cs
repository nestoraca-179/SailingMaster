//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SailingMaster.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Documento
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Documento()
        {
            this.DocumentoReng = new HashSet<DocumentoReng>();
        }
    
        public int ID { get; set; }
        public string cuenta_buq { get; set; }
        public System.DateTime fecha { get; set; }
        public string cliente { get; set; }
        public string buque { get; set; }
        public string flag { get; set; }
        public int horas { get; set; }
        public string puerto { get; set; }
        public string muelle { get; set; }
        public decimal loa { get; set; }
        public decimal grt { get; set; }
        public decimal nrt { get; set; }
        public decimal sdwt { get; set; }
        public System.DateTime fec_llegada { get; set; }
        public System.DateTime fec_salida { get; set; }
        public decimal tasa_usd { get; set; }
        public decimal tasa_eur { get; set; }
        public decimal tasa_ptr { get; set; }
        public decimal eur_usd { get; set; }
        public decimal valor_ut { get; set; }
        public decimal total { get; set; }
        public int status { get; set; }
        public string approved_by { get; set; }
        public Nullable<System.DateTime> approved_date { get; set; }
        public string reviewed_by { get; set; }
        public Nullable<System.DateTime> reviewed_date { get; set; }
        public string reviewed_observ { get; set; }
        public string corrected_by { get; set; }
        public Nullable<System.DateTime> corrected_date { get; set; }
        public string collected_by { get; set; }
        public Nullable<System.DateTime> collected_date { get; set; }
        public Nullable<decimal> collected_amount { get; set; }
        public string collected_bank { get; set; }
        public Nullable<System.DateTime> collected_date_transf { get; set; }
        public string collected_nref_transf { get; set; }
        public string liquidated_by { get; set; }
        public Nullable<System.DateTime> liquidated_date { get; set; }
        public string closed_by { get; set; }
        public Nullable<System.DateTime> closed_date { get; set; }
        public string co_us_in { get; set; }
        public System.DateTime fe_us_in { get; set; }
        public string co_us_mo { get; set; }
        public System.DateTime fe_us_mo { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DocumentoReng> DocumentoReng { get; set; }
    }
}
