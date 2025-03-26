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
            if (checkInputUser() == false) return;
            DataRow uses = NguoiDungBLL.Instance.AuthenticateByToken(Request.Cookies["AuthToken"].Value);
            use = new NguoiDung(uses);

            NguoiDungBLL.Instance.FixProfile(use.MaNguoiDung.ToString(), editFullName.Value, editPhone.Value, use.EMai);

            LoadUserInfo();
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
        bool checkInputUser()
        {
            // Kiểm tra không để trống
            if (string.IsNullOrWhiteSpace(editFullName.Value) || string.IsNullOrWhiteSpace(editPhone.Value))
            {
                Response.Write("<script>alert('Vui lòng nhập đầy đủ Họ và Tên, Số Điện Thoại!');</script>");
                return false;
            }

            // Kiểm tra Họ và Tên (Chỉ chứa chữ cái, có khoảng trắng)
            string namePattern = @"^[\p{L} ]+$"; // Hỗ trợ unicode
            if (!System.Text.RegularExpressions.Regex.IsMatch(editFullName.Value, namePattern))
            {
                Response.Write("<script>alert('Họ và Tên chỉ được chứa chữ cái!');</script>");
                return false;
            }

            // Kiểm tra số điện thoại hợp lệ (10 số, bắt đầu bằng 0)
            string phonePattern = @"^0[0-9]{9}$";
            if (!System.Text.RegularExpressions.Regex.IsMatch(editPhone.Value, phonePattern))
            {
                Response.Write("<script>alert('Số điện thoại không hợp lệ! Phải có 10 chữ số và bắt đầu bằng 0.');</script>");
                return false;
            }

            // Nếu tất cả hợp lệ
            return true;
        }


        //danhgia


    }
}
