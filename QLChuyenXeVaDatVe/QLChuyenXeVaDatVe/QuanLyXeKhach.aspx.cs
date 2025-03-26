using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL.BLL;
using xediep.Models;
using xediep.webControl;

namespace xediep
{
    public partial class QuanLyXeKhach : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadXeKhach();
            }
            
        }

        private void LoadXeKhach()
        {
            gvXeKhach.DataSource = XeKhachBLL.Instance.GetAllXeKhach();
            gvXeKhach.DataBind();
        }
            protected void btnTim_Click(object sender, EventArgs e)
            {
                string key = txtTim.Text;
                if (key != null&&key!="")
                {
                    var xes = XeKhachBLL.Instance.GetAllXeKhach();
                    var list = xes.Where(x => BoLoc.TimKiem(x, txtTim.Text)).ToList();
                    gvXeKhach.DataSource = list;
                    gvXeKhach.DataBind();
                      
                }
                else
                {
                LoadXeKhach();
                }
        
        
            }
        protected void btnAdd_Click(object sender, EventArgs e)
        { if (checkInput() == false) return;
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
            if (checkInput() == false) return;
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
            try { 
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
            catch
            {
                Response.Write("<script>alert('Có liên kết nhiều dữ liệu không thể xóa!');</script>");
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
        bool checkInput()
        {
            // Kiểm tra không để trống
            if (string.IsNullOrWhiteSpace(txtBienSoXe.Text) ||
                string.IsNullOrWhiteSpace(txtLoaiXe.Text) ||
                string.IsNullOrWhiteSpace(txtSoChoNgoi.Text) ||
                string.IsNullOrWhiteSpace(txtSoTang.Text) ||
                string.IsNullOrWhiteSpace(txtSoDay.Text) ||
                string.IsNullOrWhiteSpace(txtSoGheMoiDay.Text))
            {
                Response.Write("<script>alert('Vui lòng nhập đầy đủ thông tin!');</script>");
                return false;
            }


            // Kiểm tra số nguyên dương hợp lệ
            if (!int.TryParse(txtSoChoNgoi.Text, out int soChoNgoi) || soChoNgoi <= 0 || soChoNgoi > 48)
            {
                Response.Write("<script>alert('Số chỗ ngồi phải từ 1 đến 48!');</script>");
                return false;
            }

            if (!int.TryParse(txtSoTang.Text, out int soTang) || soTang <= 0 || soTang > 2)
            {
                Response.Write("<script>alert('Số tầng chỉ được từ 1 đến 2!');</script>");
                return false;
            }

            if (!int.TryParse(txtSoDay.Text, out int soDay) || soDay <= 1 || soDay > 10)
            {
                Response.Write("<script>alert('Số dãy phải từ 2 đến 10!');</script>");
                return false;
            }

            if (!int.TryParse(txtSoGheMoiDay.Text, out int soGheMoiDay) || soGheMoiDay <= 1|| soGheMoiDay > 5)
            {
                Response.Write("<script>alert('Số ghế mỗi dãy phải từ 2 đến 5!');</script>");
                return false;
            }

            // Nếu tất cả hợp lệ
            return true;
        }

    }
}
