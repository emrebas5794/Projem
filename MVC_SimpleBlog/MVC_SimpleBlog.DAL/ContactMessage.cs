﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MVC_SimpleBlog.DAL
{
    public class ContactMessage
    {
        [Key]
        public int Id { get; set; }
        [Required,MaxLength(20)]
        public string Name { get; set; }
        [Required]
        public string EmailAddress { get; set; }
        [MaxLength(11)]
        public string PhoneNumber { get; set; }
        [Required,MaxLength(150)]
        public string Message { get; set; }
    }
}
