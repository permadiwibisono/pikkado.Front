using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Store:Entity
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string Kelurahan { get; set; }
        public string Kecamatan { get; set; }
        public string Kota { get; set; }
        public string PhoneNumber { get; set; }
        public string WebAddress { get; set; }
        public string Email { get; set; }
        public ICollection<ProductStore> ProductStores { get; set; }
    }
}
