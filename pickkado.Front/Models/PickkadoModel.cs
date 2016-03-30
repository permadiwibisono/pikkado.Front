using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Data.Entity;
using System.Web.DynamicData;

namespace pickkado.Front.Models
{
    public class PickkadoDBContext_1 : DbContext
    {
        public PickkadoDBContext_1()
            : base("DefaultConnection")
        {
            Database.CreateIfNotExists();
            //if (Category.ToList().Count == 0)
            //{
                
            //}
            /*if (Package.ToList().Count == 0)
            {
                var packageList = new List<Package>
                {
                    new Package{Id=Guid.NewGuid(),PackageName="Wrap1",ImageUrl="/Images/Warp1.png",Price=10000,Qty=10,CreatedBy="Admin",CreatedDate=DateTime.Now,UpdatedBy="Admin",UpdatedDate=DateTime.Now},
                    new Package{Id=Guid.NewGuid(),PackageName="Wrap2",ImageUrl="/Images/Warp2.png",Price=10000,Qty=10,CreatedBy="Admin",CreatedDate=DateTime.Now,UpdatedBy="Admin",UpdatedDate=DateTime.Now},
                    new Package{Id=Guid.NewGuid(),PackageName="Wrap3",ImageUrl="/Images/Warp3.png",Price=10000,Qty=10,CreatedBy="Admin",CreatedDate=DateTime.Now,UpdatedBy="Admin",UpdatedDate=DateTime.Now},
                    new Package{Id=Guid.NewGuid(),PackageName="Wrap4",ImageUrl="/Images/Warp4.png",Price=10000,Qty=10,CreatedBy="Admin",CreatedDate=DateTime.Now,UpdatedBy="Admin",UpdatedDate=DateTime.Now},
                    new Package{Id=Guid.NewGuid(),PackageName="Wrap5",ImageUrl="/Images/Warp5.png",Price=10000,Qty=10,CreatedBy="Admin",CreatedDate=DateTime.Now,UpdatedBy="Admin",UpdatedDate=DateTime.Now}
                };
                Package.AddRange(packageList);
                this.SaveChanges();
            }*/
        }

        //public DbSet<Category> Category { get; set; }
        //public DbSet<Package> Package { get; set; }
    }
    //public class Category:Entity
    //{
    //    public string CategoryName { get; set; }
    //    public string ImageUrl { get; set; }
    //}
    //public class Package : Entity
    //{
    //    public string PackageName { get; set; }
    //    public string ImageUrl { get; set; }
    //    public double Price { get; set; }
    //    public int Qty { get; set; }
    //}
    public class Entity
    {
        public Guid Id { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string UpdatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
    }
}
