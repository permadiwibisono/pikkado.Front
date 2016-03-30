using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace pickkado.Front.Areas.Admin.Models
{
    public class MasterGiftCardViewModel
    {
        [Required]
        [Display(Name = "Package Name :")]
        public string Name { get; set; }
        [Required]
        [Display(Name = "Quantity :")]
        public int Quantity { get; set; }
        [Required]
        [Display(Name = "Price (Rp) :")]
        [DataType(DataType.Currency)]
        public float Price { get; set; }
        public bool Visible { get; set; }
        public HttpPostedFileBase imagepost { get; set; }
        public byte[] image { get; set; }
    }
}