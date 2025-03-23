using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;

namespace QLChuyenXeVaDatVe
{
    public partial class TListChuyenXe : System.Web.UI.Page
    {
        public List<ChuyenXe> lcx = new List<ChuyenXe>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["listCX"] != null)
                {
                    lcx = (List<ChuyenXe>)Session["listCX"];
                }
            }
        }


    }
}