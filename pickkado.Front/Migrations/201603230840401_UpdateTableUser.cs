namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTableUser : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Users", "Gender", c => c.Int(nullable: true));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Users", "Gender", c => c.Byte(nullable: true));
        }
    }
}
