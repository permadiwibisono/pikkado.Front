namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTableVendorPayment : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.VendorPayments", "IsAccepted", c => c.Boolean(nullable: false));
            AddColumn("dbo.VendorPayments", "IsDeliver", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.VendorPayments", "IsDeliver");
            DropColumn("dbo.VendorPayments", "IsAccepted");
        }
    }
}
