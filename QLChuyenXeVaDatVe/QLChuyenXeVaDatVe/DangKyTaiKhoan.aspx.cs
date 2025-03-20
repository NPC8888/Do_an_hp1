using BLL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLChuyenXeVaDatVe
{
    public partial class DangKyTaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string email = txtEmail.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            NguoiDung nguoiDung = new NguoiDung()
            {
                HoTen = hoTen,
                EMai = email,
                SDT = sdt,
                MatKhau = password,
                VaiTro = "KhachHang",
                TenDangNhap = email
            };
            if(NguoiDungBLL.Instance.InsertNguoiDung(nguoiDung))
            {
                // Giả lập lưu thông tin vào database (ở đây chỉ hiển thị thông báo thành công)
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Đăng ký thành công!";
            }
        }
    }
}