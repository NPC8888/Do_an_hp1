using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLChuyenXeVaDatVe
{
    public partial class TraCuu : System.Web.UI.Page
    { HoaDonBLL hd = new HoaDonBLL();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnTraCuu_Click(object sender, EventArgs e)
        {
            string keyword = txtTraCuu.Text.Trim();
            if (!string.IsNullOrEmpty(keyword))
            {
                var hds = hd.GetHoaDonByMaHD(int.Parse(keyword));
                if (hds != null)
                {
                    Response.Redirect($"TrangChiTietHoaDon.aspx?id={keyword}");
                }
                else
                {
                    Response.Write("<script>alert('Hóa đơn không tồn tại!');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Vui lòng nhập từ khóa tra cứu!');</script>");
            }
        }


    }
}


