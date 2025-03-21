using BLL;
using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.Models;
using xediep.webControl;

namespace QLChuyenXeVaDatVe
{
    public partial class QuanLyNguoiDung : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDiemDonTraKhach();
                LoaddlQuyen();
            }


        }
        private void LoadDiemDonTraKhach()
        {

            gvNguoiDung.DataSource = NguoiDungBLL.Instance.GetAll();
            gvNguoiDung.DataBind();
        }
        private void LoaddlQuyen()
        {

            ddlQuyen.Items.Clear();
            ddlQuyen.Items.Add(new ListItem("Khách hàng", "KhachHang"));
            ddlQuyen.Items.Add(new ListItem("Tài xế", "TaiXe"));
            ddlQuyen.Items.Add(new ListItem("Quản trị", "QuanTri"));
            ddlQuyen.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (checkInPut() != "")
            {
                Response.Write("<script>alert('" + checkInPut() + "');</script>");
                return;
            }
            NguoiDung ng = new NguoiDung
            {
                HoTen = txtHoTen.Text,
                TenDangNhap = txtEmail.Text,
                MatKhau = txtMatKhau.Text,
                VaiTro = ddlQuyen.SelectedItem.Value,
                EMai = txtEmail.Text,
                SDT = txtSDT.Text


            };

            bool result = NguoiDungBLL.Instance.InsertNguoiDung(ng);
            if (result)
            {

                Response.Write("<script>alert('Thêm thành công!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Lỗi khi thêm!');</script>");
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvNguoiDung.SelectedRow != null)
                {
                    if (checkInPut() != "")
                    {
                        Response.Write("<script>alert('" + checkInPut() + "');</script>");
                        return;
                    }
                    NguoiDung ng = new NguoiDung
                    {
                        MaNguoiDung = int.Parse(txtMaNguoiDung.Text),
                        HoTen = txtHoTen.Text,
                        TenDangNhap = txtEmail.Text,
                        MatKhau = txtMatKhau.Text,
                        VaiTro = ddlQuyen.SelectedItem.Value,
                        EMai = txtEmail.Text,
                        SDT = txtSDT.Text


                    };

                    bool result = NguoiDungBLL.Instance.UpdateNguoiDung(ng);



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
            catch
            {
                Response.Write("<script>alert('Gmail đã tồn tại!');</script>");
            }
        }
        

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                int maND = int.Parse(txtMaNguoiDung.Text);
                bool result = NguoiDungBLL.Instance.DeleteNguoiDung(maND);
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
            catch
            {
                Response.Write("<script>alert('Có dữ liệu liên quan không thể xóa!');</script>");
            }
        }

        protected void gvNguoiDung_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvNguoiDung.SelectedRow;
            int index = gvNguoiDung.SelectedIndex;
            string MaNguoiDung = gvNguoiDung.DataKeys[index].Values["MaNguoiDung"].ToString();
            txtMaNguoiDung.Text = MaNguoiDung;
            NguoiDung ng = NguoiDungBLL.Instance.GetNguoiDungByMaND(int.Parse(MaNguoiDung));
            txtHoTen.Text = ng.HoTen;
            txtTenDangNhap.Text = ng.TenDangNhap;
            txtMatKhau.Text = ng.MatKhau;
            txtEmail.Text = ng.EMai;
            txtSDT.Text = ng.SDT;
            LoaddlQuyen(); // Load lại danh sách quyền trước

            ddlQuyen.SelectedValue = ng.VaiTro;
            btnAd.Visible = false;
            btnSave.Visible = true;
            btnDelete.Visible = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }

        protected void btnThemMoi_Click(object sender, EventArgs e)
        {
            txtMaNguoiDung.Text = "";
            LoaddlQuyen(); // Load lại danh sách quyền trước
            ddlQuyen.SelectedIndex = 0;
            txtHoTen.Text = "";
            txtTenDangNhap.Text = "";
            txtMatKhau.Text = "";
            txtEmail.Text = "";
            txtSDT.Text = "";
            btnAd.Visible = true;
            btnSave.Visible = false;
            btnDelete.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "showPopup", "showPopup();", true);
        }

        protected void btnTimKiem(object sender, EventArgs e)
        {
            List<NguoiDung> l = new List<NguoiDung>();
            l = NguoiDungBLL.Instance.GetAll();
            l = l.Where(x => BoLoc.TimKiem(x, txtTim.Text)).ToList();

            gvNguoiDung.DataSource = l;
            gvNguoiDung.DataBind();
            if (txtTim.Text.Length==0)
            {
                LoadDiemDonTraKhach();
            }
        }
        private string checkInPut()
        {
            string error = "";
            if (string.IsNullOrEmpty(txtHoTen.Text))
            {
                error += "Họ tên không được để trống! <br/>";

            }
            if (string.IsNullOrEmpty(txtMatKhau.Text))
            {
                error += "Mật khẩu không được để trống! <br/>";
            }
            if (string.IsNullOrEmpty(txtEmail.Text))
            {
                error += "Email không được để trống! <br/>";
            }
            if (string.IsNullOrEmpty(txtSDT.Text))
            {
                error += "Số điện thoại không được để trống! <br/>";
            }
            return error;
        }
    }
}