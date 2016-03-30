using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Admin.Models
{
    public class MasterVoucherViewModel
    {
        [Required]
        [Display(Name = "Voucher Id")]
        public string VoucherId { get; set; }

        [Required]
        [Display(Name = "Voucher Name")]
        public string Name { get; set; }

        [Required]
        [Display(Name = "Voucher Type")]
        public string VoucherType { get; set; }

        [Required]
        [RegularExpression("^[0-9]+$")]
        [Display(Name = "Voucher Discount")]
        public float VoucherDiscount { get; set; }

        [Required]
        [RegularExpression("^[0-9]+$")]
        [Display(Name = "Quantity")]
        public int Quantity { get; set; }

        [Required]
        [Display(Name = "Limit by Quantity?")]
        public bool IsLimitQty { get; set; }
        [Required]
        [Display(Name = "From")]
        public DateTime FromDate { get; set; }

        [Required]
        [Display(Name = "To")]
        public DateTime ToDate { get; set; }

        [Required]
        [RegularExpression("^[0-9]+$")]
        [Display(Name = "Min. Transaction")]
        public float MinTransaction { get; set; }
    }
}
