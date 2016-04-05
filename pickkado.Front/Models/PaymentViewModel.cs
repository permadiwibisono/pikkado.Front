using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Models
{
    public class CityAPI
    {
        public string Code { get; set; }
        public string Description { get; set; }

    }
    public class DariRekening
    {
        public string Id { get; set; }
        public string Name { get; set; } 
    }

    public class RekeningTujuan
    {
        public string Id { get; set; }
        public string Name { get; set; }
    }

    public class PaymentConfirmViewModel
    {
        private Db.PickkadoDBContext db = new Db.PickkadoDBContext();

        public PaymentConfirmViewModel()
        {

            _dariRekening = new List<DariRekening>();

            _dariRekening.Add(new DariRekening { Id = "-1", Name = "Dari Rekening*" });
            var RekeningUser = db.NoRekening.Where(a => a.UserId == "U2016020414565050").ToList(); // nanti diganti dari userlogin.userid
            for (int i = 0; i < RekeningUser.Count; i++)
            {
                _dariRekening.Add(new DariRekening { Id = RekeningUser[i].Id, Name = RekeningUser[i].AtasNama + " - " + RekeningUser[i].NomorRekening + " - " + RekeningUser[i].Bank + " - " + RekeningUser[i].CabangBank });
            }
            //_dariRekening.Add(new DariRekening { Id = "5", Name = "Budi Fajri Arzi - 6040845231 - BCA - Alam Sutera" });
            _dariRekening.Add(new DariRekening { Id = "0", Name = "Rekening Baru" });

            _rekeningTujuan = new List<RekeningTujuan>();
            _rekeningTujuan.Add(new RekeningTujuan { Id = "-1", Name = "Rekening Tujuan*" });
            var RekeningPickkado = db.NoRekeningPickkado.Where(a => a.Visible).ToList();
            for (int i = 0; i < RekeningPickkado.Count; i++)
            {
                _rekeningTujuan.Add(new RekeningTujuan { Id = RekeningPickkado[i].Id, Name = RekeningPickkado[i].AtasNama + " - " + RekeningPickkado[i].NomorRekening + " - " + RekeningPickkado[i].Bank + " - " + RekeningPickkado[i].CabangBank });
            }
        }

        public List<DariRekening> _dariRekening;
        private readonly List<RekeningTujuan> _rekeningTujuan;

        [Required]
        public HttpPostedFileBase image { get; set; }

        public IEnumerable<SelectListItem> DariRekenings
        {
            get { return new SelectList(_dariRekening, "Id", "Name"); }
        }

        public IEnumerable<SelectListItem> RekeningTujuans
        {
            get { return new SelectList(_rekeningTujuan, "Id", "Name"); }
        }

        public bool IsUnderpayment { get; set; }

        public string TransactionId { get; set; }

        public double TotalTagihan { get; set; }
        [Required]
        public string DariRekeningId { get; set; }

        public string NamaBank { get; set; }

        public string NamaPemilikRekening { get; set; }

        public string NomorRekening { get; set; }

        public string CabangRekening { get; set; }
        [Required]
        public string RekeningTujuanId { get; set; }
        [Required]
        [System.ComponentModel.DataAnnotations.Compare("TotalTagihan")]
        public double JumlahPembayaran { get; set; }
        [Required]
        public string NoStrukPembayaran { get; set; }

        public string Remarks { get; set; }
        [Required]
        public DateTime TanggalPembayaran { get; set; }

        public Byte[] BuktiPembayaran { get; set; }
    }
    public class PurchaseInformationViewModel
    {
        public PurchaseInformationViewModel()
        {
            PatunganFriends = new List<InviteNameEmailViewModel>();
        }
        [Required]
        public string ReceiverName { get; set; }
        [Required]
        public string DeliveryAddress { get; set; }
        //[Required]
        //public string City { get; set; }
        //[Required]
        //public string Kecamatan { get; set; }
        //[Required]
        //public string Kelurahan { get; set; }
        [Required]
        public string PhoneNumber { get; set; }
        [Required]
        public DateTime SendDate { get; set; }
        public string ProductPrice { get; set; }
        public string PackagePrice { get; set; }
        public string GiftcardPrice { get; set; }
        public string SubTotal { get; set; }
        public string Total { get; set; }
        public string NamaKurir { get; set; }
        [Required]
        public string JenisPaket { get; set; }
        [Required]
        public string AsuransiPaket { get; set; }
        [Required]
        public string BiayaKirim { get; set; }
        //[Required]
        //public string Kota { get; set; }
        //[Required]
        //public string Kecamatan { get; set; }
        //[Required]
        //public string Kelurahan { get; set; }
        public PostalCodeViewModel postalcode { get; set; }
        public bool IsPatungan { get; set; }
        public string PatunganTitle { get; set; }
        public string PatunganPenerimaKado { get; set; }
        public string PatunganDeskripsi { get; set; }
        public List<InviteNameEmailViewModel> PatunganFriends { get; set; }
    }
}