using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafeBlog.DAL
{
    public class Comment
    {
        [Key]
        public int Id { get; set; }

        [Required, MaxLength(500)]
        public string Content { get; set; }

        public DateTime Date { get; set; }

        [ForeignKey("User")]
        public Nullable<int> UserId { get; set; }

        [ForeignKey("Article")]
        public int ArticleId { get; set; }


        public virtual User User { get; set; }

        public virtual Article Article { get; set; }
    }
}
