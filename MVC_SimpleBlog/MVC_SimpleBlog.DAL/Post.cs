using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.DAL
{
    public class Post
    {
        [Key]
        public int Id { get; set; }

        [Required, MaxLength(50)]
        public string Title { get; set; }

        [Required]
        public string Content { get; set; }

        [MaxLength(250)]
        public string ImagePath { get; set; }

        [ForeignKey("User")]
        public int UserId { get; set; }

        public DateTime CreatedDate { get; set; }

        public int CategoryId { get; set; }


        public virtual User User { get; set; }
        public virtual List<Comment> Comments { get; set; }
        public virtual Category Category { get; set; }
    }
}
