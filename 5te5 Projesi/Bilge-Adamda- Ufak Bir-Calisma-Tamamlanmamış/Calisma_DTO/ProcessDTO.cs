using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Calisma_DTO
{
    public class ProcessDTO
    {
     
        public int id { get; set; }

    
        public int UserId { get; set; }

     
        public string Old_Data { get; set; }
       
        public string New_Data { get; set; }
       
        public string Prosess { get; set; }

        public DateTime CreatedDate { get; set; }
    }
}
