using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Models
{
    public class InputPatunganViewModel
    {
        public InputPatunganViewModel()
        {
            Status = new List<PatunganInvitationStatusViewModel>();
        }

        public string Id { get; set; }
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
        public string ToUserName { get; set; }
        public List<PatunganInvitationStatusViewModel> Status { get; set; }

        public string EmailLogin { get; set; }
        public string PasswordLogin { get; set; }
        public string EmailRegister { get; set; }
        public string PasswordRegister { get; set; }
        [Compare("PasswordRegister", ErrorMessage = "'Password' untuk register kamu tidak sama dengan 'Confirm Password'")]
        public string ConfirmPasswordRegister { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
    }
}