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

namespace QLChuyenXeVaDatVe
{
    public partial class ChiTietChuyenXe : System.Web.UI.Page
    {
        private string idChuyenXe; // ID chuyến xe từ query string
        private string idtuyenXe; // ID tuyến xe từ chyuyenxe
        public string[] trangThaiGhe; // Mảng trạng thái ghế
        public ChuyenXe cx = new ChuyenXe();
        public XeKhach xe = new XeKhach();
        public int tang;
        public int day;
        public int ghe;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                idChuyenXe = Request.QueryString["id"];
                cx = ChuyenXeBLL.Instance.GetChuyenXeByMaCX(int.Parse(idChuyenXe));
                xe = XeKhachDAL.Instance.XeKhachByMaXe(cx.MaXe);
                tang = xe.SoTang;
                day = xe.SoDay;
                ghe = xe.SoGheMoiDay;
                trangThaiGhe = new string[150];
                for (int i = 0; i < 150; i++)
                {
                    trangThaiGhe[i] = "0";
                }

                // Lấy trạng thái ghế từ cơ sở dữ liệu
                var danhSachGhe = GheNgoiDAL.Instance.GetListGheNgoibyId(idChuyenXe);
                CapNhatTrangThaiGhe(danhSachGhe, trangThaiGhe);
                LoadVeXe();

            }
        }

        private void CapNhatTrangThaiGhe(List<GheNgoi> danhSachGhe, string[] trangThaiGhe)
        {
            tang = xe.SoTang;
            day = xe.SoDay;
            ghe = xe.SoGheMoiDay;
            foreach (var ghe in danhSachGhe)
            {
                if (ghe.DaDat == 1 && ghe.SoGhe >= 1)
                {
                    trangThaiGhe[ghe.SoGhe] = "1";
                }
            }
        }

        private void LoadVeXe()
        {
            List<VeXe> vx=new List<VeXe>();
             foreach(var ve in VeXeBLL.Instance.GetALL())
                {
                if (ve.MaChuyenXe == int.Parse(idChuyenXe))
                    {
                        vx.Add(ve);
                    }
                } 
            gvVeXe.DataSource = vx;
            gvVeXe.DataBind();
        }
    }
}
