using pickkado.Front.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace pickkado.Front
{
    class Constants
    {
    }
    public class TransactionType
    {
        public const string Order = "ORDER";
        public const string Suggest = "SUGGEST";
        public const string Catalog = "CATALOG";
    }
    public class TransactionStatus
    {
        public const string InvitationGroup = "INVITATION GROUP";
        public const string InvitationGroupPending = "INVITATION GROUP PENDING";
        public const string PaymentChecking = "PAYMENT CHECKING";

        public const string NotValid = "THE LAST YOUR PAYMENT IS NOT VALID";
        public const string UnderPayment = "THE LAST YOUR PAYMENT IS UNDER PAYMENT";
        public const string WaitingForYourFriendPayment = "WAITING FOR YOUR FRIEND'S PAYMENT";

        public const string UnconfirmPayment = "UNCONFIRM PAYMENT";
        //public const string UnderPayment = "UNDER PAYMENT";
        public const string InventoryChecking = "INVENTORY CHECKING";
        public const string OnBuying = "ON BUYING";
        public const string OnDelivering = "ON DELIVERING";
        public const string CompletedAdmin = "COMPLETED BY ADMIN";
        public const string CompletedUser = "COMPLETED BY USER";
        public const string Refund = "REFUND";
        public const string Cancel = "CANCEL";
    }
    public class TransactionPaymentStatus
    {
        public const string NotValid = "NOT VALID";
        public const string UnderPayment = "UNDER PAYMENT";
        public const string Valid = "VALID";
    }
    public class Fee
    {
        public const float Ongkir = 10000;
        public const float GiftCardPrice = 5000;
        public const float ServiceFee = 30000;

        
    }
    public class Rules
    {
        public const int PaymentDueDateHMin = 4;
    }
    public class SendEmail
    {
        public static async Task SendEmailInviteToGiftcardMessage(string templateEmail, byte[] logo, string toName, string toEmail, string fromName, string inviteMessage, string link)
        {
            var body = templateEmail;
            var message = new MailMessage();
            message.To.Add(new MailAddress(toEmail));  // replace with valid value 
            message.From = new MailAddress("support@pickkado.com", "Pickkado");  // replace with valid value
            message.Subject = "Undangan giftcard  dari " + fromName;
            message.Body = string.Format(body, "data:image/png;base64," + System.Convert.ToBase64String(logo), toName, fromName, inviteMessage, link);
            message.IsBodyHtml = true;

            using (var smtp = new SmtpClient())
            {
                var credential = new NetworkCredential
                {
                    UserName = "pickkado@gmail.com",  // replace with valid value
                    Password = "tranquility"  // replace with valid value
                };
                smtp.Credentials = credential;
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                await smtp.SendMailAsync(message);
            }
        }

        public static async Task SendEmailInviteToGiftcardMessage(InviteGiftCardSentEmailModel email)
        {
            var body = email.TemplateEmail;
            var message = new MailMessage();
            message.To.Add(new MailAddress(email.ToEmail));  // replace with valid value 
            message.From = new MailAddress("support@pickkado.com", "Pickkado");  // replace with valid value
            message.Subject = "Undangan giftcard  dari " + email.FromName + " #" + DateTime.Now.ToString();
            message.Body = string.Format(body, email.ToName, email.FromName, email.InviteMessage, email.Link, email.BatasWaktu);
            message.IsBodyHtml = true;

            using (var smtp = new SmtpClient())
            {
                var credential = new NetworkCredential
                {
                    UserName = "pickkado@gmail.com",  // replace with valid value
                    Password = "tranquility"  // replace with valid value
                };
                smtp.Credentials = credential;
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                await smtp.SendMailAsync(message);
            }
        }
        public static async Task SendEmailInviteToPatunganMessage(InvitePatunganSentEmailModel email)
        {
            var body = email.TemplateEmail;
            var message = new MailMessage();
            message.To.Add(new MailAddress(email.ToEmail));  // replace with valid value 
            message.From = new MailAddress("support@pickkado.com", "Pickkado");  // replace with valid value
            message.Subject = "Undangan patungan  dari " + email.FromName+" #"+DateTime.Now.ToString();
            message.Body = string.Format(body,  email.ToName, email.FromName,
                email.JumlahPatungan,email.BatasWaktu,
                email.InviteMessage, email.Link, email.PenerimaKado);
            message.IsBodyHtml = true;

            using (var smtp = new SmtpClient())
            {
                var credential = new NetworkCredential
                {
                    UserName = "pickkado@gmail.com",  // replace with valid value
                    Password = "tranquility"  // replace with valid value
                };
                smtp.Credentials = credential;
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                await smtp.SendMailAsync(message);
            }
        }
        public static async Task SendEmailStruk(StrukSentEmailModel email)
        {
            var body = email.TemplateEmail;
            var message = new MailMessage();
            message.To.Add(new MailAddress(email.ToEmail));  // replace with valid value 
            message.From = new MailAddress("support@pickkado.com", "Pickkado");  // replace with valid value
            message.Subject = "Menuggu konfirmasi pembayaran #" + DateTime.Now.ToString();
            message.Body = string.Format(body, email.ToName,
                email.TransactionId, email.ProductName, email.TanggalPengiriman, email.Patungan,
                email.TotalProduct, email.TotalGiftcard, email.TotalPackage, email.OngkosKirim, email.ServiceFee, email.TOTAL, email.BatasWaktu);
            message.IsBodyHtml = true;

            using (var smtp = new SmtpClient())
            {
                var credential = new NetworkCredential
                {
                    UserName = "pickkado@gmail.com",  // replace with valid value
                    Password = "tranquility"  // replace with valid value
                };
                smtp.Credentials = credential;
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                await smtp.SendMailAsync(message);
            }
        }
        public static async Task SendEmailStruk(StrukPatunganSentEmailModel email)
        {
            var body = email.TemplateEmail;
            var message = new MailMessage();
            message.To.Add(new MailAddress(email.ToEmail));  // replace with valid value 
            message.From = new MailAddress("support@pickkado.com", "Pickkado");  // replace with valid value
            message.Subject = "Menuggu konfirmasi dari teman - teman anda #"+DateTime.Now.ToString();
            message.Body = string.Format(body, email.ToName,
                email.TransactionId, email.ProductName, email.TanggalPengiriman,
                email.TotalProduct, email.TotalGiftcard, email.TotalPackage, email.OngkosKirim, email.ServiceFee, email.TOTAL,email.DaftarMemberPlainHtml, email.BatasWaktu);
            message.IsBodyHtml = true;

            using (var smtp = new SmtpClient())
            {
                var credential = new NetworkCredential
                {
                    UserName = "pickkado@gmail.com",  // replace with valid value
                    Password = "tranquility"  // replace with valid value
                };
                smtp.Credentials = credential;
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                await smtp.SendMailAsync(message);
            }
        }
    }
    public static class DoubleExtension
    {
        public static string ToRupiah(this double number)
        {
            return String.Format(CultureInfo.CreateSpecificCulture("id-id"), "Rp. {0:N0}", number);
        }
    }
    public static class FloatExtension
    {
        public static string ToRupiah(this float number)
        {
            return String.Format(CultureInfo.CreateSpecificCulture("id-id"), "Rp. {0:N0}", number);
        }
    }
    public static class IntExtension
    {
        public static string ToRupiah(this int number)
        {
            return String.Format(CultureInfo.CreateSpecificCulture("id-id"), "Rp. {0:N0}", number);
        }
    }

    public static class StringExtension
    {
        public static string GetLast(this string source, int tail_length)
        {
            if (tail_length >= source.Length)
                return source;
            return source.Substring(source.Length - tail_length);
        }
        public static string DeleteNonNumeric(this string source)
        {
            Regex digitsOnly = new Regex(@"[^\d,-]");
            //Regex digitsOnly = new Regex(@"[^[0-9]{1,2}([,][0-9]{1,2})?$]");
            return digitsOnly.Replace(source, "");
        }
        public static string ToRupiah(this string number)
        {
            return String.Format(CultureInfo.CreateSpecificCulture("id-id"), "Rp. {0:N}", number);
        }
    }
}
