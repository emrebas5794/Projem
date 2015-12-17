using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafeBlog.DAL
{
    public class User
    {
        public User()
        {
            //this.Article = new List<Article>();
            //this.Article = new HashSet<Article>();
            //this.Article = new Collection<Article>();

            this.Comment = new List<Comment>();

            this.Article = new List<Article>();
        }

        [Key]
        public int Id { get; set; }

        [Required, MaxLength(50)]
        public string Name { get; set; }

        [Required, MaxLength(50)]
        public string Username { get; set; }

        [Required, MaxLength(50)]
        public string Password { get; set; }

        public virtual ICollection<Comment> Comment { get; set; }

        public virtual ICollection<Article> Article { get; set; }
    }
}











