using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafeBlog.DAL
{
    public class Article
    {
        [Key]
        public int Id { get; set; }

        [Required, MaxLength(50)]
        public string Title { get; set; }

        [ForeignKey("Category")]
        public int CategoryId { get; set; }

        [Required]
        public string Content { get; set; }

        [MaxLength(250)]
        public string ImagePath { get; set; }

        [ForeignKey("User")]
        public int UserId { get; set; }

        public DateTime CreatedDate { get; set; }

        public virtual Category Category { get; set; }

        public virtual User User { get; set; }
    }
}
