using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using DAL;
using Models;
namespace xediep.webControl
{
    public partial class ThanhTimKiem : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            LoadListDiaDiem();
           

        }

        void LoadListDiaDiem()
        {
            if (!IsPostBack)
            {
                txtDateTime.Text = DateTime.Now.ToString("yyyy-MM-dd");//dat ngay la hom nay
                // Danh sách các tỉnh thành Việt Nam
                List<string> tinhThanh = new List<string>
        {
            "An Giang", "Bà Rịa - Vũng Tàu", "Bạc Liêu", "Bắc Kạn", "Bắc Giang",
            "Bắc Ninh", "Bến Tre", "Bình Dương", "Bình Định", "Bình Phước",
            "Bình Thuận", "Cà Mau", "Cao Bằng", "Cần Thơ", "Đà Nẵng",
            "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp",
            "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", "Hà Tĩnh",
            "Hải Dương", "Hải Phòng", "Hậu Giang", "Hòa Bình", "Hưng Yên",
            "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lạng Sơn",
            "Lào Cai", "Lâm Đồng", "Long An", "Nam Định", "Nghệ An",
            "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Phú Yên", "Quảng Bình",
            "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng",
            "Sơn La", "Tây Ninh", "Thái Bình", "Thái Nguyên", "Thanh Hóa",
            "Thừa Thiên Huế", "Tiền Giang", "TP. Hồ Chí Minh", "Trà Vinh", "Tuyên Quang",
            "Vĩnh Long", "Vĩnh Phúc", "Yên Bái"
        };

                // Thêm các tỉnh thành vào DropDownList
                foreach (string tinh in tinhThanh)
                {
                    ddlDiemDI.Items.Add(new ListItem(tinh, tinh));
                    ddlDiemDen.Items.Add(new ListItem(tinh, tinh));

                }
                ddlDiemDI.SelectedIndex = ChuyenXeDAL.diemdi;
                ddlDiemDen.SelectedIndex = ChuyenXeDAL.diemden;
            }
           
        }
        protected void TKChuyenXe(object sender, EventArgs e)
        {
            string diemDi=ddlDiemDI.Text;
            string diemDen=ddlDiemDen.Text;
            ChuyenXeDAL.diemdi = ddlDiemDI.SelectedIndex;
            ChuyenXeDAL.diemden = ddlDiemDen.SelectedIndex;
            Session["DateSh"] = txtDateTime.Text;
            Response.Redirect($"ListChuyenXe.aspx?diemdi={diemDi}&diemDen={diemDen}");
            


        }
       

    }
}