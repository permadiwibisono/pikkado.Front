using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Brand:Entity
    {
        public string Name { get; set; }
        public ICollection<Product> Products { get; set; }
    }
}
