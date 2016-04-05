namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTableTransactionMemberGroup : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.TransactionMemberGroups", "ShareCode", c => c.Guid(nullable: false));
            AddColumn("dbo.TransactionMemberGroups", "BatasWaktu", c => c.DateTime(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.TransactionMemberGroups", "BatasWaktu");
            DropColumn("dbo.TransactionMemberGroups", "ShareCode");
        }
    }
}
