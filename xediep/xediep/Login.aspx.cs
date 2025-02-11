using BLL;
using System;
using System.Web;
using System.Web.UI;

namespace xediep
{
    public partial class Login : Page
    {
        private NguoiDungBLL userBll = new NguoiDungBLL();

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string Username = username.Value;
            string Password = password.Value;

            string token = userBll.Login(Username, Password);

            if (token != null)
            {
                HttpCookie authCookie = new HttpCookie("AuthToken", token);
                authCookie.Expires = DateTime.Now.AddHours(1);
                authCookie.HttpOnly = true;
                Response.Cookies.Add(authCookie);

                Response.Redirect("TrangChu.aspx");
            }
            else
            {
                lblMessage.Text = "Thông tin đăng nhập không đúng.";
            }
        }
    }
}
