using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Product:Entity
    {
        public string BrandId { get; set; }
        public virtual Brand brand { get; set; }
        public string StoreId { get; set; }
        public virtual Store store { get; set; }
        public string Name { get; set; }
        public float Weight { get; set; }
        public string Description { get; set; }
        public string Gender { get; set; }
        public float Price { get; set; }
        public int Categories { get; set; }
        public virtual ICollection<ProductAttribute> Attribute { get; set; }
        public virtual ICollection<ProductThumbnail> Thumbnails { get; set; }
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
