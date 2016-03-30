﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Admin.Models
{
    public class MasterAccountBankViewModel
    {
        [Required]
        [Display(Name = "Atas Nama :")]
        public string AtasNama { get; set; }

        [Required]
        [Display(Name = "No. Rekening :")]
        public string NoRekening { get; set; }

        [Required]
        [Display(Name = "Bank :")]
        public string Bank { get; set; }

        [Required]
        [Display(Name = "Cabang Bank :")]
        public String CabangBank { get; set; }

        public bool Visible { get; set; }
    }
}
