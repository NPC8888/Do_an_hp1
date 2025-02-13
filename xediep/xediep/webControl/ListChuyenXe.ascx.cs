using BLL;
using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;

namespace xediep.webControl
{
    public partial class ListChuyenXe : System.Web.UI.UserControl
    {
        public List<ChuyenXe> lchuyenxe = new List<ChuyenXe>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListView1.DataSource = lchuyenxe;
                ListView1.DataBind();
            }
        }

        // Lấy bình luận từ chuyến xe có mã MaCX
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<DanhGia> GetDanhGiaByChuyenXe(int maChuyen)
        {
            List<DanhGia> danhGias = DanhGiaBLL.Instance.GetDanhGiaByMaCX(maChuyen); // Lấy từ BLL
            return danhGias;
        }

        protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Write("a");
        }
    }
}
