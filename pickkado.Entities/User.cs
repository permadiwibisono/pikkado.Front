using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class User:Entity
    {
        public User()
        {
            BirthDate = DateTime.Now;
            Gender = 0;
            VirtualMoney = 0;
        }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime BirthDate { get; set; }
        public string BirthPlace { get; set; }
        public string Email { get; set; }
        public int Gender { get; set; }
        public string PhoneNumber { get; set; }
        public float VirtualMoney { get; set; }
        public byte[] Image { get; set; }
        public string UserType { get; set; }//??

        public ICollection<Destination> Destinations { get; set; }
        public ICollection<NoRekening> NoRekenings { get; set; }
        public ICollection<Notification> Notifications { get; set; }
        public ICollection<Reminder> Reminders { get; set; }
        public ICollection<Transaction> Transactions { get; set; }
        public ICollection<UserVoucher> UserVouchers { get; set; }
    }
}
