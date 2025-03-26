using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.Models;
using xediep.webControl;

namespace xediep
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected List<ChuyenXe> lChuyenXe = new List<ChuyenXe>();
        protected string diemdi;
        protected string diemden;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["DateSh"] == null)
                {
                
                    Session["DateSh"] = DateTime.Now.ToString("yyyy-MM-dd");

                }
                loadchuyenxe();
            }
            else
            {
                // Lấy lại dữ liệu từ Session nếu có
                if (Session["lChuyenXe"] != null)
                {
                    lChuyenXe = (List<ChuyenXe>)Session["lChuyenXe"];
                }
            }
        }

        void loadchuyenxe()
        {
             diemdi = Request.QueryString["diemdi"];
             diemden = Request.QueryString["diemDen"];

            if (Session["DateSh"] != null)
            {
                string date = Session["DateSh"].ToString();
                int matuyen = TuyenXeBLL.Instance.GetMaTuyenXeByDiemDiDiemDen(diemdi, diemden);
                
                lChuyenXe = ChuyenXeBLL.Instance.GetALLChuyenXeByTuyenXeAndDate(matuyen, date);

                // Lưu vào Session để dùng lại sau PostBack
                Session["lChuyenXe"] = lChuyenXe;

                ListChuyenXe.lchuyenxe = lChuyenXe;
                ListChuyenXe.DataBind();
            }
          
        }

        protected void slectSapXep(object sender, EventArgs e)
        {
            // Lấy danh sách từ Session trước khi sắp xếp
            if (Session["lChuyenXe"] != null)
            {
                lChuyenXe = (List<ChuyenXe>)Session["lChuyenXe"];
            }

            List<ChuyenXe> l = new List<ChuyenXe>(lChuyenXe); // Sao chép danh sách gốc

            foreach (ListItem item in cblFilters.Items)
            {
                if (item.Selected) // Kiểm tra nếu checkbox được chọn
                {
                    string sortType = item.Value; // Lấy giá trị của checkbox
                    switch (sortType)
                    {
                        case "giuongnam": // Giá từ cao đến thấp
                            l = l.OrderByDescending(x => x.Price).ToList();
                            break;
                        case "ghengo": // Giá từ thấp đến cao
                            l = l.OrderBy(x => x.Price).ToList();
                            break;
                        case "100": // Thời gian từ sớm đến muộn
                            l = l.OrderBy(x => x.TgKhoiHanh).ToList();
                            break;
                        case "300": // Thời gian từ muộn đến sớm
                            l = l.OrderByDescending(x => x.TgKhoiHanh).ToList();
                            break;
                    }
                }
            }

            // Cập nhật danh sách hiển thị
            ListChuyenXe.lchuyenxe = l;
            ListChuyenXe.DataBind();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (Session["lChuyenXe"] != null)
            {
                lChuyenXe = (List<ChuyenXe>)Session["lChuyenXe"];
            }
           
            List<ChuyenXe> l = new List<ChuyenXe>(lChuyenXe);
            l = lChuyenXe.Where(x => BoLoc.TimKiem(x, txtSearch.Text)).ToList();
            lChuyenXe = l;
            ListChuyenXe.lchuyenxe = l;
            ListChuyenXe.DataBind();
          if(txtSearch.Text == "")
            {
                loadchuyenxe();
            }
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