using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Vendor.Models
{
    public class NewProductViewModel
    {
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
        public int Category { get; set; }
    }
}
