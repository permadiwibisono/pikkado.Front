using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class TransactionMemberGroup:Entity
    {
        public string TransactionId { get; set; }
        public virtual Transaction transaction { get; set; }

        public string UserId { get; set; }
        public virtual User user { get; set; }

        public string Email { get; set; }
        public string Name { get; set; }
        public float Price { get; set; }
        public bool IsAccept { get; set; }
        public bool IsResponse { get; set; }
    }
}
