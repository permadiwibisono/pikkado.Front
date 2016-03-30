using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class ProductStore:Entity
    {
        public string StoreId { get; set; }
        public string ProductId { get; set; }

        public virtual Store Store { get; set; }
        public virtual Product Product { get; set; }
    }
}
