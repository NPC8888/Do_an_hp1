using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using xediep.BLL;
using xediep.Models;
using xediep.webControl;

namespace QLChuyenXeVaDatVe
{
    public partial class TListChuyenXe : System.Web.UI.Page
    {
        public List<ChuyenXe> lcx = new List<ChuyenXe>();
        protected void Page_Load(object sender, EventArgs e)
        {
           
                if (Session["listCX"] != null)
                {
                    lcx = (List<ChuyenXe>)Session["listCX"];
                }
            lcx= lcx.OrderByDescending(cx => cx.TrangThai == "DangChay").ToList();//cx có trang thái DangChay lên đầu

        }
        protected void ThongKe(object sender, EventArgs e)
        {
            if (txtE.Text == null || txtE.Text.Length == 0 || txtS.Text == null || txtS.Text.Length == 0)
            {
                Response.Write("<script>alert('Vui lòng điền đầy đủ ngày bắt đầu ngày kết thúc!');</script>");
                return;
            }
            lcx.Clear();
            foreach (var cx in ChuyenXeBLL.Instance.GetALLChuyenXeByMaTaiXe(int.Parse(Session["Role"].ToString())))
            {
                
                DateTime startDate, endDate;
                if (DateTime.TryParse(txtS.Text, out startDate) && DateTime.TryParse(txtE.Text, out endDate))
                {
                    endDate = endDate.Date.AddHours(23).AddMinutes(59).AddSeconds(59);
                    if (cx.TgKhoiHanh >= startDate && cx.TgKhoiHanh <= endDate)
                    {
                        lcx.Add(cx);
                    }
                }
            }
            Session["listCX"] = lcx;
        }
        protected void slectSapXep(object sender, EventArgs e)
        {
            // Lấy danh sách từ Session trước khi sắp xếp
           

            List<ChuyenXe> l = new List<ChuyenXe>(lcx); 
            int count = 0;
            foreach (ListItem item in cblFilters.Items)
            {
                
                if (item.Selected) // Kiểm tra nếu checkbox được chọn
                {
                    string sortType = item.Value; // Lấy giá trị của checkbox
                    switch (sortType)
                    {
                        case "DC": 
                            l = l.Where(x => x.TrangThai=="DaChay").ToList();count++;
                            break;
                        case "CC": 
                            l = l.Where(x => x.TrangThai=="ChuaChay").ToList();count++;
                            break;
                    }
                }
                if (count == 0)
                {   
                    l = ChuyenXeBLL.Instance.GetALLChuyenXeByMaTaiXe(int.Parse(Session["Role"].ToString()));
                    
                }
            }

            // Cập nhật danh sách hiển thị
            lcx = l;
            Session["listCX"] = l;

            
        }

    }
}