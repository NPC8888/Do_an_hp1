using BLL;
using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLChuyenXeVaDatVe
{
	public partial class LichSuDatVe : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            LoadTicketHistory();
        }
        private void LoadTicketHistory()
        {
            HoaDonBLL hd = new HoaDonBLL();
            // Dữ liệu giả lập - thay bằng database
            List<HoaDon> lHD = new List<HoaDon>();
            foreach (var item in hd.GetAllHoaDon())
            {
                if (item.MaKhachHang == NguoiDungBLL.Instance.GetNguoiDungByMaND(int.Parse(Session["Role"].ToString())).MaNguoiDung)
                {
                    lHD.Add(item);
                }
            }



            rptTickets.DataSource = lHD;
            rptTickets.DataBind();
        }

    }
}