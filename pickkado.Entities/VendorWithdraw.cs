using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class VendorWithdraw:Entity
    {
        public DateTime WithdrawDate { get; set; }
        public bool Approval { get; set; }
        public bool IsApprove { get; set; }
        public bool IsTransfered { get; set; }
        public float Ammount { get; set; }
        public ICollection<VendorWithdrawDetail> VendorWithdrawDetails { get; set; }
    }
    public class VendorWithdrawDetail:Entity
    {
        public string VendorPaymentId { get; set; }
        public string AtasNama { get; set; }
        public string NomorRekening { get; set; }
        public string Bank { get; set; }
        public string CabangBank { get; set; }
        public string FromAtasNama { get; set; }
        public string FromNomorRekening { get; set; }
        public string FromBank { get; set; }
        public string FromCabangBank { get; set; }
        public virtual VendorPayment VendorPayment { get; set; }

    }
}
