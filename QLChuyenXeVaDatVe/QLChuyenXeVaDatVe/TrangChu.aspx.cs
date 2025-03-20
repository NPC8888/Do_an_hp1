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
                foreach (var item in ChuyenXeBLL.Instance.GetALLChuyenXe())
                {
                    ListChuyenXe.lchuyenxe.Add(new ChuyenXe(item));
                }

            }

        }
        //private List<ChuyenXe> LoadlChuyenXePhoBien()
        //{
            
        //}

        
    }

}
