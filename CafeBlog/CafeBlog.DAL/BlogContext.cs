using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafeBlog.DAL
{
    public class BlogContext : DbContext
    {
        public BlogContext()
            : base("name=BlogConnection")
        {

        }

        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<User> User { get; set; }
        public virtual DbSet<Article> Article { get; set; }
        public virtual DbSet<Comment> Comment { get; set; }
        public virtual DbSet<ContactMessage> ContactMessage { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
        }
    }
}
