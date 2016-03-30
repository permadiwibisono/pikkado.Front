using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace pickkado.Front.Models
{
    public class ProductCatalogModel
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Price { get; set; }
        public byte[] Image { get; set; }
        public pickkado.Entities.Category category { get; set; }
    }
    public class ProductDetailCatalogModel
    {
        //just display
        public string Id { get; set; }
        public string Name { get; set; }
        public int Category { get; set; }
        public string Price { get; set; }
        public List<byte[]> Thumbnail { get; set; }
        [DataType(DataType.MultilineText)]
        public string Description { get; set; }
        public float Weight { get; set; }

        public List<MasterAttributeProductModel> MasterAttributeList { get; set; }
        public List<AttributeProductModel> AttributeProductList { get; set; }
        //public string AttributeSelected { get; set; }

    }
    public class ProductDetailCatalogViewModel
    {
        [Required]
        public string ProductId { get; set; }

        public List<string> AttributeSelected { get; set; }
        public string Name { get; set; }
        public string Price { get; set; }
        public float PriceFloat
        {
            get {
                if (Price != null)
                    return float.Parse(Price.DeleteNonNumeric());
                else
                    return 0;
                }
            set
            {
                float a = 0; 
                Price = value==null?a.ToRupiah():value.ToRupiah(); 
            }
        }
        public string Description { get; set; }
        public float Weight { get; set; }
        public string CategoryName { get; set; }
        public byte[] Image { get; set; }

    }
    public class AttributeProductModel:SelectListItem
    {
        public string MasterAttributeId { get; set; }
        public bool Disabled { get; set; }
    }
    public class MasterAttributeProductModel
    {
        public string Id { get; set; }
        public string Name { get; set; }
    }
}
