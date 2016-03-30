using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace pickkado.Front.Areas.Admin.Models
{
    public class NotificationViewModel
    {
        public string UserId { get; set; }
        public string Type { get; set; }
        [Required]
        [Display(Name = "Title")]
        public string Title { get; set; }
        [Required]
        [Display(Name = "Description")]
        public string Description { get; set; }
        
        [Display(Name = "Link")]
        public string Link { get; set; }
    }
}