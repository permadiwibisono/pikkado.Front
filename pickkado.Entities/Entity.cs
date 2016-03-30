using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Entities
{
    public class Entity
    {
        public string Id { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string UpdatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
        public Entity()
        {
            UpdatedDate = DateTime.Now;
            UpdatedBy = "";
            CreatedBy = "";
            CreatedDate = DateTime.Now;
        }
        public string GenerateId(string prefix)
        {
            var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            var max = 3;
            Random r = new Random();
            string random = "";
            while (random.Length<=max)
            {
                random += alphabet[r.Next(0, alphabet.Length)];
            }
            string newId = "";

            var dt = DateTime.Now.Year.ToString("0#") + DateTime.Now.Month.ToString("0#") + DateTime.Now.Day.ToString("0#") + DateTime.Now.Hour.ToString("0#") + DateTime.Now.Minute.ToString("0#") + DateTime.Now.Second.ToString("0#") + DateTime.Now.Millisecond.ToString("0#");
            newId = prefix + dt+random;

            return newId;
        }
    }
}
