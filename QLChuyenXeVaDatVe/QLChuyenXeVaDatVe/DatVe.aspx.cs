using BLL;
using DAL;
using Models;
using Newtonsoft.Json;
using QLChuyenXeVaDatVe.BLL;
using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.EnterpriseServices.Internal;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.Models;
using xediep;

namespace xediep
{
    public partial class DatVe : Page
    {


        private string idChuyenXe; // ID chuyến xe từ query string
        private string idtuyenXe; // ID tuyến xe từ chyuyenxe
        public string[] trangThaiGhe; // Mảng trạng thái ghế
        private NguoiDung NguoiDungnow;
        public ChuyenXe cx = new ChuyenXe();
        public XeKhach xe = new XeKhach();
        public int tang;
        public int day;
        public int ghe;
        public XacThucThanhToanBLL xacThucThanhToanBLL = new XacThucThanhToanBLL();



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

               
                if (Request.QueryString["id"] == null)
                {
                    Response.Write("Lỗi: Không có ID chuyến xe.");
                }
                else
                {
                    idChuyenXe = Request.QueryString["id"].ToString();
                }


                cx = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(int.Parse(idChuyenXe));

                xe = XeKhachDAL.Instance.XeKhachByMaXe(cx.MaXe);
                lblmaxe.Text = xe.LoaiXe;
                lblTripName.Text = cx.MaCx.ToString();
                lblDepartureTime.Text = cx.TgKhoiHanh.ToString();
                idtuyenXe = cx.MaTuyenXe.ToString();
                lblTotalPrice.Text = cx.Price.ToString();

                


                if (string.IsNullOrEmpty(idChuyenXe))
                {
                    Response.Write("ID chuyến xe không hợp lệ.");
                    Response.End();
                }


                trangThaiGhe = new string[150];
                for (int i = 0; i < 150; i++)
                {
                    trangThaiGhe[i] = "0";
                }

                // Lấy trạng thái ghế từ cơ sở dữ liệu
                var danhSachGhe = GheNgoiDAL.Instance.GetListGheNgoibyId(idChuyenXe);
                CapNhatTrangThaiGhe(danhSachGhe, trangThaiGhe);

