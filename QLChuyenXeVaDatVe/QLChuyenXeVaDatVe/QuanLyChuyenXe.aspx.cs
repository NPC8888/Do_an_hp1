using BLL;
using DAL;
using Models;
using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.BLL.BLL;
using xediep.Models;

namespace xediep
{
    public partial class QuanLyChuyenXe : System.Web.UI.Page
    {
        DataProvider dataProvider = new DataProvider();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadXeKhachData();
                LoadDDLTuyenXe();
                LoadDDLTaiXe();
                LoadDDLXe();
            }
        }

        // Load XeKhach data into GridView
        private void LoadXeKhachData()
        {
            List<ChuyenXe> ChuyenXe = ChuyenXeBLL.Instance.GetALLChuyenXe();
            gvXeKhach.DataSource = ChuyenXe;
            gvXeKhach.DataBind();


        }
        private void LoadDDLTuyenXe()
        {
            List<TuyenXe> list = TuyenXeBLL.Instance.GetALLTuyenXe();
            foreach (TuyenXe item in list)
            {
                ddlTuyenXe.Items.Add(new ListItem(item.DiemDi + " - " + item.DiemDen, item.MaTuyenXe.ToString()));
            }

        }
        private void LoadDDLTaiXe()
        {
            List<NguoiDung> list = NguoiDungBLL.Instance.GetAllTaiXe();
            foreach (NguoiDung item in list)
            {
                ddlTaiXe.Items.Add(new ListItem(item.HoTen, item.MaNguoiDung.ToString()));
            }

        }
        private void LoadDDLXe()
        {
            List<XeKhach> list = XeKhachBLL.Instance.GetAllXeKhach();
            foreach (XeKhach item in list)
            {
                ddlXe.Items.Add(new ListItem(item.LoaiXe + "-" + item.BienSoXe + "(" + item.SoChoNgoi + "Chỗ)", item.MaXe.ToString()));
            }

        }

        // Add XeKhach
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            ChuyenXe newCX = new ChuyenXe
            {

                MaTuyenXe = int.Parse(ddlTuyenXe.SelectedValue),
                TgDen = DateTime.Parse(txtTgDen.Text),
                TgKhoiHanh = DateTime.Parse(txtTgKhoiHanh.Text),
                Price = decimal.Parse(txtPrice.Text),
                TrangThai = txtTrangThai.Text,
                MaTaiXe = int.Parse(ddlTaiXe.SelectedValue),
                MaXe = int.Parse(ddlXe.SelectedValue)


            };

            bool result = ChuyenXeBLL.Instance.InsertChuyenXe(newCX);
            if (result)
            {
                LoadXeKhachData();

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
            if (gvXeKhach.SelectedRow != null) // Kiểm tra xem có dòng nào được chọn không
            {


                ChuyenXe updatedXe = new ChuyenXe
                {
                    MaCx = int.Parse(txtMaCX.Text),
                    MaTuyenXe = int.Parse(ddlTuyenXe.SelectedValue),
                    TgDen = DateTime.Parse(txtTgDen.Text),
                    TgKhoiHanh = DateTime.Parse(txtTgKhoiHanh.Text),
                    Price = decimal.Parse(txtPrice.Text),
                    TrangThai = txtTrangThai.Text,
                    MaTaiXe = int.Parse(ddlTaiXe.SelectedValue),
                    MaXe = int.Parse(ddlXe.SelectedValue)


                };
                bool result = ChuyenXeBLL.Instance.UpdateChuyenXe(updatedXe);
                if (result)
                {
                    LoadXeKhachData();

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
            int macx = int.Parse(txtMaCX.Text);
            bool result = ChuyenXeBLL.Instance.DeleteChuyenXe(macx);
            if (result)
            {
                LoadXeKhachData();

                Response.Write("<script>alert('Xóa thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi xóa!');</script>");
            }
        }

        // Handle selecting an item from GridView (to edit)

        protected void gvXeKhach_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ dòng được chọn
            GridViewRow row = gvXeKhach.SelectedRow;
            foreach (GridViewRow r in gvXeKhach.Rows)
            {
                r.CssClass = "";
            }
            row.CssClass = "selected-row";

            int index = gvXeKhach.SelectedIndex;

            // Lấy dữ liệu từ DataKeys (không bị mã hóa)
            string maCX = gvXeKhach.DataKeys[index].Values["MaCX"].ToString();
            string maTuyenXe = gvXeKhach.DataKeys[index].Values["MaTuyenXe"].ToString();
            string tgKhoiHanh = gvXeKhach.DataKeys[index].Values["TgKhoiHanh"].ToString();
            string tgDen = gvXeKhach.DataKeys[index].Values["TgDen"].ToString();
            string price = gvXeKhach.DataKeys[index].Values["Price"].ToString();
            string maTaiXe = gvXeKhach.DataKeys[index].Values["MaTaiXe"].ToString();
            string maXe = gvXeKhach.DataKeys[index].Values["MaXe"].ToString();
            string trangThai = gvXeKhach.DataKeys[index].Values["TrangThai"].ToString();


            // Đổ dữ liệu vào TextBox trong popup
            txtMaCX.Text = maCX;
            ddlTuyenXe.SelectedValue = maTuyenXe;
            txtTgKhoiHanh.Text = DateTime.Parse(tgKhoiHanh).ToString("yyyy-MM-ddTHH:mm"); ;
            txtTgDen.Text = DateTime.Parse(tgDen).ToString("yyyy-MM-ddTHH:mm");
            txtPrice.Text = price;
            ddlTaiXe.SelectedValue = maTaiXe;
            ddlXe.SelectedValue = maXe;
            txtTrangThai.Text = trangThai;
            //hiện btn fix,delete
            btnFix.Visible = true;
            btnDelete.Visible = true;


            // Gọi hàm JavaScript để mở popup
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }

        protected void ThemMoi(object sender, EventArgs e)
        {
            txtMaCX.Text = "";
            ddlTuyenXe.SelectedValue = null;
            txtTgKhoiHanh.Text = "";
            txtTgDen.Text = "";
            txtPrice.Text = "";
            ddlTaiXe.SelectedValue = null;
            ddlXe.SelectedValue = null;
            txtTrangThai.Text = "";
            //ẩn btn fix,delete
            btnFix.Visible = false;
            btnDelete.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }
        // Clear form fields


        protected void gvHoaDon_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ChiTiet")
            {
                // Lấy chỉ mục của hàng chứa nút được nhấn
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                // Lấy dữ liệu từ hàng tương ứng
                GridViewRow row = gvXeKhach.Rows[rowIndex];
                string maHoaDon = row.Cells[0].Text; // Lấy Mã Hóa Đơn từ cột đầu tiên

                // Chuyển hướng đến trang chi tiết hóa đơn
                Response.Redirect("ChiTietChuyenXe.aspx?id=" + maHoaDon);
            }
        }

        protected void ThongKe(object sender, EventArgs e)
        {
            if (txtE.Text == null || txtE.Text.Length == 0 || txtS.Text == null || txtS.Text.Length == 0)
            {
                Response.Write("<script>alert('Vui lòng điền đầy đủ ngày bắt đầu ngày kết thúc!');</script>");
                return;
            }
           List<ChuyenXe> chuyenXes = new List<ChuyenXe>();
           foreach(var cx in ChuyenXeBLL.Instance.GetALLChuyenXe())
            {
                DateTime startDate, endDate;
                if (DateTime.TryParse(txtS.Text, out startDate) && DateTime.TryParse(txtE.Text, out endDate))
                {
                    endDate = endDate.Date.AddHours(23).AddMinutes(59).AddSeconds(59);
                    if (cx.TgKhoiHanh >= startDate && cx.TgKhoiHanh <= endDate)
                    {
                        chuyenXes.Add(cx);
                    }
                }
            }
            gvXeKhach.DataSource = chuyenXes;
            gvXeKhach.DataBind();

        }



    }
}
