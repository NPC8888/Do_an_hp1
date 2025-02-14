﻿using BLL;
using DAL;
using Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices.Internal;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace xediep
{
    public partial class DatVe : Page
    {
        private const int TotalSeats = 36; // Tổng số ghế

        private string idChuyenXe; // ID chuyến xe từ query string
        private string[] trangThaiGhe; // Mảng trạng thái ghế
        private NguoiDung NguoiDungnow;
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["DiemTra"] = "1";
                idChuyenXe = Request.QueryString["id"];
                lblmaxe.Text = idChuyenXe.Trim();
                ChuyenXe cx = ChuyenXeDAL.Instance.getGiaXeByMaXe(idChuyenXe);
                lblDepartureTime.Text = cx.TgKhoiHanh.ToString();
                lblTotalPrice.Text = cx.Price.ToString();
                lblTotalPrice.Text += ":VND";
                lblTripName.Text = cx.DDi + "-" + cx.DDen;
                if (string.IsNullOrEmpty(idChuyenXe))
                {
                    Response.Write("ID chuyến xe không hợp lệ.");
                    Response.End();
                }

                LvDanhGia.DataSource = DanhGiaBLL.Instance.GetDanhGiaByMaCX(int.Parse(idChuyenXe));
                LvDanhGia.DataBind();
                trangThaiGhe = new string[TotalSeats];
                for (int i = 0; i < TotalSeats; i++)
                {
                    trangThaiGhe[i] = "0";
                }

                // Lấy trạng thái ghế từ cơ sở dữ liệu
                var danhSachGhe = GheNgoiDAL.Instance.GetListGheNgoibyId(idChuyenXe);
                CapNhatTrangThaiGhe(danhSachGhe, trangThaiGhe);

                // Lưu vào ViewState để hiển thị
                ViewState["SeatStatus"] = trangThaiGhe;
                loaddlDiemDiDiemDon();
                Checkcoki();



            }



        }

        
        private void CapNhatTrangThaiGhe(List<GheNgoi> danhSachGhe, string[] trangThaiGhe)
        {
            foreach (var ghe in danhSachGhe)
            {
                if (ghe.DaDat == 1 && ghe.SoGhe >= 1 && ghe.SoGhe <= TotalSeats)
                {
                    trangThaiGhe[ghe.SoGhe - 1] = "1";
                }
            }
        }
        void loaddlDiemDiDiemDon()
        {
            foreach (DiemDonTraKhach diem in DiemDonTraKhachBLL.Instance.GetListDiemDonByIDChuyenXe(int.Parse(idChuyenXe)))
            {
                ddlDiemDon.Items.Add(new ListItem(diem.TenDiem + "(" + diem.DiaChi + ")", diem.MaDiem.ToString()));


            }
            foreach (DiemDonTraKhach diem in DiemDonTraKhachBLL.Instance.GetListDiemTraByIDChuyenXe(int.Parse(idChuyenXe)))
            {

                ddlDiemTra.Items.Add(new ListItem(diem.TenDiem + "(" + diem.DiaChi + ")", diem.MaDiem.ToString()));

            }
        }

       


        void Checkcoki()
        {

            HttpCookie authCookie = Request.Cookies["AuthToken"];
            if (authCookie != null)
            {
                string token = authCookie.Value;
                NguoiDungBLL userBLL = new NguoiDungBLL();
                DataRow user = userBLL.AuthenticateByToken(token);

                if (user != null) // Token hợp lệ
                {
                    NguoiDungnow = new NguoiDung(user);
                    txtHoTen.Text = NguoiDungnow.HoTen;
                    txtSoDienThoai.Text = NguoiDungnow.SDT;
                    Response.Write(NguoiDungnow.MaNguoiDung);
                    lbID.Text = NguoiDungnow.MaNguoiDung.ToString();
                }
                else
                {
                    // Token không hợp lệ, chuyển về trang đăng nhập
                    Response.Redirect("Login.aspx");
                }
            }
            else
            {
                // Không có token, chuyển về trang đăng nhập
                Response.Redirect("Login.aspx");
            }

        }
        public static List<int> TachChuoiThanhList(string input)
        {
            return input.Split(',')
                        .Select(int.Parse)  // Chuyển đổi từng phần tử thành số nguyên
                        .ToList();          // Chuyển thành danh sách
        }
        protected void datve(object sender, EventArgs e)
        {
            Console.Write(SoGheDaChon.Text);
            List<int> list = TachChuoiThanhList(SoGheDaChon.Text);
            foreach (int item in list)
            {
                DatVeBLL.Instance.InsertDatVe(0, int.Parse(lblmaxe.Text), int.Parse(lbID.Text), "DD", DateTime.Now, txtHoTen.Text, txtSoDienThoai.Text, item, int.Parse(ddlDiemDon.SelectedValue), int.Parse(ddlDiemTra.SelectedValue));
            }
           
           
        }






            [WebMethod]
            public static string SaveBooking(string MaChuyenXe, string Hoten, string SoDT, string soghe, string MaDiemDon, string MaDiemTra)
            {
                HttpCookie authCookie = HttpContext.Current.Request.Cookies["AuthToken"];
                if (authCookie != null)
                {
                    string token = authCookie.Value;
                    NguoiDungBLL userBLL = new NguoiDungBLL();
                    DataRow user = userBLL.AuthenticateByToken(token);
                    NguoiDung nguoi = new NguoiDung(user);
                    foreach (int soGhe in TachChuoiThanhList(soghe))
                    {
                        if (DatVeBLL.Instance.InsertDatVe(0, int.Parse(MaChuyenXe), nguoi.MaNguoiDung, "DD", DateTime.Now, Hoten, SoDT, soGhe, int.Parse(MaDiemDon), int.Parse(MaDiemTra)))
                        {

                        }
                        else
                        {
                            return "loi them ve";

                        }
                       
                    }
                return "Đã đặt vé thành công số ghê:"+soghe;
            }
                return "khong co nguoi dung";

                // Response.Redirect("TrangChu.aspx");



            }
            }
}
    
