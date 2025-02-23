using BLL;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static xediep.DAL.DataSet1;

namespace xediep
{
    public partial class MQuanTri : System.Web.UI.MasterPage
    {
        NguoiDung NguoiDung =new NguoiDung();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Checkcoki();
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

                if (user != null && user["VaiTro"].ToString()=="QuanTri") // Token hợp lệ
                {
                    NguoiDung = new NguoiDung(user);
                    lblNameAdmin.Text = "Id Admin :" + NguoiDung.MaNguoiDung;
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

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            NguoiDungBLL.Instance.Logout(Request.Cookies["AuthToken"].Value);
            Checkcoki() ;
        }
        [WebMethod]
        public string SoLuongYeuCauThanhToan()
        {
            return "";
        } 
    }
}