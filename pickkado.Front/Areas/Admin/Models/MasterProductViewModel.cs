using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace pickkado.Front.Areas.Admin.Models
{
    public class MasterProductViewModel
    {
        [Required]
        [Display(Name = "Brand :")]
        public string Brand { get; set; }
        [Required]
        [Display(Name = "Name :")]
        public string Name { get; set; }
        [Required]
        [Display(Name = "Weight :")]
        public float Weight { get; set; }
        [Required]
        [Display(Name = "Description :")]
        public string Description { get; set; }
        [Required]
        [Display(Name = "Gender :")]
        public string Gender { get; set; }
        [Required]
        [Display(Name = "Price (Rp) :")]
        [DataType(DataType.Currency)]
        public float Price { get; set; }
        [Required]
        [Display(Name = "Category :")]
        public string Category { get; set; }
    }
}