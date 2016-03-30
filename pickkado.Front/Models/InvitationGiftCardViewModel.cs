using pickkado.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace pickkado.Front.Models
{
    public class InvitationGiftCardViewModel
    {
        public byte[] UserImage { get; set; }
        public string UserName { get; set; }
        public DateTime TransDate { get; set; }
        public TransactionGiftcardMessage TransactionGiftcardMessage { get; set; }
    }
}