namespace Calisma_DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class calismadb : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Category",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        CategoryName = c.String(nullable: false, maxLength: 20),
                    })
                .PrimaryKey(t => t.id);
            
            CreateTable(
                "dbo.Process",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        UserId = c.Int(nullable: false),
                        Old_Data = c.String(nullable: false, maxLength: 20),
                        New_Data = c.String(nullable: false, maxLength: 20),
                        Prosess = c.String(nullable: false, maxLength: 20),
                        CreatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.id)
                .ForeignKey("dbo.User", t => t.UserId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.User",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 20),
                        Surname = c.String(nullable: false, maxLength: 20),
                        Email = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Process", "UserId", "dbo.User");
            DropIndex("dbo.Process", new[] { "UserId" });
            DropTable("dbo.User");
            DropTable("dbo.Process");
            DropTable("dbo.Category");
        }
    }
}
