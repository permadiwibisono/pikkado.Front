using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class ProductThumbnail:Entity
    {
        public string ProductId { get; set; }
        public virtual Product product { get; set; }
        public byte[] Image { get; set; }
    }
}
