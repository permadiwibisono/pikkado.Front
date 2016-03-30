using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Admin.Models
{
    public class HomeViewModel
    {
        public HomeViewModel()
        {
        }
        public int NewUserMonth { get; set; }
        public int TotalUser { get; set; }
        public int NewVendorMonth { get; set; }
        public int TotalVendor { get; set; }
        public string ProductNamePopular { get; set; }
        public int TotalProductPopular { get; set; }
        public int TotalProduct { get; set; }
        public int TotalPackage { get; set; }
        public int TotalGiftcard { get; set; }
        public int NewOrderToday { get; set; }
        public int TotalOrder { get; set; }
        public int NewPatunganToday { get; set; }
        public int TotalPatungan { get; set; }
        public string Income { get; set; }
        public string Outcome { get; set; }
        public int OnPaymentChecking { get; set; }
        public int OnProccess { get; set; }
        public int OnCancelled { get; set; }
        public int OnSuccess { get; set; }
        public PostalCodeViewModel postalcode { get; set; }
    }
}
