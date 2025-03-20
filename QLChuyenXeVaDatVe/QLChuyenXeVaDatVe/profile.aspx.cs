using BLL;
using Models;
using QLChuyenXeVaDatVe.Models;
using QLChuyenXeVaDatVe.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;

namespace xediep
{
    public partial class profile : System.Web.UI.Page
    {
        string idNguoiDung;


        NguoiDung use = new NguoiDung();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                LoadUserInfo();
                LoadTicketHistory();
                idNguoiDung = Request.QueryString["id"];


            }
        }
        protected void doimatkhau(object sender, EventArgs e)
        {
            Response.Redirect("DoiMatKhau.aspx");
        }
        private void LoadUserInfo()
        {

            DataRow uses = NguoiDungBLL.Instance.AuthenticateByToken(Request.Cookies["AuthToken"].Value);
            use = new NguoiDung(uses);
            lblFullName.Text = use.HoTen;
            lblId.Text = use.MaNguoiDung.ToString();
            lblPhone.Text = use.SDT;
            editFullName.Value = use.HoTen;
            editPhone.Value = use.SDT;

        }

        public void btnFix(object sender, EventArgs e)
        {
            DataRow uses = NguoiDungBLL.Instance.AuthenticateByToken(Request.Cookies["AuthToken"].Value);
            use = new NguoiDung(uses);

            NguoiDungBLL.Instance.FixProfile(use.MaNguoiDung.ToString(), editFullName.Value, editPhone.Value, use.EMai);

            LoadUserInfo();
        }

        private void LoadTicketHistory()
        {
            HoaDonBLL hd = new HoaDonBLL();
            // Dữ liệu giả lập - thay bằng database
            List<HoaDon> lHD = new List<HoaDon>();
            foreach (var item in hd.GetAllHoaDon())
            {
                if (item.MaKhachHang == use.MaNguoiDung)
                {
                    lHD.Add(item);
                }
            }
            


            rptTickets.DataSource = lHD;
            rptTickets.DataBind();
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xóa session
            //  Response.Write(aut.Value);

            NguoiDungBLL.Instance.Logout(Request.Cookies["AuthToken"].Value);
            Session.Clear();
            Session.Abandon();

            // Xóa cookie đăng nhập
            if (Request.Cookies["AuthToken"] != null)
            {

                HttpCookie authCookie = new HttpCookie("AuthToken");

                authCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(authCookie);


            }

            // Xóa tất cả cookie
            foreach (string cookieName in Request.Cookies.AllKeys)
            {
                HttpCookie expiredCookie = new HttpCookie(cookieName);
                expiredCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(expiredCookie);
            }

            // Chuyển hướng về trang Login
            Response.Redirect("TrangChu.aspx");
        }


        //danhgia

        [WebMethod]
        public static string DanhGiaCX(string MaChuyenXe, string SoSao, string NoiDung, string MaDatVe
            )
        {
            
            try { 
            HttpCookie authCookie = HttpContext.Current.Request.Cookies["AuthToken"];
            if (authCookie != null)
            {
                string token = authCookie.Value;
                NguoiDungBLL userBLL = new NguoiDungBLL();
                DataRow user = userBLL.AuthenticateByToken(token);
                NguoiDung nguoi = new NguoiDung(user);
                DanhGia dg = new DanhGia(100, int.Parse(MaChuyenXe),nguoi.MaNguoiDung, int.Parse(SoSao), NoiDung);
                if (DanhGiaBLL.Instance.AddDanhGia(dg)&&VeXeBLL.Instance.FixTrangThaiKhiDanhGia(MaDatVe))
                {

                    return "Danh giá thành công!" ;
                }
                return "that bai";
            }
            
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }

            return "khong co nguoi dung";
            

        }
        [WebMethod]
        public static string HuyVeById(string id)
        {
            try
            {
                if (VeXeBLL.Instance.FixTrangThaiKhiHuy(id.ToString()))
                {
                    return "Hủy Thành Công";

                }
                return "Thất Bại";
            }
            catch(Exception ex)
            {
                return ex.ToString() ;
            }
        }

    }
}
