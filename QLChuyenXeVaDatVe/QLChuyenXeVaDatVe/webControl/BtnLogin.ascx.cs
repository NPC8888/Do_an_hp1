using BLL;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static xediep.DAL.DataSet1;

namespace xediep.webControl
{
    public partial class BtnLogin : System.Web.UI.UserControl
    {
        public string AuthTokenExists = "false"; // Mặc định chưa đăng nhập
        HttpCookie authCookie;
        public string txtbnt="Đăng Nhập";
        protected void Page_Load(object sender, EventArgs e)
        {
            
             authCookie = Request.Cookies["AuthToken"];
            if (authCookie != null)
            {
                AuthTokenExists = "true"; // Có cookie, đã đăng nhập
                txtbnt = "Tài Khoảng";
                profile.Text = txtbnt;
            }
            else
            {
                txtbnt = "Đăng Nhập";
            }
        }

        protected void btnProfile(object sender, EventArgs e)
        {
            if (AuthTokenExists=="true")
            {
                string token = authCookie.Value;
                NguoiDungBLL userBLL = new NguoiDungBLL();
                DataRow user = userBLL.AuthenticateByToken(token);

                if (user != null) // Token hợp lệ
                {
                    NguoiDung NguoiDungnow = new NguoiDung(user);
                    Response.Redirect($"Profile.aspx?id={NguoiDungnow.MaNguoiDung.ToString()}");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }

    }
}

