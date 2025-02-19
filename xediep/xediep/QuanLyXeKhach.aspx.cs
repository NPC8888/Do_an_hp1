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
            if (!IsPostBack)
            {
                LoadXeKhachData();
            }
        }

        // Load XeKhach data into GridView
        private void LoadXeKhachData()
        {
            List<XeKhach> xeKhachList = XeKhachBLL.Instance.GetAllXeKhach();
            gvXeKhach.DataSource = xeKhachList;
            gvXeKhach.DataBind();
        }

        // Add XeKhach
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            XeKhach newXe = new XeKhach
            {
                BienSoXe = txtBienSoXe.Text,
                LoaiXe = txtLoaiXe.Text,
                SoChoNgoi = int.Parse(txtSoChoNgoi.Text)
            };

            bool result = XeKhachBLL.Instance.AddXeKhach(newXe);
            if (result)
            {
                LoadXeKhachData();
                ClearForm();
                Response.Write("<script>alert('Thêm xe thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi thêm xe!');</script>");
            }
        }

        // Edit XeKhach
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (gvXeKhach.SelectedRow != null) // Kiểm tra xem có dòng nào được chọn không
            {
                int maXe;

                // Giải mã HTML & kiểm tra giá trị có thể chuyển đổi sang số không
                if (int.TryParse(HttpUtility.HtmlDecode(gvXeKhach.SelectedRow.Cells[0].Text), out maXe))
                   
                {
                    XeKhach updatedXe = new XeKhach
                    {
                        MaXe = maXe,
                        BienSoXe = txtBienSoXe.Text.Trim(),
                        LoaiXe = txtLoaiXe.Text.Trim(),
                        SoChoNgoi = int.Parse(txtSoChoNgoi.Text)
                    };
                    bool result = XeKhachBLL.Instance.EditXeKhach(updatedXe);
                    if (result)
                    {
                        LoadXeKhachData();
                        ClearForm();
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
                    
                }
                
            }
            else
            {
                Response.Write("kh");
            }
           


           
        }

        // Delete XeKhach
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int maXe = int.Parse(gvXeKhach.SelectedRow.Cells[0].Text);
            bool result = XeKhachBLL.Instance.RemoveXeKhach(maXe);
            if (result)
            {
                LoadXeKhachData();
                ClearForm();
                Response.Write("<script>alert('Xóa xe thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi xóa xe!');</script>");
            }
        }

        // Handle selecting an item from GridView (to edit)
        protected void gvXeKhach_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvXeKhach.SelectedRow;
            txtBienSoXe.Text = row.Cells[1].Text;
            txtLoaiXe.Text = row.Cells[2].Text;
            txtSoChoNgoi.Text = row.Cells[3].Text;
        }

        // Clear form fields
        private void ClearForm()
        {
            txtBienSoXe.Text = "";
            txtLoaiXe.Text = "";
            txtSoChoNgoi.Text = "";
        }
    }
}
