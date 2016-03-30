using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class ProductAttribute:Entity
    {
        public string MasterProductAttributeId { get; set; }
        public virtual MasterProductAttribute master { get; set; }
        public string ProductId { get; set; }
        public virtual Product product { get; set; }
        public string Value { get; set; }
        public bool Disabled { get; set; }
    }
}
