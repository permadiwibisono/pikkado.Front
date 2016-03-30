using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Transaction:Entity
    {
        public DateTime TransDate { get; set; }
        public DateTime TanggalKirim { get; set; }

        public string TransactionType { get; set; }

        public string UserId { get; set; }
        public virtual User User { get; set; }

        public string UserName { get; set; }

        public bool IsGroup { get; set; }
        public int GroupCount { get; set; }
        public string GroupTitle { get; set; }
        public string GroupDescription { get; set; }
        public string GroupReceiverName { get; set; }

        public string ProductId { get; set; }
        public virtual Product Product { get; set; }

        public byte[] ProductImage { get; set; }
        public string ProductName { get; set; }
        public string ProductBrand { get; set; }
        public string ProductCategory { get; set; }
        public float ProductWeight { get; set; }
        public string ProductDescription { get; set; }

        public string PackageId { get; set; }
        public virtual Package Package { get; set; }

        public byte[] PackageImage { get; set; }
        public string PackageName { get; set; }
        public float PackagePrice { get; set; }

        public string GreetingCardId { get; set; }
        public byte[] GreetingCardImage { get; set; }
        public string GreetingCardName { get; set; }
        public float GreetingCardPrice { get; set; }
        public string InviteFriendGiftcardMessage { get; set; }
        //public string GreetingCardMessage { get; set; }
        public string ReceiveName { get; set; }

        public string StoreId { get; set; }
        public virtual Store Store { get; set; }

        public string StoreName { get; set; }
        public string StoreAddress { get; set; }
        public string StorePhoneNumber { get; set; }
        public string DestinationAddress { get; set; }
        public string City { get; set; }
        public string Kecamatan { get; set; }
        public string Kelurahan { get; set; }

        public string Status { get; set; }

        public float ProductPrice { get; set; }
        public float ShippingFee { get; set; }
        public float ServiceFee { get; set; }
        public string VoucherId { get; set; }
        public float DiscountVoucherPrice { get; set; }

        public string NamaKurir { get; set; }
        public string JenisPaket { get; set; }
        public string AsuransiKurir { get; set; }
        public string ResiNumber { get; set; }

        public virtual ICollection<TransactionPayment> TransactionPayments { get; set; }
        public virtual ICollection<TransactionProductAttribute> TransactionProductAttributes { get; set; }
        public virtual ICollection<TransactionGiftcardMessage> TransactionGiftcardMessages { get; set; }
        public virtual ICollection<TransactionMemberGroup> TransactionMemberGroups { get; set; }

        public float GetTotalPrice()
        {
            return ProductPrice + PackagePrice + GreetingCardPrice + ShippingFee + ServiceFee-DiscountVoucherPrice;
        }
    }
}
