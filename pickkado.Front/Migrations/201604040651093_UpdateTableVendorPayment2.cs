namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTableVendorPayment2 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.VendorPayments", "IsDelivered", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.VendorPayments", "IsDelivered");
        }
    }
}
