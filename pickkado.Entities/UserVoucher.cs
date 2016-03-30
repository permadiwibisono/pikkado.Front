using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class UserVoucher:Entity
    {
        public string UserId { get; set; }
        public virtual User User { get; set; }

        public string VoucherMasterId { get; set; }
        public virtual VoucherMaster VoucherMaster { get; set; }

        public float VoucherDiscount { get; set; }
        public string CategoryName { get; set; }
        public int Quantity { get; set; }
        public DateTime DueDate { get; set; }
        public float MinTransaction { get; set; }
        public bool IsUsed { get; set; }
    }
}
