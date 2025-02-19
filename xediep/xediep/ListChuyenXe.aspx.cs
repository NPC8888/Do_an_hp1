using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;

namespace xediep
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected List<ChuyenXe> lChuyenXe = new List<ChuyenXe>();

        protected void Page_Load(object sender, EventArgs e)
        {
            string diemdi = Request.QueryString["diemdi"];
            string diemden = Request.QueryString["diemDen"];
            if (Session["DateSh"] != null) {
                string date = Session["DateSh"].ToString();

                int matuyen = TuyenXeBLL.Instance.GetMaTuyenXeByDiemDiDiemDen(diemdi, diemden);

                lChuyenXe = ChuyenXeDAL.Instance.SearchChuyenXeByMaTuyenXe(matuyen, date);
                ListChuyenXe.lchuyenxe = lChuyenXe;
                ListChuyenXe.DataBind();
            }


            // Hiển thị kết quả

        }

        protected void btnDatVe_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string id = btn.CommandArgument;  // Lấy id của chuyến xe từ CommandArgument
            DatVe(id);  // Gọi phương thức xử lý đặt vé
        }
        
        public void DatVe(string id)
        {
            // Xử lý đặt vé với id của chuyến xe
            Response.Redirect($"DatVe.aspx?id={id}");

        }


    }
}