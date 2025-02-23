using DAL;
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

        // Add XeKhach
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            XeKhach newXe = new XeKhach
            {
               
            };

            bool result = XeKhachBLL.Instance.AddXeKhach(newXe);
            if (result)
            {
                LoadXeKhachData();
                
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
                      
                    };
                    bool result = XeKhachBLL.Instance.EditXeKhach(updatedXe);
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
            txtMaTaiXe.Text = maTaiXe;
            txtMaXe.Text = maXe;
            txtTrangThai.Text = trangThai;


            // Gọi hàm JavaScript để mở popup
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }


        // Clear form fields
      
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name="";
            string email="";

            // Hiển thị thông tin nhập vào (hoặc lưu vào database)
            Response.Write("<script>alert('Tên: " + name + "nEmail: " + email + "');</script>");
        }



        

    }
}
