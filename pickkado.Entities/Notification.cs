using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Notification:Entity
    {
        public string UserId { get; set; }
        public string Type { get; set; }
        public string SenderId { get; set; }
        public string SenderName { get; set; }
        public string Description { get; set; }
        public byte[] Thumbnail { get; set; }
        public string Link { get; set; }
        public DateTime NotificationDate { get; set; }
        public string Title { get; set; }
        public bool IsDistributed { get; set; }
        public bool IsSeen { get; set; }

        public virtual User User { get; set; }
    }
}
