using BLL;
using DAL;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace xediep
{
    public partial class DatVe : Page
    {
        private const int TotalSeats = 36; // Tổng số ghế
        
        private  string idChuyenXe; // ID chuyến xe từ query string
        private string[] trangThaiGhe; // Mảng trạng thái ghế
        private  NguoiDung NguoiDungnow;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                idChuyenXe = Request.QueryString["id"];
                if (string.IsNullOrEmpty(idChuyenXe))
                {
                    Response.Write("ID chuyến xe không hợp lệ.");
                    Response.End();
                }
               
                LvDanhGia.DataSource = DanhGiaBLL.Instance.GetDanhGiaByMaCX(int.Parse(idChuyenXe));
                LvDanhGia.DataBind();
                trangThaiGhe = new string[TotalSeats];
                for (int i = 0; i < TotalSeats; i++)
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
                if (Session["DanhSachGhe"] != null)
                {
                    foreach(int soGhe in TachChuoiGheTrongSess(Session["DanhSachGhe"].ToString())) {
                        DatVeBLL.Instance.InsertDatVe(0, int.Parse(idChuyenXe), NguoiDungnow.MaNguoiDung, 1, DateTime.Now, txtHoTen.Text, txtSoDienThoai.Text, soGhe, int.Parse(ddlDiemDon.SelectedValue), int.Parse(ddlDiemTra.SelectedValue));
                    
                    }
                    Session["DanhSachGhe"] = null;
                    Response.Redirect("TrangChu.aspx");
                }
            }
            
            
            
        }
       
        protected void ddlDonchang(object sender, EventArgs e)
        {
            string selectedValue = ddlDiemDon.SelectedValue;
            ViewState["DiemDon"]= selectedValue;
            Session["DiemDon"] = selectedValue;
           

            

        }
        protected void ddltrachang(object sender, EventArgs e) 
        {

            string selectedValue = ddlDiemTra.SelectedValue;
            ViewState["DiemTra"] = selectedValue;
            Session["DiemTra"] = selectedValue;



        }
        private void CapNhatTrangThaiGhe(List<GheNgoi> danhSachGhe, string[] trangThaiGhe)
        {
            foreach (var ghe in danhSachGhe)
            {
                if (ghe.DaDat == 1 && ghe.SoGhe >= 1 && ghe.SoGhe <= TotalSeats)
                {
                    trangThaiGhe[ghe.SoGhe - 1] = "1";
                }
            }
        }
        void loaddlDiemDiDiemDon()
        {
            foreach (DiemDonTraKhach diem in DiemDonTraKhachBLL.Instance.GetListDiemDonByIDChuyenXe(int.Parse(idChuyenXe)))
            {
                ddlDiemDon.Items.Add(new ListItem(diem.TenDiem + "(" + diem.DiaChi + ")" , diem.MaDiem.ToString()));
                

            }
            foreach (DiemDonTraKhach diem in DiemDonTraKhachBLL.Instance.GetListDiemTraByIDChuyenXe(int.Parse(idChuyenXe)))
            {
                
                ddlDiemTra.Items.Add(new ListItem(diem.TenDiem + "(" + diem.DiaChi + ")", diem.MaDiem.ToString()));
                
            }
        }

        public static List<int> TachChuoiGheTrongSess(string input)
        {
            return input.Split(',')
                        .Select(s => s.Trim()) // Xóa khoảng trắng
                        .Where(s => !string.IsNullOrEmpty(s)) // Loại bỏ phần tử rỗng
                        .Select(int.Parse) // Chuyển thành số nguyên
                        .ToList();
        }

        void Checkcoki()
        {
            if (!IsPostBack)
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
        }

        [WebMethod]
        public static string SaveSelectedSeats(string selectedSeatsJson)
        {

            try
            {
                var selectedSeats = JsonConvert.DeserializeObject<List<int>>(selectedSeatsJson);
                if (selectedSeats != null && selectedSeats.Count > 0)
                {
                    string selectedSeatsDisplay = string.Join(", ", selectedSeats);

                    // Lưu vào Session (hoặc cơ sở dữ liệu nếu cần)
                    HttpContext.Current.Session["DanhSachGhe"] = selectedSeatsDisplay;
                    ScriptManager.RegisterStartupScript(HttpContext.Current.Handler as Page, typeof(Page), "Reload", "window.location.reload();", true);
                    return $"Thành Công Đặt Ghế Số: {selectedSeatsDisplay}";
                    
                }
                return "Không có ghế nào được chọn.";

            }
            catch (Exception ex)
            {
                return "Lỗi: " + ex.Message;
            }
        }
    }
}
