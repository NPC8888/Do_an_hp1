using Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.Models;
using System.Net;
using System.Net.Mail;

namespace xediep.webControl
{
    public partial class BoLoc : System.Web.UI.UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public static string RemoveDiacritics(string text)//xoa dau tieng viet
        {
            if (string.IsNullOrWhiteSpace(text))
                return text;
            return string.Concat(text.Normalize(NormalizationForm.FormD)
                .Where(c => CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark))
                .Normalize(NormalizationForm.FormC);
        }

        // Hàm nạp chồng: Tìm kiếm trong một đối tượng XeKhach
        public static bool TimKiem(XeKhach xeKhach, string keyword)
        {
            if (xeKhach == null || string.IsNullOrWhiteSpace(keyword)) return false;

            string keywordNormalized = RemoveDiacritics(keyword.ToLower());

            return RemoveDiacritics(xeKhach.MaXe.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(xeKhach.BienSoXe.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(xeKhach.LoaiXe.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(xeKhach.SoChoNgoi.ToString().ToLower()).Contains(keywordNormalized);
        }

        // Tương tự cho TuyenXe
        public static bool TimKiem(TuyenXe tuyenXe, string keyword)
        {
            if (tuyenXe == null || string.IsNullOrWhiteSpace(keyword)) return false;

            string keywordNormalized = RemoveDiacritics(keyword.ToLower());

            return RemoveDiacritics(tuyenXe.MaTuyenXe.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(tuyenXe.DiemDi.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(tuyenXe.DiemDen.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(tuyenXe.TrangThai.ToLower()).Contains(keywordNormalized);
        }

        // Tương tự cho ChuyenXe
        public static bool TimKiem(ChuyenXe chuyenXe, string keyword)
        {
            if (chuyenXe == null || string.IsNullOrWhiteSpace(keyword)) return false;

            string keywordNormalized = RemoveDiacritics(keyword.ToLower());

            return RemoveDiacritics(chuyenXe.MaCx.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(chuyenXe.MaTuyenXe.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(chuyenXe.MaXe.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(chuyenXe.MaTaiXe.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(chuyenXe.TrangThai.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(chuyenXe.Price.ToString().ToLower()).Contains(keywordNormalized);
        }
        public static bool TimKiem(NguoiDung nguoi, string keyword)
        {
            if (nguoi == null || string.IsNullOrWhiteSpace(keyword)) return false;
            string keywordNormalized = RemoveDiacritics(keyword.ToLower());
            return RemoveDiacritics(nguoi.HoTen.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(nguoi.EMai.ToString().ToLower()).Contains(keywordNormalized);
        }
        public static bool TimKiem(DiemDonTraKhach diem, string keyword)
        {
            if (diem == null || string.IsNullOrWhiteSpace(keyword)) return false;

            string keywordNormalized = RemoveDiacritics(keyword.ToLower());

            return RemoveDiacritics(diem.MaDiem.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(diem.LoaiDiem.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(diem.TenDiem.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(diem.DiaChi.ToLower()).Contains(keywordNormalized);
        }
        public static bool TimKiem(DanhGia dg, string keyword)
        {
            if (dg == null || string.IsNullOrWhiteSpace(keyword)) return false;

            string keywordNormalized = RemoveDiacritics(keyword.ToLower());

            return RemoveDiacritics(dg.MaDanhGia.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(dg.DiemDanhGia.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(dg.BinhLuan.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(dg.MaXe.ToString().ToLower()).Contains(keywordNormalized)||
                   RemoveDiacritics(dg.MaNguoiDung.ToString().ToLower()).Contains(keywordNormalized);
        }
        public static bool TimKiem(BaoCao bc, string keyword)
        {
            if (bc == null || string.IsNullOrWhiteSpace(keyword)) return false;

            string keywordNormalized = RemoveDiacritics(keyword.ToLower());

            return RemoveDiacritics(bc.MaBaoCao.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(bc.TongDoanhThu.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(bc.LoaiBaoCao.ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(bc.NgayBatDau.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(bc.NgayKetThuc.ToString().ToLower()).Contains(keywordNormalized) ||
                   RemoveDiacritics(bc.TongSoVe.ToString().ToLower()).Contains(keywordNormalized);
        }
    }

}
public class EmailService
{
    private string smtpServer = "smtp.gmail.com";
    private int smtpPort = 587;
    private string senderEmail = "nguyendieptsag73@gmail.com";
    private string senderPassword = "cnrknksscbowxhet"; //matkhau

    public bool SendMail(string toEmail, string subject, string body)
    {
        if (string.IsNullOrEmpty(toEmail) || string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(body))
        {
            Console.WriteLine("Thông tin email không hợp lệ!");
            return false;
        }

        //try
        //{
        MailMessage mail = new MailMessage
        {
            From = new MailAddress(senderEmail),
            Subject = subject,
            Body = body,
            IsBodyHtml = true // Gửi email HTML
        };

        mail.To.Add(toEmail);

        using (SmtpClient smtp = new SmtpClient(smtpServer, smtpPort))
        {
            smtp.Credentials = new NetworkCredential(senderEmail, senderPassword);
            smtp.EnableSsl = true;
            smtp.Send(mail);
        }

        Console.WriteLine("✅ Email đã gửi thành công đến " + toEmail);
        return true;
        // }
        //  catch (Exception ex)
        //{
        //   Console.WriteLine("❌ Lỗi gửi email: " + ex.Message);
        //   return false;
        //}
    }
}
