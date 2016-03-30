using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace pickkado.Front.Models
{
    public class OrderViewModel
    {
        [Required]
        [Display(Name = "Order Detail")]
        public string OrderDetail { get; set; }

        [Required]
        //[DataType(DataType.Password)]
        [Display(Name = "Price")]
        [DataType(DataType.Currency)]
        public float Price { get; set; }

        public HttpPostedFileBase image { get; set; }
        public byte[] imageByte { get; set; }

    }
    public class TransactionModel
    {
        public TransactionModel()
        {
            TransactionId = GenerateId("TR");
            TransactionDate = DateTime.Now;
        }
        public string TransactionId { get; set; }
        public string TransactionType { get; set; }
        public DateTime TransactionDate { get; set; }
        public OrderViewModel orderInfo { get; set; }
        public ProductDetailCatalogViewModel productInfo { get; set; }
        public PackageViewModel packageInfo { get; set; }
        public GiftCardInviteViewModel giftcardInviteInfo { get; set; }
        public PurchaseInformationViewModel purchaseInfo { get; set; }
        public string GenerateId(string prefix)
        {
            string newId = "";

            var dt = DateTime.Now.Year.ToString("0#") + DateTime.Now.Month.ToString("0#") + DateTime.Now.Day.ToString("0#") + DateTime.Now.Hour.ToString("0#") + DateTime.Now.Minute.ToString("0#") + DateTime.Now.Second.ToString("0#") + DateTime.Now.Millisecond.ToString("0#");
            newId = prefix + dt;

            return newId;
        }
        public string GetPackagePriceToRupiah()
        {
            return packageInfo.package.Price.ToRupiah();
        }
        public string GetGiftCardPriceToRupiah()
        {
            return packageInfo.giftcard.Price.ToRupiah();
        }

        public string GetSubTotalToRupiah()
        {
            return (productInfo.PriceFloat+packageInfo.package.Price+packageInfo.giftcard.Price).ToRupiah();
        }
    }
}
