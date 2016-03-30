using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using pickkado.Entities;

namespace pickkado.Front.Models
{
    public class PaymentModel : DbContext
    {
        public PaymentModel() : base("DefaultConnection")
        {

        }

        public DbSet<TransactionPayment> TransactionPayments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();

            //modelBuilder.Entity<TransactionPayment>()
            //    .HasMany(c => c.).WithMany(i => i.Courses)
            //    .Map(t => t.MapLeftKey("CourseID")
            //        .MapRightKey("InstructorID")
            //        .ToTable("CourseInstructor"));

            //modelBuilder.Entity<Department>().MapToStoredProcedures();
        }
    }

}