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
    
        public string ID { get; set; }
        public System.DateTime fecha { get; set; }
        public string cliente { get; set; }
        public string puerto { get; set; }
        public string buque { get; set; }
        public string nro_viaje { get; set; }
        public string co_mone { get; set; }
        public decimal tasa { get; set; }
        public System.DateTime fec_llegada { get; set; }
        public System.DateTime fec_salida { get; set; }
        public int num_toneladas { get; set; }
        public decimal total { get; set; }
        public int status { get; set; }
        public string approved_by { get; set; }
        public Nullable<System.DateTime> approved_date { get; set; }
        public string reviewed_by { get; set; }
        public Nullable<System.DateTime> reviewed_date { get; set; }
        public string reviewed_observ { get; set; }
        public string liquidated_by { get; set; }
        public Nullable<System.DateTime> liquidated_date { get; set; }
        public Nullable<decimal> liquidated_amount { get; set; }
        public Nullable<System.DateTime> liquidated_date_transf { get; set; }
        public string liquidated_nref_transf { get; set; }
        public string closed_by { get; set; }
        public Nullable<System.DateTime> closed_date { get; set; }
        public string co_us_in { get; set; }
        public System.DateTime fe_us_in { get; set; }
        public string co_us_mo { get; set; }
        public System.DateTime fe_us_mo { get; set; }
    
        public virtual Moneda Moneda { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DocumentoReng> DocumentoReng { get; set; }
    }
}