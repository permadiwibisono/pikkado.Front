namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTableVendorPayment1 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.VendorPayments", "Remarks", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.VendorPayments", "Remarks");
        }
    }
}
