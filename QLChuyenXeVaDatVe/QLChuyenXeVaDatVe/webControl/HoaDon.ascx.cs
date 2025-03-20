using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLChuyenXeVaDatVe.webControl
{
    public partial class HoaDon : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHoaDon();
            }
        }

        private void LoadHoaDon()
        {
            // Giả lập dữ liệu hóa đơn
            lblNgayDat.Text = DateTime.Now.ToString("dd/MM/yyyy");
            lblTrangThai.Text = "Đã Thanh Toán";
            lblTongTien.Text = "500.000 VNĐ";

            // Giả lập danh sách vé xe
            gvDanhSachVe.DataSource = new List<object>
            {
                new { MaVe = "V001", TenXe = "Xe A", Gia = "200.000 VNĐ" },
                new { MaVe = "V002", TenXe = "Xe B", Gia = "300.000 VNĐ" }
            };
            gvDanhSachVe.DataBind();
        }

        protected void btnDanhGia_Click(object sender, EventArgs e)
        {
            Response.Redirect("DanhGiaXe.aspx"); // Chuyển đến trang đánh giá
        }

        protected void btnNhanHoaDon_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Hóa đơn điện tử đã được gửi qua email');</script>");
        }
    }
}