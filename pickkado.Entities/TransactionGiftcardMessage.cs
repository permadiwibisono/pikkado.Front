using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class TransactionGiftcardMessage:Entity
    {
        public string TransactionId { get; set; }
        public virtual Transaction transaction { get; set; }

        public string UserId { get; set; }
        public virtual User user { get; set; }

        public string Email { get; set; }
        public string Name { get; set; }
        public string Message { get; set; }
        public DateTime BatasWaktu { get; set; }
        public Guid ShareCode { get; set; }
    }
}
