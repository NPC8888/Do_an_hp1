using System;
using System.Collections.Generic;
using xediep.Models;
using DAL;
using QLChuyenXeVaDatVe.DAL;
using QLChuyenXeVaDatVe.Models;
using QLChuyenXeVaDatVe.BLL;


public class HoaDonBLL
{
    ChiTietHoaDonBLL chi = new ChiTietHoaDonBLL();
    public List<HoaDon> GetAllHoaDon()
    {
        return HoaDonDAL.Instance.GetAllHoaDon();
    }
    public List<HoaDon> GetAllHoaDonByDate(DateTime s, DateTime e)
    {
        List<HoaDon> hoaDons = new List<HoaDon>();
        List<HoaDon> hd = HoaDonDAL.Instance.GetAllHoaDon();
        foreach (var item in hd)
        {
            if (item.ThoiGianThanhToan >= s && item.ThoiGianThanhToan <= e)
            {
                hoaDons.Add(item);
            }
        }
        return hoaDons;
    }
    public HoaDon GetHoaDonByMaHD(int mahd)
    {
        foreach (var hd in HoaDonDAL.Instance.GetAllHoaDon())
        {
            if (hd.MaHoaDon == mahd)
            {
                return hd;
            }

        }
        return null;
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
    public decimal[] TinhDoanhThuTheo24h(DateTime ngayBatDau, DateTime ngayKetThuc)
    {
        decimal[] doanhThuTheoGio = new decimal[24]; // Mảng chứa doanh thu từng giờ

        // Lấy danh sách hóa đơn
        List<HoaDon> danhSachHoaDon = HoaDonDAL.Instance.GetAllHoaDon();

        foreach (var hoaDon in danhSachHoaDon)
        {
            // Kiểm tra hóa đơn có nằm trong khoảng thời gian không
            if (hoaDon.ThoiGianThanhToan >= ngayBatDau && hoaDon.ThoiGianThanhToan <= ngayKetThuc)
            {
                int gio = hoaDon.ThoiGianThanhToan.Hour; // Lấy giờ từ thời gian thanh toán
                doanhThuTheoGio[gio] += hoaDon.TongTien; // Cộng tiền vào khung giờ tương ứng
            }
        }

        return doanhThuTheoGio;
    }
    public decimal[] TinhDoanhThuTTuyenandTTiep(DateTime ngayBatDau, DateTime ngayKetThuc)
    {
        decimal[] doanhThuTheoGio = new decimal[] { 0, 0, 0 ,0};

        // Lấy danh sách hóa đơn
        List<HoaDon> danhSachHoaDon = HoaDonDAL.Instance.GetAllHoaDon();

        foreach (var hoaDon in danhSachHoaDon)
        {
            // Kiểm tra hóa đơn có nằm trong khoảng thời gian không
            if (hoaDon.ThoiGianThanhToan >= ngayBatDau && hoaDon.ThoiGianThanhToan <= ngayKetThuc)
            {
                if (hoaDon.TrangThai == "DaThanhToan")
                {

                    doanhThuTheoGio[0] += hoaDon.TongTien; // Cộng tiền vào khung giờ tương ứng
                }
                else
                {
                    doanhThuTheoGio[1] += hoaDon.TongTien;
                }
                foreach (ChiTietHoaDon ct in chi.GetChiTietHoaDonByMaHD(hoaDon.MaHoaDon))//tinh tong ve xe da ban
                {
                    doanhThuTheoGio[3] ++;
                }
                doanhThuTheoGio[2] += hoaDon.TongTien;
            }
        }

        return doanhThuTheoGio;
    }
}




