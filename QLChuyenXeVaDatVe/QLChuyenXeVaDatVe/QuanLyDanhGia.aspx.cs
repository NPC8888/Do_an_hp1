using BLL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.BLL.BLL;
using xediep.Models;
using xediep.webControl;

namespace QLChuyenXeVaDatVe
{
    public partial class QuanLyDanhGia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDanhGia();
                loadDDL();
            }
        }

        private void LoadDanhGia()
        {
            gvDanhGia.DataSource = DanhGiaBLL.Instance.GetALL();
            gvDanhGia.DataBind();
        }

        private void loadDDL()
        {
            ddlMaNguoiDung.Items.Clear();
            ddlMaXe.Items.Clear();
            var ngs = NguoiDungBLL.Instance.GetAll();
            foreach (var n in ngs)
            {
                ddlMaNguoiDung.Items.Add(new ListItem("ID:" + n.MaNguoiDung.ToString() + ",Tên:"+n.HoTen+" ,Email:" + n.EMai, n.MaNguoiDung.ToString()));
            }
            ddlMaNguoiDung.DataBind();
            var xes = XeKhachBLL.Instance.GetAllXeKhach();
            foreach (var x in xes)
            {
                ddlMaXe.Items.Add(new ListItem("ID:" + x.MaXe.ToString() + " ,Loại:" + x.LoaiXe + " ,Biển số:" + x.BienSoXe, x.MaXe.ToString()));
            }
            ddlMaXe.DataBind();
        }
        protected void btnTim_Click(object sender, EventArgs e)
        {
            string key = txtTim.Text;
            if (key != null && key != "")
            {
                var dgs = DanhGiaBLL.Instance.GetALL();
                var list = dgs.Where(x => BoLoc.TimKiem(x, txtTim.Text)).ToList();
                gvDanhGia.DataSource = list;
                gvDanhGia.DataBind();

            }
            else
            {
                LoadDanhGia();
            }


        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (checkInputDanhGia() == false) return;
            DanhGia newDanhGia = new DanhGia
            {
                MaNguoiDung = int.Parse(ddlMaNguoiDung.SelectedValue),
                BinhLuan = txtBinhLuan.Text,
                MaXe = int.Parse(ddlMaXe.SelectedValue),
                DiemDanhGia = int.Parse(txtDiemDanhGia.Text)
            };
            bool result = DanhGiaBLL.Instance.AddDanhGia(newDanhGia);
            if (result)
            {
                LoadDanhGia();
                Response.Write("<script>alert('Thêm thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi thêm!');</script>");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if(checkInputDanhGia()==false) return;
            if (gvDanhGia.SelectedRow != null)
            {
                DanhGia updatedDanhGia = new DanhGia
                {
                    MaDanhGia = int.Parse(txtMaDanhGia.Text),
                    MaXe = int.Parse(ddlMaXe.SelectedValue),
                    MaNguoiDung = int.Parse(ddlMaNguoiDung.SelectedValue),
                    BinhLuan = txtBinhLuan.Text,
                    DiemDanhGia = int.Parse(txtDiemDanhGia.Text)
                };

                bool result = DanhGiaBLL.Instance.UpdateDanhGia(updatedDanhGia);
                if (result)
                {
                    LoadDanhGia();
                    Response.Write("<script>alert('Cập nhật thành công!');</script>");
                    
                }
                else
                {
                    Response.Write("<script>alert('Lỗi khi cập nhật!');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Vui lòng chọn một đánh giá để chỉnh sửa!');</script>");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int maDanhGia = int.Parse(txtMaDanhGia.Text);

            bool result = DanhGiaBLL.Instance.DeleteDanhGia(maDanhGia);
            if (result)
            {
                LoadDanhGia();
                Response.Write("<script>alert('Xóa thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi xóa!');</script>");
            }
        }

        protected void gvDanhGia_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvDanhGia.SelectedRow;
            foreach (GridViewRow r in gvDanhGia.Rows)
            {
                r.CssClass = "";
            }
            row.CssClass = "selected-row";
            loadDDL();
            int index = gvDanhGia.SelectedIndex;
            string maDanhGia = gvDanhGia.DataKeys[index].Values["MaDanhGia"].ToString();
            var danhgia = DanhGiaBLL.Instance.GetDanhGiaByMaDanhGia(int.Parse(maDanhGia));
            txtMaDanhGia.Text = danhgia.MaDanhGia.ToString();
            ddlMaNguoiDung.SelectedValue = danhgia.MaNguoiDung.ToString();
            ddlMaXe.SelectedValue = danhgia.MaXe.ToString();
            txtBinhLuan.Text = danhgia.BinhLuan.ToString();
            txtDiemDanhGia.Text = danhgia.DiemDanhGia.ToString();

            btnFix.Visible = true;
            btnDelete.Visible = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }
        protected void ThemMoi(object sender, EventArgs e)
        {

            txtMaDanhGia.Text = "";
            loadDDL(); // Load lại danh sách quyền trước
            ddlMaNguoiDung.SelectedIndex = 0;
            ddlMaXe.SelectedIndex = 0;
            txtBinhLuan.Text = "";
            txtDiemDanhGia.Text = "";
            btnAddd.Visible = true;
            btnFix.Visible = false;
            btnDelete.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }

        bool checkInputDanhGia()
        {
            // Kiểm tra không để trống
            if (string.IsNullOrWhiteSpace(txtDiemDanhGia.Text) || string.IsNullOrWhiteSpace(txtBinhLuan.Text))
            {
                Response.Write("<script>alert('Vui lòng nhập đầy đủ thông tin!');</script>");
                return false;
            }

            

            // Kiểm tra Điểm Đánh Giá hợp lệ (1 - 5)
            if (!int.TryParse(txtDiemDanhGia.Text, out int diemDanhGia) || diemDanhGia < 1 || diemDanhGia > 5)
            {
                Response.Write("<script>alert('Điểm đánh giá phải từ 1 đến 5!');</script>");
                return false;
            }

            // Kiểm tra độ dài bình luận
            if (txtBinhLuan.Text.Length < 5 || txtBinhLuan.Text.Length > 500)
            {
                Response.Write("<script>alert('Bình luận phải từ 5 đến 500 ký tự!');</script>");
                return false;
            }

            // Nếu tất cả hợp lệ
            return true;
        }

    }
}

