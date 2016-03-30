using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class NoRekeningPickkado:Entity
    {
        public string AtasNama { get; set; }
        public string NomorRekening { get; set; }
        public string Bank { get; set; }
        public string CabangBank { get; set; }
        public bool Visible { get; set; }
    }
}
