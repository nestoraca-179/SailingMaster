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
    
    public partial class Servicio
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Servicio()
        {
            this.DocumentoReng = new HashSet<DocumentoReng>();
            this.PrecioServicio = new HashSet<PrecioServicio>();
        }
    
        public string ID { get; set; }
        public string des_serv { get; set; }
        public int tip_serv { get; set; }
        public string co_mone { get; set; }
        public decimal precio_base { get; set; }
        public bool activo { get; set; }
        public string co_us_in { get; set; }
        public System.DateTime fe_us_in { get; set; }
        public string co_us_mo { get; set; }
        public System.DateTime fe_us_mo { get; set; }
        public decimal precio_min { get; set; }
        public decimal precio_max { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DocumentoReng> DocumentoReng { get; set; }
        public virtual Moneda Moneda { get; set; }
        public virtual TipoServicio TipoServicio { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PrecioServicio> PrecioServicio { get; set; }
    }
}
