using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Destination:Entity
    {
        public string DestinationName { get; set; }
        public string UserId { get; set; }
        public string Address { get; set; }
        public string Kelurahan { get; set; }
        public string Kecamatan { get; set; }
        public string Kota { get; set; }

        public virtual User User { get; set; }

    }
}
