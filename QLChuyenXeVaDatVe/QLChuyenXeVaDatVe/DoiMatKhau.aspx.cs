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
    public partial class DoiMatKhau : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string oldPassword = txtOldPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string UserName = txtName.Text.Trim();
            // Giả lập mật khẩu cũ (lấy từ CSDL hoặc Session)
            List<NguoiDung> listNguoiDung = NguoiDungBLL.Instance.GetAll();
            NguoiDung nguoiDung1 = new NguoiDung();
            foreach (NguoiDung nguoiDung in listNguoiDung)
            {
                if (nguoiDung.MatKhau == oldPassword && nguoiDung.TenDangNhap == UserName)
                {
                    nguoiDung1 = nguoiDung;
                }

            }

            if (oldPassword != nguoiDung1.MatKhau||UserName!=nguoiDung1.TenDangNhap)
            {
                lblMessage.Text = "❌ Mật khẩu hoặc tên đăng nhập không đúng!";
                return;
            }

            NguoiDung ng = nguoiDung1;
            ng.MatKhau = newPassword;
           
            if (NguoiDungBLL.Instance.UpdateNguoiDung(ng))
            {



                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "✅ Mật khẩu đã được thay đổi thành công!";
                return;



            }
        }
    }
}
