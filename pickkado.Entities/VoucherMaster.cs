using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class VoucherMaster:Entity
    {
        public string Name { get; set; }
        public float VoucherDiscount { get; set; }
        public string VoucherType { get; set; }//discount % or nominal
        public int Quantity { get; set; }
        public bool isLimitQty { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public float MinTransaction { get; set; }

        public virtual ICollection<UserVoucher> UserVoucher { get; set; }

    }
}
