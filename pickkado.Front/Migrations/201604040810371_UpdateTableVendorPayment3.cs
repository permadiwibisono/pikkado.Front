namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTableVendorPayment3 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.VendorPayments", "AlamatPickkado", c => c.String());
            AddColumn("dbo.VendorPayments", "NamaKurir", c => c.String());
            AddColumn("dbo.VendorPayments", "JenisPaket", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.VendorPayments", "JenisPaket");
            DropColumn("dbo.VendorPayments", "NamaKurir");
            DropColumn("dbo.VendorPayments", "AlamatPickkado");
        }
    }
}
