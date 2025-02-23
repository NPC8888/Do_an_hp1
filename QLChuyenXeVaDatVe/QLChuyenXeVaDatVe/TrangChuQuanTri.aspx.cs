using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Google.Apis;

namespace xediep
{
    public partial class TrangChuQuanTri : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
              
               

            
        }
/*
        private string smtpServer = "smtp.gmail.com";
        private int smtpPort = 587;
        private string senderEmail = "nguyendieptsag73@gmail.com";  // Thay bằng email của bạn
        private string senderPassword = "cnrknksscbowxhet"; // Thay bằng App Password

        public bool SendMail(string toEmail, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(senderEmail);
                mail.To.Add(toEmail);
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = true; // Nếu gửi HTML

                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.Credentials = new NetworkCredential(senderEmail, senderPassword);
                smtp.EnableSsl = true; // Bật SSL để bảo mật

                smtp.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                Response.Write("Lỗi gửi email: " + ex.Message);
                return false;
            }
        }*/
    }
}