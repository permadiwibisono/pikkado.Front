namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateManyTable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.VendorWithdraws",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        WithdrawDate = c.DateTime(nullable: false),
                        Approval = c.Boolean(nullable: false),
                        IsApprove = c.Boolean(nullable: false),
                        IsTransfered = c.Boolean(nullable: false),
                        Ammount = c.Single(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.VendorWithdrawDetails",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        VendorPaymentId = c.String(maxLength: 128),
                        AtasNama = c.String(),
                        NomorRekening = c.String(),
                        Bank = c.String(),
                        CabangBank = c.String(),
                        FromAtasNama = c.String(),
                        FromNomorRekening = c.String(),
                        FromBank = c.String(),
                        FromCabangBank = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                        VendorWithdraw_Id = c.String(maxLength: 128),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.VendorPayments", t => t.VendorPaymentId)
                .ForeignKey("dbo.VendorWithdraws", t => t.VendorWithdraw_Id)
                .Index(t => t.VendorPaymentId)
                .Index(t => t.VendorWithdraw_Id);
            
            AddColumn("dbo.Users", "StoreId", c => c.String(maxLength: 128));
            AddColumn("dbo.VendorPayments", "IsPaid", c => c.Boolean(nullable: false));
            CreateIndex("dbo.Users", "StoreId");
            AddForeignKey("dbo.Users", "StoreId", "dbo.Stores", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.VendorWithdrawDetails", "VendorWithdraw_Id", "dbo.VendorWithdraws");
            DropForeignKey("dbo.VendorWithdrawDetails", "VendorPaymentId", "dbo.VendorPayments");
            DropForeignKey("dbo.Users", "StoreId", "dbo.Stores");
            DropIndex("dbo.VendorWithdrawDetails", new[] { "VendorWithdraw_Id" });
            DropIndex("dbo.VendorWithdrawDetails", new[] { "VendorPaymentId" });
            DropIndex("dbo.Users", new[] { "StoreId" });
            DropColumn("dbo.VendorPayments", "IsPaid");
            DropColumn("dbo.Users", "StoreId");
            DropTable("dbo.VendorWithdrawDetails");
            DropTable("dbo.VendorWithdraws");
        }
    }
}
