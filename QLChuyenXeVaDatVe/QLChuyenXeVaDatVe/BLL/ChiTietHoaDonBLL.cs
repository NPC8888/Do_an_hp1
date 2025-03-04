using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLChuyenXeVaDatVe.BLL
{
    public class ChiTietHoaDonBLL
    {
        public List<ChiTietHoaDon> GetAllChiTietHoaDon()
        {
            return ChiTietHoaDonDAL.Instance.GetAllChiTietHoaDon();
        }

        public bool InsertChiTietHoaDon(ChiTietHoaDon chiTiet)
        {
            return ChiTietHoaDonDAL.Instance.InsertChiTietHoaDon(chiTiet);
        }

        public bool DeleteChiTietHoaDon(int maChiTiet)
        {
            return ChiTietHoaDonDAL.Instance.DeleteChiTietHoaDon(maChiTiet);
        }
    }
}