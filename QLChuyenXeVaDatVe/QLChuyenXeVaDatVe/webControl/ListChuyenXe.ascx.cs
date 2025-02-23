using BLL;
using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Printing;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using xediep.BLL;

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
        public (string DiemDon, string DiemDen) LayDiemDiDiemDenByMaTuyenXe(string id)
        {
            return TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(int.Parse(id));
        }



        // Lấy bình luận từ chuyến xe có mã MaCX



    }
   
    
}
