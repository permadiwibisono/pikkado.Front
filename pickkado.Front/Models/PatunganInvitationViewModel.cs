using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace pickkado.Front.Models
{
    public class PatunganInvitationViewModel
    {
        public PatunganInvitationViewModel()
        {
            Status = new List<PatunganInvitationStatusViewModel>();
        }

        public string TransId { get; set; }
        public string TransStatus { get; set; }
        public byte[] UserImage { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public DateTime TransDate { get; set; }
        public string PatunganTitle { get; set; }
        public string ProductName { get; set; }
        public byte[] ProductImage { get; set; }
        public string PatunganDescription { get; set; }
        public DateTime BatasWaktuPelunasan { get; set; }
        public double TotalPembayaran { get; set; }
        public List<PatunganInvitationStatusViewModel> Status { get; set; }
    }

    public class PatunganInvitationStatusViewModel
    {
        public string TransactionMemberGroupsId { get; set; }
        public string UserId { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Status { get; set; }
        public double Price { get; set; }
        public string PriceToRupiah { get; set; }
    }

}