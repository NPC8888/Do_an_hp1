using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL.BLL;
using xediep.Models;

namespace xediep
{
    public partial class QuanLyXeKhach : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadXeKhach();
        }

        private void LoadXeKhach()
        {
            gvXeKhach.DataSource = XeKhachBLL.Instance.GetAllXeKhach();
            gvXeKhach.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            XeKhach newXe = new XeKhach
            {
                BienSoXe = txtBienSoXe.Text,
                LoaiXe = txtLoaiXe.Text,
                SoChoNgoi = int.Parse(txtSoChoNgoi.Text),
                SoTang = int.Parse(txtSoTang.Text),
                SoDay = int.Parse(txtSoDay.Text),
                SoGheMoiDay = int.Parse(txtSoGheMoiDay.Text)
            };
            bool result = XeKhachBLL.Instance.AddXeKhach(newXe);
            if (result)
            {
                LoadXeKhach();
                Response.Write("<script>alert('Thêm thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi thêm!');</script>");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (gvXeKhach.SelectedRow != null)
            {
                XeKhach updatedXe = new XeKhach
                {
                    MaXe = int.Parse(txtMaXe.Text),
                    BienSoXe = txtBienSoXe.Text,
                    LoaiXe = txtLoaiXe.Text,
                    SoChoNgoi = int.Parse(txtSoChoNgoi.Text),
                    SoTang = int.Parse(txtSoTang.Text),
                    SoDay = int.Parse(txtSoDay.Text),
                    SoGheMoiDay = int.Parse(txtSoGheMoiDay.Text)
                };
                bool result = XeKhachBLL.Instance.EditXeKhach(updatedXe);
                if (result)
                {
                    LoadXeKhach();
                    Response.Write("<script>alert('Cập nhật thành công!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Lỗi khi cập nhật!');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Vui lòng chọn một xe để chỉnh sửa!');</script>");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int maXe = int.Parse(txtMaXe.Text);
            bool result = XeKhachBLL.Instance.RemoveXeKhach(maXe);
            if (result)
            {
                LoadXeKhach();
                Response.Write("<script>alert('Xóa thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi xóa!');</script>");
            }
        }

        protected void gvXeKhach_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvXeKhach.SelectedRow;
            foreach (GridViewRow r in gvXeKhach.Rows)
            {
                r.CssClass = "";
            }
            row.CssClass = "selected-row";

            int index = gvXeKhach.SelectedIndex;
            string maXe = gvXeKhach.DataKeys[index].Values["MaXe"].ToString();
            string bienSoXe = gvXeKhach.DataKeys[index].Values["BienSoXe"].ToString();
            string loaiXe = gvXeKhach.DataKeys[index].Values["LoaiXe"].ToString();
            string soChoNgoi = gvXeKhach.DataKeys[index].Values["SoChoNgoi"].ToString();
            string soTang = gvXeKhach.DataKeys[index].Values["SoTang"].ToString();
            string soDay = gvXeKhach.DataKeys[index].Values["SoDay"].ToString();
            string soGheMoiDay = gvXeKhach.DataKeys[index].Values["SoGheMoiDay"].ToString();

            txtMaXe.Text = maXe;
            txtBienSoXe.Text = bienSoXe;
            txtLoaiXe.Text = loaiXe;
            txtSoChoNgoi.Text = soChoNgoi;
            txtSoTang.Text = soTang;
            txtSoDay.Text = soDay;
            txtSoGheMoiDay.Text = soGheMoiDay;

            btnSave.Visible = true;
            btnDelete.Visible = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }
    }
}
