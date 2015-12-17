using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.DTO
{
     public class CommentDTO
     {
          public int Id { get; set; }
          public DateTime CommentDate { get; set; }
          public string Title { get; set; }
          public string Content { get; set; }
          public int UserId { get; set; }
          public int ArticleId { get; set; }
     }
}
