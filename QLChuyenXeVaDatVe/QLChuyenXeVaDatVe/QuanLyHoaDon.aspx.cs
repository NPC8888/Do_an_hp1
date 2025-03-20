using Models;
using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using QLChuyenXeVaDatVe.BLL;
using Newtonsoft.Json;
using BLL;
using System.Data;
using System.Xml.Linq;
namespace xediep
{
    public partial class QuanLyHoaDon : System.Web.UI.Page
    {
        protected string doanhThu24h;
        protected decimal[] doanhthutheoloai;


        HoaDonBLL hd = new HoaDonBLL();
        List<HoaDon> lHD = new List<HoaDon>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Chỉ load dữ liệu khi trang được tải lần đầu
            {
                LoadXeKhachData();

            }
        }

        private void LoadXeKhachData()
        {

            gvXeKhach.DataSource = hd.GetAllHoaDon();
            gvXeKhach.DataBind();
            DateTime a = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            txtS.Text = a.ToString("yyyy-MM-dd"); // Định dạng đúng cho TextBox Date
            txtE.Text = a.AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd"); // Lấy ngày cuối tháng
            decimal[] doanhThu = hd.TinhDoanhThuTheo24h(a, a.AddMonths(1).AddSeconds(-1));
            decimal[] dh = hd.TinhDoanhThuTTuyenandTTiep(a, a.AddMonths(1).AddSeconds(-1));
            doanhThu24h = JsonConvert.SerializeObject(doanhThu);
            doanhthutheoloai = dh;

        }
        // Delete XeKhach
        protected void ThongKe(object sender, EventArgs e)
        {
            DateTime dateS = DateTime.Parse(txtS.Text);
            DateTime dateE = DateTime.Parse(txtE.Text);
            var hoadons = hd.GetAllHoaDonByDate(dateS, dateE);
            DateTime ngayBatDau = dateS;
            DateTime ngayKetThuc = dateE.AddHours(23).AddMinutes(59).AddSeconds(59);
            decimal[] doanhThu = hd.TinhDoanhThuTheo24h(ngayBatDau, ngayKetThuc);
            decimal[] dh = hd.TinhDoanhThuTTuyenandTTiep(ngayBatDau, ngayKetThuc);
            doanhThu24h = JsonConvert.SerializeObject(doanhThu);
            doanhthutheoloai = dh;
            if (hoadons.Any())
            {
                gvXeKhach.DataSource = hoadons;
                gvXeKhach.DataBind();
            }
            else
            {
                Response.Write("<script>alert('Không có hóa đơn nào!');</script>");
            }
        }


        // Handle selecting an item from GridView (to edit)

        protected void gvXeKhach_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvXeKhach.SelectedIndex;
            string mahd = gvXeKhach.DataKeys[index].Values["MaHoaDon"].ToString();
            HttpCookie authCookie = Request.Cookies["AuthToken"];
            if (authCookie != null)
            {
                DataRow dr = NguoiDungBLL.Instance.AuthenticateByToken(authCookie.Value);
                NguoiDung ng = new NguoiDung(dr);
                Session["Role"] = ng.MaNguoiDung;
            }
            Response.Redirect($"TrangChiTietHoaDon.aspx?id={mahd}");
        }
        protected void ThemMoi(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }
    }
}