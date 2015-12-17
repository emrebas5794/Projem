namespace MVC_SimpleBlog.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class DbCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Post",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Title = c.String(nullable: false, maxLength: 50),
                        Content = c.String(nullable: false),
                        ImagePath = c.String(maxLength: 250),
                        UserId = c.Int(nullable: false),
                        CreatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.User", t => t.UserId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.Comment",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Title = c.String(nullable: false, maxLength: 20),
                        Content = c.String(nullable: false, maxLength: 500),
                        UserId = c.Int(nullable: false),
                        ArticleId = c.Int(nullable: false),
                        CommentDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Post", t => t.ArticleId)
                .ForeignKey("dbo.User", t => t.UserId)
                .Index(t => t.UserId)
                .Index(t => t.ArticleId);
            
            CreateTable(
                "dbo.User",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Password = c.String(nullable: false, maxLength: 50),
                        UserName = c.String(nullable: false, maxLength: 50),
                        NickName = c.String(maxLength: 50),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ContactMessage",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 20),
                        EmailAddress = c.String(nullable: false),
                        PhoneNumber = c.String(maxLength: 11),
                        Message = c.String(nullable: false, maxLength: 150),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Post", "UserId", "dbo.User");
            DropForeignKey("dbo.Comment", "UserId", "dbo.User");
            DropForeignKey("dbo.Comment", "ArticleId", "dbo.Post");
            DropIndex("dbo.Comment", new[] { "ArticleId" });
            DropIndex("dbo.Comment", new[] { "UserId" });
            DropIndex("dbo.Post", new[] { "UserId" });
            DropTable("dbo.ContactMessage");
            DropTable("dbo.User");
            DropTable("dbo.Comment");
            DropTable("dbo.Post");
        }
    }
}
