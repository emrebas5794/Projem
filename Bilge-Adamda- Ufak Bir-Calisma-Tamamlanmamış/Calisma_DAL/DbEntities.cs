using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Calisma_DAL
{
    public class DbEntities:DbContext
    {
        public DbEntities()
        {
            Database.Connection.ConnectionString = "Server=.; Database=Calisma; Integrated Security=SSPI";
        }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<Category> Categorys { get; set; }
        public virtual DbSet<Process> Process { get; set; }
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Conventions.Remove<PluralizingTableNameConvention>();
            modelBuilder.Conventions.Remove<OneToManyCascadeDeleteConvention>();
        }
    }
}
