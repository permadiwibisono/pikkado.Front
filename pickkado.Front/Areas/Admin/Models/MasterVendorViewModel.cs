using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Areas.Admin.Models
{
    public class Kota
    {
        public string Id { get; set; }
        public string Name { get; set; }
    }

    public class MasterVendorViewModel
    {
        public MasterVendorViewModel()
        {
            _kota = new List<Kota>();
            _kota.Add(new Kota { Id = "0", Name = "Jakarta Timur" });
            _kota.Add(new Kota { Id = "1", Name = "Jakarta Selatan" });
            _kota.Add(new Kota { Id = "2", Name = "Jakarta Barat" });
            _kota.Add(new Kota { Id = "3", Name = "Jakarta Utara" });
            _kota.Add(new Kota { Id = "4", Name = "Jakarta Pusat" });
        }

        private readonly List<Kota> _kota;
        public IEnumerable<SelectListItem> ListKota
        {
            get { return new SelectList(_kota, "Name", "Name"); }
        }

        [Required]
        [Display(Name = "Vendor Name")]
        public string Name { get; set; }
        [Required]
        [Display(Name = "Address")]
        public string Address { get; set; }
        
        [Display(Name = "Kelurahan :")]
        public string Kelurahan { get; set; }

        [Display(Name = "Kecamatan")]
        public string Kecamatan { get; set; }
        [Required]
        [Display(Name = "Kota")]
        public string Kota { get; set; }

        [Required]
        [Display(Name = "Phone Number")]
        public string PhoneNumber { get; set; }

        [Display(Name = "Web Address")]
        public string WebAddress { get; set; }

        [Required]
        [Display(Name = "Email")]
        public string Email { get; set; }

    }

    
}