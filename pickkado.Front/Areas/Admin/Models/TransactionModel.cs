using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace pickkado.Front.Areas.Admin.Models
{
    public class DummyData
    {
        public List<TransactionModel> List { get; set; }
        public DummyData()
        {
            List=new List<TransactionModel>{
                new TransactionModel { Id=1.ToString(),Email="Abc",Deadline=DateTime.Now,Total=2000000,Status="PAYMENT CHECKING"},
                new TransactionModel { Id=2.ToString(),Email="PW",Deadline=DateTime.Now,Total=2100000,Status="PAYMENT CHECKING"},
                new TransactionModel { Id=3.ToString(),Email="AD",Deadline=DateTime.Now,Total=2200000,Status="PAYMENT CHECKING"},
                new TransactionModel { Id=4.ToString(),Email="CS",Deadline=DateTime.Now,Total=2500000,Status="WAITING VENDOR"},
                new TransactionModel { Id=5.ToString(),Email="CD",Deadline=DateTime.Now,Total=2200000,Status="WAITING VENDOR"},
                new TransactionModel { Id=6.ToString(),Email="GFA",Deadline=DateTime.Now,Total=2200000,Status="WAITING VENDOR"},
                new TransactionModel { Id=7.ToString(),Email="FTT",Deadline=DateTime.Now,Total=2300000,Status="DELIVERING ORDER"}
            };
        }
    }
    public class TransactionModel
    {
        public string Id { get; set; }
        public DateTime Date { get; set; }
        public string Email { get; set; }
        public string ProductName { get; set; }
        public string Address { get; set; }
        public DateTime Deadline { get; set; }
        public bool IsGroup { get; set; }
        public double TotalTransfered { get; set; }
        public float Total { get; set; }
        public string Status { get; set; }
        public string ResiNumber { get; set; }
        public List<TransactionPaymentModel> PaymentList { get; set; }
    }
    public class TransactionPaymentModel
    {
        public int Id { get; set; }
        public int TransId { get; set; }
        public float TotalTransfer { get; set; }
        public string NoRek { get; set; }
        public string Bank { get; set; }
        public string Cabang { get; set; }
        public string AtasNama { get; set; }
        public string NoRekTujuan { get; set; }
        public string BankTujuan { get; set; }
        public string CabangTujuan { get; set; }
        public string AtasNamaTujuan { get; set; }
    }
    public class PaymentConfirmationViewModel
    {
        [Required]
        public string PaymentId { get; set; }
        [Display(Name = "Remarks")]
        public string Remarks { get; set; }
        [Display(Name="Koreksi Total Bayar")]
        public float KoreksiTotalBayar { get; set; }
        [Required]
        [Display(Name = "Status")]
        public string Status { get; set; }
    }
    public class ProductConfirmationViewModel
    {
        [Required]
        public string TransactionId { get; set; }
        [Display(Name = "Price")]
        public float Price { get; set; }
        [Display(Name = "Ongkos Kirim")]
        public float OngkosKirim { get; set; }
        [Display(Name = "No. Resi")]
        public string ResiNumber { get; set; }
    }
    public class ProductDeliveryViewModel
    {
        [Required]
        public string TransactionId { get; set; }
        [Required]
        [Display(Name = "No. Resi")]
        public string ResiNumber { get; set; }
    }
    public class TransactionSuccessConfirmViewModel
    {
        [Required]
        public string TransactionId { get; set; }
    }
}
