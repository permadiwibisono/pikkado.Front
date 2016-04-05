using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class VendorPayment:Entity
    {
        public string TransactionId { get; set; }
        public virtual Transaction transaction { get; set; }

        public float Price { get; set; }
        public float OngkosKirim { get; set; }
        public string ResiNumber { get; set; }
        public string Remarks { get; set; }
        public string AlamatPickkado { get; set; }
        public string NamaKurir { get; set; }
        public string JenisPaket { get; set; }
        public bool IsAccepted { get; set; }
        public bool IsDeliver { get; set; }
        public bool IsDelivered { get; set; }
        public bool IsPaid { get; set; }
    }
}
