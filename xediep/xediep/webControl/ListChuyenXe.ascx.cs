using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace xediep.webControl
{
    public partial class ListChuyenXe : System.Web.UI.UserControl
    {
        public List<ChuyenXe> lchuyenxe= new List<ChuyenXe>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListView1.DataSource = lchuyenxe;
                ListView1.DataBind();
            }
        }
    }
}