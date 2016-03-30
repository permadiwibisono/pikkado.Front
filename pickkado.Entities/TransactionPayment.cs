using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class TransactionPayment:Entity
    {
        public string TransactionId { get; set; }
        public virtual Transaction Transaction { get; set; }

        public string UserId { get; set; }
        public virtual User user { get; set; }
        
        public DateTime TanggalPembayaran { get; set; }

        public string PaymentType { get; set; }

        public string NoRekening { get; set; }
        public string NamaRekening { get; set; }
        public string NamaBank { get; set; }
        public string CabangBank { get; set; }
        public string NoStrukPembayaran { get; set; }
        public string StatusPembayaran { get; set; }

        public string NoRekeningTujuan { get; set; }
        public string NamaRekeningTujuan { get; set; }
        public string NamaBankTujuan { get; set; }
        public string CabangBankTujuan { get; set; }
        public double TotalDiBayar { get; set; }
        public string Remarks { get; set; }

        public byte[] BuktiPembayaran { get; set; }


    }
}
