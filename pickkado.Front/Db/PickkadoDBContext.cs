using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using pickkado.Entities;
using Microsoft.AspNet.Identity.EntityFramework;
using pickkado.Front.Models;
//using pickkado.Back;

namespace pickkado.Front.Db
{
    public class PickkadoDBContext : IdentityDbContext<ApplicationUser>
    {
        public PickkadoDBContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
            //Database.CreateIfNotExists();
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

        public DbSet<Category> Category { get; set; }
        public DbSet<Package> Package { get; set; }
        public DbSet<GiftCard> GiftCard { get; set; }
        public DbSet<Brand> Brand { get; set; }
        public DbSet<Destination> Destination { get; set; }
        public DbSet<NoRekening> NoRekening { get; set; }
        public DbSet<NoRekeningPickkado> NoRekeningPickkado { get; set; }
        public DbSet<Notification> Notification { get; set; }
        public DbSet<Product> ProductVendor { get; set; }
        public DbSet<MasterProductAttribute> MasterProductAttribute { get; set; }
        public DbSet<ProductThumbnail> ProductThumbnail { get; set; }
        public DbSet<ProductAttribute> ProductAttribute { get; set; }
        public DbSet<ProductStore> ProductStore { get; set; }
        public DbSet<Reminder> Reminder { get; set; }
        public DbSet<Store> Store { get; set; }
        public DbSet<Transaction> Transaction { get; set; }
        public DbSet<TransactionPayment> TransactionPayment { get; set; }
        public DbSet<TransactionMemberGroup> TransactionMemberGroup { get; set; }
        public DbSet<TransactionProductAttribute> TransactionProductAttribute { get; set; }
        public DbSet<TransactionGiftcardMessage> TransactionGiftcardMessage { get; set; }
        public DbSet<User> User { get; set; }
        public DbSet<UserVoucher> UserVoucher { get; set; }
        public DbSet<VoucherMaster> VoucherMaster { get; set; }
        public DbSet<EmailSubscribe> EmailSubscribe { get; set; }
        public DbSet<PostalCode> PostalCode { get; set; }
        public DbSet<VendorPayment> VendorPayment { get; set; }

        static PickkadoDBContext()
        {
            // Set the database intializer which is run once during application start
            // This seeds the database with admin user credentials and admin role
            Database.SetInitializer<PickkadoDBContext>(new ApplicationDbInitializer());
        }

        public static PickkadoDBContext Create()
        {
            return new PickkadoDBContext();
        }
    }
}
