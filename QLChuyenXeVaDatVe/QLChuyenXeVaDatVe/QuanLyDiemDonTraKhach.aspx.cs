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
    public partial class QuanLyDiemDonTraKhach : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDiemDonTraKhach();
                LoadddlTuyenXe();
            }
        }

        private void LoadDiemDonTraKhach()
        {

            gvDiemDonTraKhach.DataSource = DiemDonTraKhachBLL.Instance.GetALL();
            gvDiemDonTraKhach.DataBind();
        }
        private void LoadddlTuyenXe()
        {
            List<TuyenXe> list = TuyenXeBLL.Instance.GetALLTuyenXe();
            foreach (TuyenXe item in list)
            {
                ddlTuyenXe.Items.Add(new ListItem(item.DiemDi + " - " + item.DiemDen, item.MaTuyenXe.ToString()));
            }
            ddlLoaiDiem.Items.Add(new ListItem("Điểm đón", "DD"));
            ddlLoaiDiem.Items.Add(new ListItem("Điểm trả", "DT"));
            ddlTuyenXe.DataBind();
        }
        protected void btnTim_Click(object sender, EventArgs e)
        {
            string key = txtTim.Text;
            if (key != null && key != "")
            {
                var xes = DiemDonTraKhachBLL.Instance.GetALL();
                var list = xes.Where(x => BoLoc.TimKiem(x, txtTim.Text)).ToList();
                gvDiemDonTraKhach.DataSource = list;
                gvDiemDonTraKhach.DataBind();

            }
            else
            {
                LoadDiemDonTraKhach();
            }


        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (checkInPut()==false)
            {
                Response.Write("<script>alert('Không được để trống thông tin!');</script>"); return;
            }
            
            DiemDonTraKhach newDiem = new DiemDonTraKhach
            {
                MaTuyenXe = int.Parse(ddlTuyenXe.SelectedValue),
                TenDiem = txtTenDiem.Text,
                DiaChi = txtDiaChi.Text,
                LoaiDiem = ddlLoaiDiem.SelectedValue,


            };

            bool result = DiemDonTraKhachBLL.Instance.InsertDiemDonTraKhach(newDiem);
            if (result)
            {
                LoadDiemDonTraKhach();
                Response.Write("<script>alert('Thêm thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi thêm!');</script>");
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (checkInPut() == false)
            {
                Response.Write("<script>alert('Không được để trống thông tin!');</script>"); return;
            }
            if (gvDiemDonTraKhach.SelectedRow != null)
            {
                DiemDonTraKhach updatedDiem = new DiemDonTraKhach
                {
                    MaDiem = int.Parse(txtMaDiem.Text),
                    MaTuyenXe = int.Parse(ddlTuyenXe.SelectedValue),
                    TenDiem = txtTenDiem.Text,
                    DiaChi = txtDiaChi.Text,
                    LoaiDiem = ddlLoaiDiem.SelectedValue
                };
                bool result = DiemDonTraKhachBLL.Instance.UpdateDiemDonTraKhach(updatedDiem);
                if (result)
                {
                    LoadDiemDonTraKhach();
                    Response.Write("<script>alert('Cập nhật thành công!');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Lỗi khi cập nhật!');</script>");
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int maDiem = int.Parse(txtMaDiem.Text);
            bool result = DiemDonTraKhachBLL.Instance.DeleteDiemDonTraKhach(maDiem);
            if (result)
            {
                LoadDiemDonTraKhach();
                Response.Write("<script>alert('Xóa thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi xóa!');</script>");
            }
        }

        protected void gvDiemDon_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvDiemDonTraKhach.SelectedRow;
            int index = gvDiemDonTraKhach.SelectedIndex;
            txtMaDiem.Text = gvDiemDonTraKhach.DataKeys[index].Values["MaDiem"].ToString();
            txtTenDiem.Text = gvDiemDonTraKhach.DataKeys[index].Values["TenDiem"].ToString();
            txtDiaChi.Text = gvDiemDonTraKhach.DataKeys[index].Values["DiaChi"].ToString();
            string TuyenXe = gvDiemDonTraKhach.DataKeys[index].Values["MaTuyenXe"].ToString();
            ddlTuyenXe.SelectedValue = TuyenXe;


            btnFix.Visible = true;
            btnDelete.Visible = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }

        protected void btnThemMoi_Click(object sender, EventArgs e)
        {
            txtMaDiem.Text = "";
            ddlTuyenXe.SelectedValue = null;
            txtTenDiem.Text = "";
            txtDiaChi.Text = "";
            ddlLoaiDiem.SelectedIndex = 0;
            btnFix.Visible = false;
            btnDelete.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }
        bool checkInPut()
        {
            if (string.IsNullOrWhiteSpace(txtDiaChi.Text) || string.IsNullOrWhiteSpace(txtTenDiem.Text))
            {
                return false;
            }
            return true;
        }
    }
}
