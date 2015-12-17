using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Calisma_DAL
{
   public class Process
    {
        [Key]
        public int id { get; set; }
       
        [ForeignKey("User")]
        public int UserId { get; set; }

        [Required, MaxLength(20)]
        public string Old_Data { get; set; }
        [Required, MaxLength(20)]
        public string New_Data { get; set; }
        [Required, MaxLength(20)]
        public string Prosess { get; set; }

        public DateTime CreatedDate { get; set; }

        public virtual User User { get; set; }
    }
}
