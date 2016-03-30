using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Reminder:Entity
    {
        public string UserId { get; set; }
        public string EventName { get; set; }
        public DateTime EventDate { get; set; }
        public string Content { get; set; }
        public DateTime RemindMe { get; set; }

        public virtual User User { get; set; }
    }
}
