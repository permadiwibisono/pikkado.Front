using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class PostalCode:Entity
    {
        public string Kelurahan { get; set; }
        public string Kecamatan { get; set; }
        public string Kabupaten { get; set; }
        public string Provinsi { get; set; }
        public string Kodepos { get; set; }
    }
}
