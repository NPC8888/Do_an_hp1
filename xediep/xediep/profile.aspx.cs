using BLL;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
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

        private void LoadUserInfo()
        {

            DataRow uses = NguoiDungBLL.Instance.AuthenticateByToken(Request.Cookies["AuthToken"].Value);
            use = new NguoiDung(uses);
            Response.Write(use.MaNguoiDung);
            lblFullName.Text = use.HoTen;
            lblEmail.Text = use.EMai;
            lblPhone.Text = use.SDT;
            editFullName.Value = use.HoTen;
            editEmail.Value = use.EMai;
            editPhone.Value = use.SDT;

        }

        public void btnFix(object sender, EventArgs e)
        {
            DataRow uses = NguoiDungBLL.Instance.AuthenticateByToken(Request.Cookies["AuthToken"].Value);
            use = new NguoiDung(uses);

            NguoiDungBLL.Instance.FixProfile(use.MaNguoiDung.ToString(), editFullName.Value, editPhone.Value, editEmail.Value);

            LoadUserInfo();
        }

        private void LoadTicketHistory()
        {
            // Dữ liệu giả lập - thay bằng database
            var tickets = DatVeBLL.Instance.GetDTVebyIdNguoiDung(Request.QueryString["id"].ToString());


            gvTickets.DataSource = tickets;
            gvTickets.DataBind();
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





    }
}