                // Lưu vào ViewState để hiển thị
                ViewState["SeatStatus"] = trangThaiGhe;
                loaddlDiemDiDiemDon();
                Checkcoki();




            }
        }






        private void CapNhatTrangThaiGhe(List<GheNgoi> danhSachGhe, string[] trangThaiGhe)
        {
            tang = xe.SoTang;
            day = xe.SoDay;
            ghe = xe.SoGheMoiDay;
            foreach (var ghe in danhSachGhe)
            {
                if (ghe.DaDat == 1 && ghe.SoGhe >= 1)
                {
                    trangThaiGhe[ghe.SoGhe] = "1";
                }
            }
        }
        void loaddlDiemDiDiemDon()
        {
            foreach (DiemDonTraKhach diem in DiemDonTraKhachBLL.Instance.GetListDiemDonByIDtuyenXe(int.Parse(idtuyenXe)))
            {
                ddlDiemDon.Items.Add(new ListItem(diem.TenDiem + "(" + diem.DiaChi + ")", diem.MaDiem.ToString()));


            }
            foreach (DiemDonTraKhach diem in DiemDonTraKhachBLL.Instance.GetListDiemTraByIDtuyenXe(int.Parse(idtuyenXe)))
            {

                ddlDiemTra.Items.Add(new ListItem(diem.TenDiem + "(" + diem.DiaChi + ")", diem.MaDiem.ToString()));

            }

        }




        void Checkcoki()
        {

            HttpCookie authCookie = Request.Cookies["AuthToken"];
            if (authCookie != null)
            {
                string token = authCookie.Value;
                NguoiDungBLL userBLL = new NguoiDungBLL();
                DataRow user = userBLL.AuthenticateByToken(token);

                if (user != null) // Token hợp lệ
                {
                    NguoiDungnow = new NguoiDung(user);
                    txtHoTen.Text = NguoiDungnow.HoTen;
                    txtSoDienThoai.Text = NguoiDungnow.SDT;
                    //   txtGmail.Text = NguoiDungnow.EMai;
                    lbID.Text = NguoiDungnow.MaNguoiDung.ToString();
                }
                else
                {
                    // Token không hợp lệ, chuyển về trang đăng nhập
                    Response.Redirect("Login.aspx");
                }
            }
            else
            {
                // Không có token, chuyển về trang đăng nhập
                Response.Redirect("Login.aspx");
            }

        }
        public static List<int> TachChuoiThanhList(string input)
        {
            return input.Split(',')
                        .Select(int.Parse)  // Chuyển đổi từng phần tử thành số nguyên
                        .ToList();          // Chuyển thành danh sách
        }





        [WebMethod]
        public static string SaveBooking(string MaChuyenXe, string Hoten, string SoDT, string soghe, string MaDiemDon, string MaDiemTra, string tongtieng)
        {
            try
            {
                HttpCookie authCookie = HttpContext.Current.Request.Cookies["AuthToken"];
                if (authCookie != null)
                {
                    NguoiDung nguoi = new NguoiDung();
                    string token = authCookie.Value;
                    foreach (var ng in NguoiDungBLL.Instance.GetAll())
                    {
                        if (ng.Token == token)
                        {
                            nguoi = ng;
                        }
                    }
                    if (nguoi.MaNguoiDung == 0 || nguoi == null)
                    {
                        return "Lỗi: Không tìm thấy khách hàng.";
                    }


                    VeXeBLL veXeBLL = new VeXeBLL();
                    HoaDonBLL hoaDonBLL = new HoaDonBLL();
                    HoaDon a = new HoaDon { TongTien = decimal.Parse(tongtieng.ToString()), TrangThai = "DaThanhToan", MaKhachHang = nguoi.MaNguoiDung };

                    int mahoadon = hoaDonBLL.InsertHoaDonCallbackmahoadon(a);
                    ChiTietHoaDonBLL chiTietHoaDonBLL = new ChiTietHoaDonBLL();
                    ChuyenXe chuyen = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(int.Parse(MaChuyenXe));

                    ThanhToanBLL thanhToanBLL = new ThanhToanBLL();
                    if (mahoadon == 0)
                    {
                        return "Lỗi: Không thể tạo hóa đơn.";
                    }
                    ThanhToan thanhToan = new ThanhToan { MaHoaDon = mahoadon, PhuongThucThanhToan = "online", TrangThai = "thanhcong" };

                    thanhToanBLL.InsertThanhToan(thanhToan);
                    foreach (int soGhe in TachChuoiThanhList(soghe))
                    {
                        int idve = VeXeBLL.Instance.InsertDatVe(0, int.Parse(MaChuyenXe), nguoi.MaNguoiDung, "DD", DateTime.Now, Hoten, SoDT, soGhe, int.Parse(MaDiemDon), int.Parse(MaDiemTra));

                        ChiTietHoaDon chiTietHoaDon = new ChiTietHoaDon { MaHoaDon = mahoadon, MaVeXe = idve, GiaVe = chuyen.Price };
                        bool chi = chiTietHoaDonBLL.InsertChiTietHoaDon(chiTietHoaDon);
                        if (chi == false)
                        {
                            return "loi";

                        }
                    }

                }
                return "Đã đặt vé thành công số ghế: " + soghe;
            }
            catch (Exception ex)
            {
                return "Lỗi: " + ex.Message;
            }
        }

        [WebMethod]
        public static string SaveBookingb(string MaChuyenXe, string Hoten, string SoDT, string soghe, string MaDiemDon, string MaDiemTra, string tongtieng)
        {
            try
            {
                HttpCookie authCookie = HttpContext.Current.Request.Cookies["AuthToken"];
                if (authCookie != null)
                {
                    NguoiDung nguoi = new NguoiDung();
                    string token = authCookie.Value;
                    foreach (var ng in NguoiDungBLL.Instance.GetAll())
                    {
                        if (ng.Token == token)
                        {
                            nguoi = ng;
                        }
                    }
                    if (nguoi.MaNguoiDung == 0 || nguoi == null)
                    {
                        return "Lỗi: Không tìm thấy khách hàng.";
                    }


                    VeXeBLL veXeBLL = new VeXeBLL();
                    HoaDonBLL hoaDonBLL = new HoaDonBLL();
                    HoaDon a = new HoaDon { TongTien = decimal.Parse(tongtieng.ToString()), TrangThai = "ChuaThanhToan", MaKhachHang = nguoi.MaNguoiDung };

                    int mahoadon = hoaDonBLL.InsertHoaDonCallbackmahoadon(a);
                    ChiTietHoaDonBLL chiTietHoaDonBLL = new ChiTietHoaDonBLL();
                    ChuyenXe chuyen = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(int.Parse(MaChuyenXe));


                    foreach (int soGhe in TachChuoiThanhList(soghe))
                    {
                        int idve = VeXeBLL.Instance.InsertDatVe(0, int.Parse(MaChuyenXe), nguoi.MaNguoiDung, "DD", DateTime.Now, Hoten, SoDT, soGhe, int.Parse(MaDiemDon), int.Parse(MaDiemTra));

                        ChiTietHoaDon chiTietHoaDon = new ChiTietHoaDon { MaHoaDon = mahoadon, MaVeXe = idve, GiaVe = chuyen.Price };
                        bool chi = chiTietHoaDonBLL.InsertChiTietHoaDon(chiTietHoaDon);
                        if (chi == false)
                        {
                            return "loi";

                        }
                    }

                }
                return "Đã đặt vé thành công số ghế: " + soghe;
            }
            catch (Exception ex)
            {
                return "Lỗi: " + ex.Message;
            }
        }
        [WebMethod]
        public static string KiemTraThanhToan(string tongtieng, string magiaodich)
        {
            return Task.Run(() => KiemTraThanhToanAsync(tongtieng, magiaodich)).Result;
        }

        public static async Task<string> KiemTraThanhToanAsync(string tongtieng, string magiaodich)
        {
            Debug.WriteLine("Bắt đầu kiểm tra thanh toán...");

            XacThucThanhToanBLL thanhToanBLL = new XacThucThanhToanBLL();
            int tongSoLanLap = (2 * 60) / 2;

            for (int i = 0; i < tongSoLanLap; i++)
            {
                Debug.WriteLine($"Lần kiểm tra thứ {i + 1}...");
                string ketQua = await thanhToanBLL.XacThucThanhToan(Convert.ToDouble(tongtieng), magiaodich);

                if (ketQua == "thanhcong") return "thanhcong";
                await Task.Delay(3000);
            }

            return "khongthanhcong";
        }









        // Response.Redirect("TrangChu.aspx");



    }


}

