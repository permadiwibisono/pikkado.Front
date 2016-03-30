using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;


namespace pickkado.Front.Models
{
    public class CategoryViewModel
    {
        [Required(ErrorMessage="Choose your category")]
        public string CategoryId{ get; set; }
        [Required]
        public double Budget { get; set; }
    }
    public class PackageViewModel
    {
        [Required(ErrorMessage = "Choose your package")]
        public string PackageId { get; set; }
        public pickkado.Entities.Package package { get; set; }
        [Required(ErrorMessage = "Choose your giftcard")]
        public string GiftcardId { get; set; }
        public pickkado.Entities.GiftCard giftcard { get; set; }
    }

    public class PackagePartialView
    {
        public List<pickkado.Entities.Package> List { get; set; }
        public string PackageSelected { get; set; }
    }
    public class GiftCardPartialView
    {
        public List<pickkado.Entities.GiftCard> List { get; set; }
        public string GiftcardSelected { get; set; }
    }
}