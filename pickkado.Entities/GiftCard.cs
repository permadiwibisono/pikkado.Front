using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class GiftCard:Entity
    {
        public string Name { get; set; }
        public byte[] Image { get; set; }
        public float Price { get; set; }
        public int Quantity { get; set; }
        public bool Visible { get; set; }
    }
}
