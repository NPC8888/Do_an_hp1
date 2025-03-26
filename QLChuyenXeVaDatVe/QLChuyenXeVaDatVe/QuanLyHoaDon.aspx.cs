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
using QLChuyenXeVaDatVe;
using xediep.Models;
namespace xediep
{
    public partial class QuanLyHoaDon : System.Web.UI.Page
    {
        protected string doanhThu24h;
        protected decimal[] doanhthutheoloai;

        ChiTietHoaDonBLL cthd = new ChiTietHoaDonBLL();
        HoaDonBLL hd = new HoaDonBLL();
        List<HoaDon> lHD = new List<HoaDon>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
                loadLoaiBaoCao();
            }
            decimal[] doanhThu = hd.TinhDoanhThuTheo24h(DateTime.Parse(txtS.Text), DateTime.Parse(txtE.Text).AddMonths(1).AddSeconds(-1));
            decimal[] dh = hd.TinhDoanhThuTTuyenandTTiep(DateTime.Parse(txtS.Text), DateTime.Parse(txtE.Text).AddMonths(1).AddSeconds(-1));
            doanhThu24h = JsonConvert.SerializeObject(doanhThu);
            doanhthutheoloai = dh;

        }

        private void LoadData()
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
        void loadLoaiBaoCao()
        {
            ddlLoaiBaoCao.Items.Clear();
            ddlLoaiBaoCao.Items.Add(new ListItem("Theo ngày", "Ngay"));
            ddlLoaiBaoCao.Items.Add(new ListItem("Theo tháng", "Thang"));
            ddlLoaiBaoCao.Items.Add(new ListItem("Theo năm", "Nam"));
        }
        // Delete XeKhach
        protected void ThongKe(object sender, EventArgs e)
        {
            DateTime dateS = DateTime.Parse(txtS.Text);
            DateTime dateE = DateTime.Parse(txtE.Text);

            DateTime ngayBatDau = dateS.AddHours(0).AddMinutes(0).AddSeconds(01);
            DateTime ngayKetThuc = dateE.AddHours(23).AddMinutes(59).AddSeconds(59);
            var hoadons = hd.GetAllHoaDonByDate(ngayBatDau, ngayKetThuc);
            decimal[] doanhThu = hd.TinhDoanhThuTheo24h(ngayBatDau, ngayKetThuc);
            decimal[] dh = hd.TinhDoanhThuTTuyenandTTiep(ngayBatDau, ngayKetThuc);
            doanhThu24h = JsonConvert.SerializeObject(doanhThu);
            doanhthutheoloai = dh;
            if (hoadons.Any())
            {
                lHD = hoadons;
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
            loadLoaiBaoCao();
            txtStar.Text = DateTime.Parse(txtS.Text).ToString("yyyy-MM-dd");
            txtEnd.Text = DateTime.Parse(txtE.Text).ToString("yyyy-MM-dd");
            DateTime dateS = DateTime.Parse(txtS.Text);
            DateTime dateE = DateTime.Parse(txtE.Text);
            DateTime ngayBatDau = dateS.AddHours(0).AddMinutes(0).AddSeconds(01);
            DateTime ngayKetThuc = dateE.AddHours(23).AddMinutes(59).AddSeconds(59);
            var hoadons = hd.GetAllHoaDonByDate(ngayBatDau, ngayKetThuc);
            decimal tongtien = 0;
            int tongve = 0;
            foreach (var hd in hoadons)
            {
                tongtien += hd.TongTien;
                foreach (var ct in cthd.GetChiTietHoaDonByMaHD(hd.MaHoaDon))
                {
                    tongve++;
                }
            }
            txtTongTien.Text = tongtien.ToString();
            txtTongVe.Text = tongve.ToString();
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }
        protected void TaoBaoCao(object sender, EventArgs e)
        {
            BaoCao bao = new BaoCao { LoaiBaoCao = ddlLoaiBaoCao.SelectedValue, NgayBatDau = DateTime.Parse(txtS.Text), NgayKetThuc = DateTime.Parse(txtE.Text), TongDoanhThu = decimal.Parse(txtTongTien.Text), TongSoVe = int.Parse(txtTongVe.Text) };
            if (BaoCaoBLL.Instance.InsertBaoCao(bao) == true)
            {
                Response.Write("<script>alert('Tạo báo cáo thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Tạo báo cáo thất bại!');</script>");
            }
        }

        protected void txtE_TextChanged(object sender, EventArgs e)
        {

        }
    }
}