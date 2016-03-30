using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
namespace pickkado.Front.Models
{
    public class InputGiftcardMessageViewModel
    {
        [Required]
        public string Id { get; set; }
        [Required]
        public string Message { get; set; }
        public string EmailLogin { get; set; }
        public string PasswordLogin { get; set; }
        public string EmailRegister { get; set; }
        public string PasswordRegister { get; set; }
        [Compare("PasswordRegister",ErrorMessage="'Password' untuk register kamu tidak sama dengan 'Confirm Password'")]
        public string ConfirmPasswordRegister { get; set; }
        public string Firstname { get; set; }
        public string Lastname { get; set; }
    }
}
