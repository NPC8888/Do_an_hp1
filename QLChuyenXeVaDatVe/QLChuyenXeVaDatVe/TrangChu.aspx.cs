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
using BLL;
using System.Data;
using System.Xml.Linq;

namespace xediep
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                foreach (var item in ChuyenXeBLL.Instance.GetALLChuyenXeToDay())
                {
                    ListChuyenXe.lchuyenxe.Add(new ChuyenXe(item));
                }
                HttpCookie authCookie = Request.Cookies["AuthToken"];
                if (authCookie != null)
                {
                    DataRow dr = NguoiDungBLL.Instance.AuthenticateByToken(authCookie.Value);
                    NguoiDung ng = new NguoiDung(dr);
                    Session["Role"] = ng.MaNguoiDung;
                    if (ng.VaiTro == "TaiXe")
                    {
                        Response.Redirect("TTrangChu.aspx");
                    }
                    else if(ng.VaiTro=="QuanTri")
                    {
                        Response.Redirect("TrangQuanTri.aspx");
                    }
                 
                }
            }
         


        }
        //private List<ChuyenXe> LoadlChuyenXePhoBien()
        //{

        //}


    }

}
