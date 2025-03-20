using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLChuyenXeVaDatVe.BLL
{
    public class ChiTietHoaDonBLL
    {
        public List<Models.ChiTietHoaDon> GetAllChiTietHoaDon()
        {
            return ChiTietHoaDonDAL.Instance.GetAllChiTietHoaDon();
        }
        public List<Models.ChiTietHoaDon> GetChiTietHoaDonByMaHD(int id)
        {
            List<Models.ChiTietHoaDon> list = new List<Models.ChiTietHoaDon>();
            foreach (Models.ChiTietHoaDon item in ChiTietHoaDonDAL.Instance.GetAllChiTietHoaDon())
            {
                if (item.MaHoaDon == id)
                {
                    list.Add(item);
                }
            }
            return list;
        }

        public bool InsertChiTietHoaDon(Models.ChiTietHoaDon chiTiet)
        {
            return ChiTietHoaDonDAL.Instance.InsertChiTietHoaDon(chiTiet);
        }

        public bool DeleteChiTietHoaDon(int maChiTiet)
        {
            return ChiTietHoaDonDAL.Instance.DeleteChiTietHoaDon(maChiTiet);
        }
    }
}