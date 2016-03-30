using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class TransactionProductAttribute:Entity
    {
        public string TransactionId { get; set; }
        public virtual Transaction transaction { get; set; }

        public string ProductId { get; set; }
        public virtual Product product { get; set; }

        public string Name { get; set; }
        public string Value { get; set; }
    }
}
