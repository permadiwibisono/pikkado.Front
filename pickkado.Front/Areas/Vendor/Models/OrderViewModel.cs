using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Vendor.Models
{
    public class OrderViewModel
    {
        public string Id { get; set; }
        public string PaymentId { get; set; }
        public string ProductName { get; set; }
        public DateTime BatasWaktu { get; set; }
        public string Price { get; set; }
        public string Remarks { get; set; }
        public string NoResi { get; set; }
        public string Status { get; set; }
    }
}
