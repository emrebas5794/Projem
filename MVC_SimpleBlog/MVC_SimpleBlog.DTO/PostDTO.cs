using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.DTO
{
     public class PostDTO
     {
          public int Id { get; set; }
          public string Title { get; set; }
          public string Content { get; set; }
          public string ImagePath { get; set; }
          public int CategoryId { get; set; }
          public DateTime CreatedDate { get; set; }
          public int UserId { get; set; }
     }
}
