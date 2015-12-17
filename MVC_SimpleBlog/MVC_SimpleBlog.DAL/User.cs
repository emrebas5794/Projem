using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.DAL
{
    public class User
    {
        [Key]
        public int Id { get; set; }
        [Required, MaxLength(50)]
        public string Password { get; set; }
        [Required, MaxLength(50)]
        public string UserName { get; set; }
        [MaxLength(50)]
        public string NickName { get; set; }

        public virtual List<Post> Articles { get; set; }
        public virtual List<Comment> Comments { get; set; }

    }
}
