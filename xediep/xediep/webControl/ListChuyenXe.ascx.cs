using BLL;
using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Web;
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
      
    }
}
