using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.Models;

namespace QLChuyenXeVaDatVe
{
    public partial class QuanLyTuyenXe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            tuyenxe();

        }
        private void tuyenxe()
        {
            gvTuyenXe.DataSource = TuyenXeBLL.Instance.GetALLTuyenXe();
            gvTuyenXe.DataBind();
            List<string> tinhThanh = new List<string>
        {
            "An Giang", "Bà Rịa - Vũng Tàu", "Bạc Liêu", "Bắc Kạn", "Bắc Giang",
            "Bắc Ninh", "Bến Tre", "Bình Dương", "Bình Định", "Bình Phước",
            "Bình Thuận", "Cà Mau", "Cao Bằng", "Cần Thơ", "Đà Nẵng",
            "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp",
            "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", "Hà Tĩnh",
            "Hải Dương", "Hải Phòng", "Hậu Giang", "Hòa Bình", "Hưng Yên",
            "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lạng Sơn",
            "Lào Cai", "Lâm Đồng", "Long An", "Nam Định", "Nghệ An",
            "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Phú Yên", "Quảng Bình",
            "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng",
            "Sơn La", "Tây Ninh", "Thái Bình", "Thái Nguyên", "Thanh Hóa",
            "Thừa Thiên Huế", "Tiền Giang", "TP. Hồ Chí Minh", "Trà Vinh", "Tuyên Quang",
            "Vĩnh Long", "Vĩnh Phúc", "Yên Bái"
        };
            foreach (string tinh in tinhThanh)
            {
                ddlDiemDi.Items.Add(new ListItem(tinh, tinh));
                ddlDiemDen.Items.Add(new ListItem(tinh, tinh));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            TuyenXe updatedTuyen = new TuyenXe
            {

                DiemDi = ddlDiemDi.Text,
                DiemDen = ddlDiemDen.Text,
                TrangThai = txtTrangThai.Text


            };
            bool result = TuyenXeBLL.Instance.AddTuyenXe(updatedTuyen);
            if (result)
            {
                tuyenxe();

                Response.Write("<script>alert('Thêm thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi thêm !');</script>");
            }
        }

        // Edit XeKhach
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (gvTuyenXe.SelectedRow != null) // Kiểm tra xem có dòng nào được chọn không
            {


                TuyenXe updatedTuyen = new TuyenXe
                {
                    MaTuyenXe = int.Parse(txtMaTuyenXe.Text),
                    DiemDi = ddlDiemDi.Text,
                    DiemDen = ddlDiemDen.Text,
                    TrangThai = txtTrangThai.Text


                };
                bool result = TuyenXeBLL.Instance.EditTuyenXe(updatedTuyen);
                if (result)
                {
                    tuyenxe();

                    Response.Write("<script>alert('Cập nhật xe thành công!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Lỗi khi cập nhật xe!');</script>");
                }
                // Gửi đối tượng updatedXe đến tầng xử lý dữ liệu (BLL/DAL) để cập nhật



            }
            else
            {
                Response.Write("kh");
            }




        }

        // Delete XeKhach
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int macx = int.Parse(txtMaTuyenXe.Text);
            try
            {

                bool result = TuyenXeBLL.Instance.RemoveTuyenXe(macx);
                if (result)
                {
                    tuyenxe();

                    Response.Write("<script>alert('Xóa thành công!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Lỗi khi xóa!');</script>");
                }
            }
            catch
            {
                divxacnhan.Style.Add("display", "block");
            }
        }

        // Handle selecting an item from GridView (to edit)

        protected void gvXeKhach_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ dòng được chọn
            GridViewRow row = gvTuyenXe.SelectedRow;
            foreach (GridViewRow r in gvTuyenXe.Rows)
            {
                r.CssClass = "";
            }
            row.CssClass = "selected-row";

            int index = gvTuyenXe.SelectedIndex;

            //// Lấy dữ liệu từ DataKeys (không bị mã hóa)

            string maTuyenXe = gvTuyenXe.DataKeys[index].Values["MaTuyenXe"].ToString();
            string diemDi = gvTuyenXe.DataKeys[index].Values["DiemDi"].ToString();
            string diemden = gvTuyenXe.DataKeys[index].Values["DiemDen"].ToString();

            string trangThai = gvTuyenXe.DataKeys[index].Values["TrangThai"].ToString();


            // Đổ dữ liệu vào TextBox trong popup
            txtMaTuyenXe.Text = maTuyenXe;

            ddlDiemDi.SelectedValue = diemDi;
            ddlDiemDen.SelectedValue = diemden;
            txtTrangThai.Text = trangThai;
            //hiện btn fix,delete
            btnFix.Visible = true;
            btnDelete.Visible = true;


            // Gọi hàm JavaScript để mở popup
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }

        protected void ThemMoi(object sender, EventArgs e)
        {
            txtMaTuyenXe.Text = "";
            ddlDiemDi.SelectedValue = null;
            ddlDiemDen.SelectedValue = null;
            txtTrangThai.Text = "";
            //ẩn btn fix,delete
            btnFix.Visible = false;
            btnDelete.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }
        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            int macx = int.Parse(txtMaTuyenXe.Text);

            try
            {

                if (txtMaTuyenXe.Text != null)
                {
                    List<ChuyenXe> list = ChuyenXeBLL.Instance.GetALLChuyenXe();
                    foreach (ChuyenXe chuyen in list)
                    {
                        if (chuyen.MaTuyenXe == macx)
                        {
                            ChuyenXeBLL.Instance.DeleteChuyenXe(chuyen.MaCx);
                        }
                    }
                    tuyenxe();
                    bool result = TuyenXeBLL.Instance.RemoveTuyenXe(macx);
                    Response.Write("<script>alert('Xóa thành công!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Lỗi khi xóa!');</script>");

                }
            }
            catch
            {
                Response.Write("<script>alert('Không thể xóa các chuyến xe có vé!');</script>");


            }
        }
        protected void btnHuy_Click(object sender, EventArgs e)
        {
            divxacnhan.Style.Add("display", "none");
        }
    }
}