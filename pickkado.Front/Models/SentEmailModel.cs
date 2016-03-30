using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Models
{
    public class SentEmailModel
    {
        public string ToEmail { get; set; }
        public string ToName { get; set; }
        public string FromName { get; set; }
        public string FromEmail { get; set; }
        public string TemplateEmail { get; set; }
        //public byte[] Logo { get; set; }

    }
    public class InviteGiftCardSentEmailModel:SentEmailModel
    {
        public string InviteMessage { get; set; }
        public string BatasWaktu { get; set; }
        public string Link { get; set; }
    }
    public class InvitePatunganSentEmailModel : SentEmailModel
    {
        public string InviteMessage { get; set; }
        public string JumlahPatungan { get; set; }
        public string BatasWaktu { get; set; }
        public string Link { get; set; }
        public string PenerimaKado { get; set; }
    }
    public class StrukSentEmailModel : SentEmailModel
    {
        public string TransactionId { get; set; }
        public string ProductName { get; set; }
        public string TanggalPengiriman { get; set; }
        public string Patungan { get; set; }
        public string TotalProduct { get; set; }
        public string TotalGiftcard { get; set; }
        public string TotalPackage { get; set; }
        public string OngkosKirim { get; set; }
        public string ServiceFee { get; set; }
        public string TOTAL { get; set; }
        public string BatasWaktu { get; set; }
    }
    public class StrukPatunganSentEmailModel : SentEmailModel
    {
        public string TransactionId { get; set; }
        public string ProductName { get; set; }
        public string TanggalPengiriman { get; set; }
        //public string Patungan { get; set; }
        public string TotalProduct { get; set; }
        public string TotalGiftcard { get; set; }
        public string TotalPackage { get; set; }
        public string OngkosKirim { get; set; }
        public string ServiceFee { get; set; }
        public string TOTAL { get; set; }
        public string BatasWaktu { get; set; }
        public string DaftarMemberPlainHtml { get; set; }
    }
}
