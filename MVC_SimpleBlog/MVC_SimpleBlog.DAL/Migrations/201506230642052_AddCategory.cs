namespace MVC_SimpleBlog.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddCategory : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Category",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            AddColumn("dbo.Post", "CategoryId", c => c.Int(nullable: false));
            CreateIndex("dbo.Post", "CategoryId");
            AddForeignKey("dbo.Post", "CategoryId", "dbo.Category", "Id");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Post", "CategoryId", "dbo.Category");
            DropIndex("dbo.Post", new[] { "CategoryId" });
            DropColumn("dbo.Post", "CategoryId");
            DropTable("dbo.Category");
        }
    }
}
