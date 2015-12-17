namespace CafeBlog.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Changes01 : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Article", "UserId", c => c.Int(nullable: false));
            CreateIndex("dbo.Article", "UserId");
            AddForeignKey("dbo.Article", "UserId", "dbo.User", "Id", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Article", "UserId", "dbo.User");
            DropIndex("dbo.Article", new[] { "UserId" });
            DropColumn("dbo.Article", "UserId");
        }
    }
}
