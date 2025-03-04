using System;
using System.Collections.Generic;
using xediep.Models;
using DAL;
using QLChuyenXeVaDatVe.DAL;
using QLChuyenXeVaDatVe.Models;

public class HoaDonBLL
{
    public List<HoaDon> GetAllHoaDon()
    {
        return HoaDonDAL.Instance.GetAllHoaDon();
    }

    public bool UpdateTrangThaiHoaDon(int maHoaDon, string trangThai)
    {
        return HoaDonDAL.Instance.UpdateTrangThaiHoaDon(maHoaDon, trangThai);
    }

    public bool InsertHoaDon(HoaDon hoaDon)
    {
        return HoaDonDAL.Instance.InsertHoaDon(hoaDon);
    }
    public int InsertHoaDonCallbackmahoadon(HoaDon hoaDon)
    {
        return HoaDonDAL.Instance.InsertHoaDonback(hoaDon);
    }
}




