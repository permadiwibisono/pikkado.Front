namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTableTransactionGiftCard : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.TransactionGiftcardMessages", "BatasWaktu", c => c.DateTime(nullable: false));
            AddColumn("dbo.TransactionGiftcardMessages", "ShareCode", c => c.Guid(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.TransactionGiftcardMessages", "ShareCode");
            DropColumn("dbo.TransactionGiftcardMessages", "BatasWaktu");
        }
    }
}
