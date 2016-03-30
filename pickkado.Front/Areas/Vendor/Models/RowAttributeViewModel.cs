using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace pickkado.Front.Areas.Vendor.Models
{
    public class NewAttributeViewModel
    {
        //[Required]
        //[Display(Name = "Id")]
        //public string Id { get; set; }
        [Required]
        [Display(Name = "Type")]
        public string AttributeId { get; set; }
        [Required]
        [Display(Name = "Values")]
        public string Values { get; set; }
        //[Display(Name = "Type")]
        //public string Type { get; set; }
        [Display(Name = "Disabled")]
        public bool Disabled { get; set; }
    }
    public class EditAttributeViewModel
    {
        [Required]
        [Display(Name = "Id")]
        public string Id { get; set; }
        [Required]
        [Display(Name = "Type")]
        public string AttributeId { get; set; }
        [Required]
        [Display(Name = "Values")]
        public string Values { get; set; }
        //[Display(Name = "Type")]
        //public string Type { get; set; }
        [Display(Name = "Disabled")]
        public bool Disabled { get; set; }
    }
}