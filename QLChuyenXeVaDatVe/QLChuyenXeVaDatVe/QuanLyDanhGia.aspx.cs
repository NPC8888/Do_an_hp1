﻿using BLL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL.BLL;

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
        protected void btnAdd_Click(object sender, EventArgs e)
        {

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
            txtBinhLuan.Text = danhgia.BinhLuan;
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
    }
}

