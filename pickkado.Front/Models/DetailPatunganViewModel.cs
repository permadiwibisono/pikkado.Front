using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace pickkado.Front.Models
{
    public class DetailPatunganViewModel
    {
        public DetailPatunganViewModel()
        {
            StatusPembayaran = new List<StatusPembayaranViewModel>();
        }

        public string TransId { get; set; }
        public DateTime BatasWaktuPelunasan { get; set; }
        public double TotalPembayaran { get; set; }
        public double PembayaranYangTerkumpul { get; set; }
        public List<StatusPembayaranViewModel> StatusPembayaran { get; set; }
    }

    public class StatusPembayaranViewModel
    {
        public string Name { get; set; }
        public string Status { get; set; }
        public double JumlahPembayaran { get; set; }
    }

}