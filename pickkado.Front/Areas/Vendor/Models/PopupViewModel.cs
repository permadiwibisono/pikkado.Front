using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Vendor.Models
{
    public class PopupViewModel
    {
    }
    public class PopupProductDetailsViewModel
    {
        public PopupProductDetailsViewModel()
        {
            ProdutAttributeList = new List<ProductAttributeViewModel>();
        }
        public string ProductName { get; set; }
        public byte[] Image { get; set; }
        public float ProductWeight { get; set; }
        public string ProductDescription { get; set; }
        public List<ProductAttributeViewModel> ProdutAttributeList { get; set; }
        public float Price { get; set; }
        public float DiscountProduct { get; set; }
        public float Total { get; set; }
        public string PriceToRupiah { 
            get { 
                if (Price != null) 
                { 
                    return Price.ToRupiah();                     
                }
                return "";
            }
            set
            {
                PriceToRupiah = value;
            }
        }
        public string DiscountProductToRupiah
        {
            get
            {
                if (DiscountProduct != null)
                {
                    return DiscountProduct.ToRupiah();
                }
                return "";
            }
            set {
                DiscountProductToRupiah = value; 
            }
        }
        public string TotalToRupiah
        {
            get
            {
                if (Total != null)
                {
                    return Total.ToRupiah();
                }
                return "";
            }
            set
            {
                TotalToRupiah = value;
            }
        }
    }
    public class ProductAttributeViewModel
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }
    public class PopupRejectOrderViewModel
    {
        public string Id { get; set; }
        [Required]
        public string Remarks { get; set; }

    }
    public class PopupConfirmOrderViewModel
    {
        public string Id { get; set; }
        public string PaymentId { get; set; }
        [Required]
        public string NamaKurir { get; set; }
        [Required]
        public string JenisPaket { get; set; }
        [Required]
        public string AlamatPickkado { get; set; }        
        [Required]
        public string NoResi { get; set; }

    }
}
