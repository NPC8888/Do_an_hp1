using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using xediep.BLL;

namespace xediep
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          if (!IsPostBack)
            {
                ListChuyenXe.lchuyenxe = ChuyenXeBLL.Instance.GetALLChuyenXe();



            }

        }

        
    }

}
