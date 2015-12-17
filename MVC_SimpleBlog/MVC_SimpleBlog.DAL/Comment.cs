using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.DAL
{
    public class Comment
    {
        [Key]
        public int Id { get; set; }

        [Required, MaxLength(20)]
        public string Title { get; set; }

        [Required, MaxLength(500)]
        public string Content { get; set; }

        [ForeignKey("User")]
        public int UserId { get; set; }

        [ForeignKey("Article")]
        public int ArticleId { get; set; }

        public DateTime CommentDate { get; set; }
        
        public virtual Post Article { get; set; }
        public virtual User User { get; set; }
    }
}
