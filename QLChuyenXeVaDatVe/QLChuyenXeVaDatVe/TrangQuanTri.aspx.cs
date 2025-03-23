using BLL;
using Models;
using Newtonsoft.Json;
using QLChuyenXeVaDatVe.BLL;
using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace QLChuyenXeVaDatVe
{
    public partial class TrangQuanTri : System.Web.UI.Page
    {
        protected string doanhThu24h;
        protected decimal[] doanhthutheoloai;
        
        HoaDonBLL donBLL = new HoaDonBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Thời điểm bắt đầu của ngày hiện tại (00:00:00)
            DateTime ngayBatDau = DateTime.Today; // = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 0, 0, 0);

            // Thời điểm cuối cùng của ngày hiện tại (23:59:59)
            DateTime ngayKetThuc = DateTime.Today.AddHours(23).AddMinutes(59).AddSeconds(59);
            

            decimal[] doanhThu = donBLL.TinhDoanhThuTheo24h(ngayBatDau, ngayKetThuc);

            decimal[] dh = donBLL.TinhDoanhThuTTuyenandTTiep(ngayBatDau, ngayKetThuc);

            doanhThu24h = JsonConvert.SerializeObject(doanhThu);
            doanhthutheoloai = dh;
            phanquyen();
        }
        private void phanquyen() {
            HttpCookie authCookie = Request.Cookies["AuthToken"];
            if (authCookie != null)
            {
                DataRow dr = NguoiDungBLL.Instance.AuthenticateByToken(authCookie.Value);

                NguoiDung ng = new NguoiDung(dr);
                Session["Role"] = ng.MaNguoiDung;
            }
        }
    }
}