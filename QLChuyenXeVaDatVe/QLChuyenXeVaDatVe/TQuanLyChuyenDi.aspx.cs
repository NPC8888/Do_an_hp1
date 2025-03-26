using BLL;
using DAL;
using DocumentFormat.OpenXml.Drawing;
using Models;
using QLChuyenXeVaDatVe.BLL;
using QLChuyenXeVaDatVe.Models;
using System;

using System.Collections.Generic;
using xediep.BLL;
using xediep.Models;

namespace QLChuyenXeVaDatVe
{
    public partial class TQuanLyChuyenDi : System.Web.UI.Page
    {
        private string idChuyenXe; // ID chuyến xe từ query string

        public string[] trangThaiGhe; // Mảng trạng thái ghế
        public ChuyenXe cx = new ChuyenXe();
        public XeKhach xe = new XeKhach();
        public int tang;
        public int day;
        public int ghe;
        protected void Page_Load(object sender, EventArgs e)
        {

            idChuyenXe = Request.QueryString["id"];
            cx = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(int.Parse(idChuyenXe));
            xe = XeKhachDAL.Instance.XeKhachByMaXe(cx.MaXe);
            tang = xe.SoTang;
            day = xe.SoDay;
            ghe = xe.SoGheMoiDay;
            trangThaiGhe = new string[150];
            for (int i = 0; i < 150; i++)
            {
                trangThaiGhe[i] = "0";
            }

            // Lấy trạng thái ghế từ cơ sở dữ liệu
            var danhSachGhe = GheNgoiDAL.Instance.GetListGheNgoibyId(idChuyenXe);
            CapNhatTrangThaiGhe(danhSachGhe, trangThaiGhe);
            if (!IsPostBack)
            {


                LoadVeXe();
            }

        }
        protected void btnThanhtoan_click(object sender,EventArgs e)
        {
            HoaDonBLL hdll = new HoaDonBLL();
            ThanhToanBLL thanhToanBLL = new ThanhToanBLL();
            string mahd = lblMaHD.Text;
            HoaDon hd = hdll.GetHoaDonByMaHD(int.Parse(mahd));
            if(hd!= null)
            {
                hd.TrangThai = "DaThanhToan";
                hdll.UpdateTrangThaiHoaDon(hd.MaHoaDon, hd.TrangThai);
                ThanhToan thanh = new ThanhToan { MaHoaDon = hd.MaHoaDon, PhuongThucThanhToan = "ThanhToanTrenXe", ThoiGianThanhToan = DateTime.Now, TrangThai = "DaThanhToan" };
                bool tt = thanhToanBLL.InsertThanhToan(thanh);
                if (tt == true)
                {
                    lblTrangThai.Text = "DaThanhToan";
                    lblThongBao.Text = "Thanh toán thành công";
                    lblThongBao.Style.Add(System.Web.UI.HtmlTextWriterStyle.Color, "green");
                    btnThanhToan.Visible = false;
                }
            }
        }
        protected void _btnTraCuu(object sender, EventArgs e)
        {
            lblThongBao.Style.Add(System.Web.UI.HtmlTextWriterStyle.Color, "red");
            string mahd = txtTraCuu.Text;
            if (mahd != null && mahd != "")
            {
                HoaDonBLL hoaDonBLL = new HoaDonBLL();
                HoaDon hd = hoaDonBLL.GetHoaDonByMaHD(int.Parse(mahd));

                if (hd != null)
                {
                    ChiTietHoaDonBLL chiBLL = new ChiTietHoaDonBLL();
                    List<ChiTietHoaDon> chitiets = chiBLL.GetChiTietHoaDonByMaHD(hd.MaHoaDon);
                    VeXe ve = VeXeBLL.Instance.GetByeMaVe(chitiets[0].MaVeXe);
                    if (ve.MaChuyenXe == int.Parse(Request.QueryString["id"]))
                    {
                        lblMaHD.Text = hd.MaHoaDon.ToString();
                        lblNgayLap.Text = hd.ThoiGianThanhToan.ToString();
                        lblTongTien.Text = hd.TongTien.ToString();
                        lblTrangThai.Text = hd.TrangThai;
                        gvVeXe.DataSource = loadvesByMaHD(hd.MaHoaDon);
                        gvVeXe.DataBind();
                        divTraCuu.Visible = true;
                        lblThongBao.Text = "";
                        if (hd.TrangThai == "ChuaThanhToan")
                        {
                            btnThanhToan.Visible = true;
                        }
                        else
                        {
                            btnThanhToan.Visible = false;
                        }
                    }
                    else
                    {

                        lblThongBao.Text = "Không có quyền!";
                        divTraCuu.Visible = false;
                       
                    }

                }
                else
                {
                    divTraCuu.Visible = false;
                    lblThongBao.Text = "Hóa đơn không tồn tại!";
                    LoadVeXe();
                }

            }
            else
            {
                divTraCuu.Visible = false;
                LoadVeXe();
            }

        }

        private void CapNhatTrangThaiGhe(List<GheNgoi> danhSachGhe, string[] trangThaiGhe)
        {
            
            tang = xe.SoTang;
            day = xe.SoDay;
            ghe = xe.SoGheMoiDay;
            foreach (var ghe in danhSachGhe)
            {
                if (ghe.DaDat == 1 && ghe.SoGhe >= 1)
                {
                    trangThaiGhe[ghe.SoGhe] = "1";
                }
            }
        }

        private void LoadVeXe()
        {
            List<VeXe> vx = new List<VeXe>();
            foreach (var ve in VeXeBLL.Instance.GetALL())
            {
                if (ve.MaChuyenXe == int.Parse(idChuyenXe))
                {
                    vx.Add(ve);
                }
            }
            gvVeXe.DataSource = vx;
            gvVeXe.DataBind();
        }

        List<VeXe> loadvesByMaHD(int mahd)
        {
            List<VeXe> ves = new List<VeXe>();
            ChiTietHoaDonBLL bLL = new ChiTietHoaDonBLL();
            foreach (var c in bLL.GetChiTietHoaDonByMaHD(mahd))
            {

                foreach (var ve in VeXeBLL.Instance.GetALL())
                {
                    if (ve.MaDatVe == c.MaVeXe)
                    {
                        ves.Add(ve);
                        break;
                    }
                }
            }
            return ves;
        }


    }
}
