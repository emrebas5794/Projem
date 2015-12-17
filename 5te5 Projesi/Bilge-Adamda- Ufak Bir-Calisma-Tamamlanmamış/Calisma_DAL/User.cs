using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Calisma_DAL
{
    public class User
    {
        [Key]
        public int id { get; set; }
         [Required, MaxLength(20)]
        public string Name { get; set; }
         [Required, MaxLength(20)]
        public string Surname { get; set; }
         [Required, MaxLength(50)]
        public string Email { get; set; }

    }
}
