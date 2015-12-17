using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CafeBlog.DAL
{
    public class ContactMessage
    {
        [Key]
        public int Id { get; set; }

        [Required, MaxLength(50)]
        public string SenderName { get; set; }

        [Required, MaxLength(50)]
        public string SenderEmailAddress { get; set; }

        [Required, MaxLength(50)]
        public string Subject { get; set; }

        [Required, MaxLength(1000)]
        public string Message { get; set; }

        public DateTime Date { get; set; }
    }
}
