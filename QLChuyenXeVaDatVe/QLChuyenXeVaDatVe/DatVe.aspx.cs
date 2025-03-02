using BLL;
using DAL;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices.Internal;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.Models;

namespace xediep
{
    public partial class DatVe : Page
    {
       

        private string idChuyenXe; // ID chuyến xe từ query string
        private string idtuyenXe; // ID tuyến xe từ chyuyenxe
        public string[] trangThaiGhe; // Mảng trạng thái ghế
        private NguoiDung NguoiDungnow;
        public ChuyenXe cx=new ChuyenXe();
        public XeKhach xe=new XeKhach();
        public int tang;
        public int day;
        public int ghe;

        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                idChuyenXe = Request.QueryString["id"];

                
                cx = ChuyenXeDAL.Instance.getGiaXeByMaXe(idChuyenXe);
                
                xe = XeKhachDAL.Instance.XeKhachByMaXe(cx.MaXe);
                lblmaxe.Text = xe.LoaiXe;
                lblTripName.Text = cx.MaCx.ToString();
                lblDepartureTime.Text = cx.TgKhoiHanh.ToString();
                idtuyenXe = cx.MaTuyenXe.ToString();
                lblTotalPrice.Text = cx.Price.ToString();
                lblTotalPrice.Text += ":VND";
               
              
                if (string.IsNullOrEmpty(idChuyenXe))
                {
                    Response.Write("ID chuyến xe không hợp lệ.");
                    Response.End();
                }

               
                trangThaiGhe = new string[100];
                for (int i = 0; i < 100; i++)
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
            public static string SaveBooking(string MaChuyenXe, string Hoten, string SoDT, string soghe, string MaDiemDon, string MaDiemTra)
            { 
                HttpCookie authCookie = HttpContext.Current.Request.Cookies["AuthToken"];
                if (authCookie != null)
                {
                    string token = authCookie.Value;
                    NguoiDungBLL userBLL = new NguoiDungBLL();
                    DataRow user = userBLL.AuthenticateByToken(token);
                    NguoiDung nguoi = new NguoiDung(user);
                
                foreach (int soGhe in TachChuoiThanhList(soghe))
                 //   { return MaChuyenXe+nguoi.MaNguoiDung+ Hoten + SoDT + soGhe + MaDiemDon + MaDiemTra;
                    if (VeXeBLL.Instance.InsertDatVe(0, int.Parse(MaChuyenXe), nguoi.MaNguoiDung, "DD", DateTime.Now, Hoten, SoDT, soGhe, int.Parse(MaDiemDon), int.Parse(MaDiemTra)))
                        {
                        

                        }
                        else
                        {
                            return "loi them ve";

                        }
                       
                    }
                return "Đã đặt vé thành công số ghê:"+soghe;
            }
               

                // Response.Redirect("TrangChu.aspx");



            }
            
   
}
    
