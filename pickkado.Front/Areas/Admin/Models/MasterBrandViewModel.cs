using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace pickkado.Front.Areas.Admin.Models
{
    public class MasterBrandViewModel
    {
        [Required]
        [Display(Name="Brand Name :")]
        public string Name { get; set; }
    }
}
