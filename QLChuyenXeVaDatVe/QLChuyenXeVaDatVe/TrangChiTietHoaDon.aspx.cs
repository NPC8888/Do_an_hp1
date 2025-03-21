using BLL;
using Models;
using QLChuyenXeVaDatVe.BLL;
using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.BLL.BLL;
using xediep.Models;

namespace QLChuyenXeVaDatVe
{
    public partial class TrangChiTietHoaDon : System.Web.UI.Page
    {
        HoaDonBLL hoaDonBLL = new HoaDonBLL();
        string mahd;
        DanhGia dg = new DanhGia();
        ChiTietHoaDonBLL chiTietHoaDonBLL = new ChiTietHoaDonBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mahd = Request.QueryString["id"];
                loadChiTiet();
                phanquyen();
            }

        }
        private void phanquyen()
        {
           
            if (Session["Role"] != null)
            {
                string role = Session["Role"].ToString();
                NguoiDung ng = NguoiDungBLL.Instance.GetNguoiDungByMaND(int.Parse(role));
                if (ng.VaiTro == "KhachHang")
                {
                    txtMaill.InnerText = ng.EMai;
                }
                else
                {
                    IconMaill.Visible = false;
                    btnDanhGia.Visible = false;

                }
               
            }
            else
            {
                IconMaill.Visible = false;
                btnDanhGia.Visible = false;
            }
        }
        private void loadChiTiet()
        {
            HoaDon hoaDon = hoaDonBLL.GetHoaDonByMaHD(int.Parse(mahd));
            ChiTietHoaDonBLL chiTietHoaDonBLL = new ChiTietHoaDonBLL();
            List<chitiet> danhSachChuyenXe = new List<chitiet>();
            foreach (var item in chiTietHoaDonBLL.GetChiTietHoaDonByMaHD(int.Parse(mahd)))
            {
                VeXe a = VeXeBLL.Instance.GetByeMaVe(item.MaVeXe);
                GheNgoi gheNgoi = GheNgoiBLL.Instance.GetGheNgoiByMaGhe(a.MaGhe);
                ChuyenXe chuyen = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(a.MaChuyenXe);
                string TenChuyen = TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(chuyen.MaTuyenXe).DiemDi + "-" + TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(chuyen.MaTuyenXe).DiemDen;
                chitiet ct = new chitiet();
                ct.TenChuyen = "ID(" + a.MaChuyenXe.ToString() + "): " + TenChuyen;
                ct.GiaVe = chuyen.Price;
                ct.SoGhe = gheNgoi.MaGhe;
                danhSachChuyenXe.Add(ct);
            }
            lblMaHD.Text = mahd;
            if (hoaDon != null)
            {
                lblNgayLap.Text = hoaDon.ThoiGianThanhToan.ToString();
                lblTongTien.Text = hoaDon.TongTien.ToString();
                lblTrangThai.Text = hoaDon.TrangThai;


            }
            gvChiTietHoaDon.DataSource = danhSachChuyenXe;
            gvChiTietHoaDon.DataBind();
        }

        protected void btnDanhGia_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hdnDiem.Value) && !string.IsNullOrEmpty(txtNoiDung.InnerText))
            {
                if (int.TryParse(lblMaHD.Text, out int mahd) && int.TryParse(hdnDiem.Value, out int diem))
                {

                    var ct = chiTietHoaDonBLL.GetChiTietHoaDonByMaHD(mahd);
                    var ve = VeXeBLL.Instance.GetByeMaVe(ct[0].MaVeXe);
                    var xe = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(ve.MaChuyenXe);
                    DanhGia danhGia = new DanhGia { MaNguoiDung = ve.MaKH, MaXe = xe.MaXe, DiemDanhGia = diem, BinhLuan = txtNoiDung.InnerText };

                    // Response.Write("< script > alert('"+dg.MaXe.ToString() + dg.MaNguoiDung.ToString()+ "');</script>"); return;
                    if (DanhGiaBLL.Instance.AddDanhGia(danhGia))
                    {
                        Response.Write("<script>alert('Cảm ơn góp ý của bạn!');</script>");
                    }
                }
                else
                {
                    txtNoiDung.InnerText = "Dữ liệu không hợp lệ!";
                }
            }
            else
            {
                txtNoiDung.InnerText = "Vui lòng nhập đầy đủ thông tin!";
            }

        }

        //webmethod nhanhoadon
        [WebMethod]
        public static string SendEmail(string maHoaDon, string Gmaill)
        {
            try
            {
                string htmlContent = GenerateInvoiceHtml(maHoaDon); // Sinh nội dung email

                if (string.IsNullOrEmpty(htmlContent))
                {
                    return "Lỗi: Nội dung HTML rỗng hoặc null.";
                }

                EmailService emailService = new EmailService();
                bool success = emailService.SendMail(Gmaill, "Tiêu đề Email", htmlContent);

                return success ? "Email đã gửi thành công" : "Lỗi khi gửi email";
            }
            catch (Exception ex)
            {
                return "Lỗi hệ thống: " + ex.Message;
            }
        }
        //tao Noi dung maill
        public static string GenerateInvoiceHtml(string maHoaDon)
        {
            HoaDonBLL hoaDonBLL = new HoaDonBLL();
            HoaDon hoaDon = hoaDonBLL.GetHoaDonByMaHD(int.Parse(maHoaDon));
            ChiTietHoaDonBLL chiTietHoaDonBLL = new ChiTietHoaDonBLL();
            List<chitiet> danhSachChuyenXe = new List<chitiet>();
            foreach (var item in chiTietHoaDonBLL.GetChiTietHoaDonByMaHD(int.Parse(maHoaDon)))
            {
                VeXe a = VeXeBLL.Instance.GetByeMaVe(item.MaVeXe);
                GheNgoi gheNgoi = GheNgoiBLL.Instance.GetGheNgoiByMaGhe(a.MaGhe);
                ChuyenXe chuyen = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(a.MaChuyenXe);
                string TenChuyen = TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(chuyen.MaTuyenXe).DiemDi + "-" + TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(chuyen.MaTuyenXe).DiemDen;
                chitiet ct = new chitiet();
                ct.TenChuyen = "ID(" + a.MaChuyenXe.ToString() + "): " + TenChuyen;
                ct.GiaVe = chuyen.Price;
                ct.SoGhe = gheNgoi.MaGhe;
                danhSachChuyenXe.Add(ct);
            }
            // Dữ liệu
            string invoiceId = hoaDon.MaHoaDon.ToString();
            string ngayLap = hoaDon.ThoiGianThanhToan.ToString("dd/MM/yyyy");
            string trangThai = hoaDon.TrangThai;
            string tongTien = hoaDon.TongTien.ToString() + "VND";
            string soghe = "";
            foreach (chitiet ct in danhSachChuyenXe)
            {
                soghe += " " + ct.SoGhe.ToString();
            }
            StringBuilder html = new StringBuilder();
            html.Append("<html><head><style>");
            html.Append("table {width: 100%; border-collapse: collapse;}");
            html.Append("th, td {border: 1px solid black; padding: 8px; text-align: left;}");
            html.Append("th {background-color: #f2f2f2;}");
            html.Append("</style></head><body>");
            html.Append("<h2>Hóa Đơn</h2>");
            html.Append("<p>Mã hóa đơn: " + invoiceId + "</p>");
            html.Append("<p>Ngày lập: " + ngayLap + "</p>");
            html.Append("<p>Trạng thái: " + trangThai + "</p>");
            html.Append("<p>Tổng tiền: " + tongTien + "</p>");
            html.Append("<p>Chuyến xe số: " + danhSachChuyenXe[0].TenChuyen + "</p>");
            html.Append("<p>Số ghế: " + soghe + "</p>");
            html.Append("</body></html>");
            return html.ToString();
        }
    }



    //calss bo sung cho viec hien thi 
    public class chitiet
    {
        public string TenChuyen { get; set; }
        public decimal GiaVe { get; set; }
        public int SoGhe { get; set; }
    }
}