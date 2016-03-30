using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace pickkado.Front.Models
{
    public class GiftCardInviteViewModel
    {
        [Required]
        public string MyGiftCard { get; set; }
        public string MessageToFriends { get; set; }
        public List<InviteNameEmailViewModel> FriendsGiftCard { get; set; }
    }

    public class InviteNameEmailViewModel
    {
        public string Name { get; set; }
        public string Email { get; set; }
    }
}