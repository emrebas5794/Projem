namespace CafeBlog.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class DbCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Article",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Title = c.String(nullable: false, maxLength: 50),
                        CategoryId = c.Int(nullable: false),
                        Content = c.String(nullable: false),
                        ImagePath = c.String(maxLength: 250),
                        CreatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Category", t => t.CategoryId, cascadeDelete: true)
                .Index(t => t.CategoryId);
            
            CreateTable(
                "dbo.Category",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Comment",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Content = c.String(nullable: false, maxLength: 500),
                        Date = c.DateTime(nullable: false),
                        UserId = c.Int(),
                        ArticleId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Article", t => t.ArticleId, cascadeDelete: true)
                .ForeignKey("dbo.User", t => t.UserId)
                .Index(t => t.UserId)
                .Index(t => t.ArticleId);
            
            CreateTable(
                "dbo.User",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 50),
                        Username = c.String(nullable: false, maxLength: 50),
                        Password = c.String(nullable: false, maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ContactMessage",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        SenderName = c.String(nullable: false, maxLength: 50),
                        SenderEmailAddress = c.String(nullable: false, maxLength: 50),
                        Subject = c.String(nullable: false, maxLength: 50),
                        Message = c.String(nullable: false, maxLength: 1000),
                        Date = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Comment", "UserId", "dbo.User");
            DropForeignKey("dbo.Comment", "ArticleId", "dbo.Article");
            DropForeignKey("dbo.Article", "CategoryId", "dbo.Category");
            DropIndex("dbo.Comment", new[] { "ArticleId" });
            DropIndex("dbo.Comment", new[] { "UserId" });
            DropIndex("dbo.Article", new[] { "CategoryId" });
            DropTable("dbo.ContactMessage");
            DropTable("dbo.User");
            DropTable("dbo.Comment");
            DropTable("dbo.Category");
            DropTable("dbo.Article");
        }
    }
}
