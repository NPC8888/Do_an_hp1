using System;
using System.Collections.Generic;
using System.Data;
using xediep.Models;
using DAL;
using QLChuyenXeVaDatVe.Models;

public class ChiTietHoaDonDAL
{
    private static ChiTietHoaDonDAL instance;

    public static ChiTietHoaDonDAL Instance
    {
        get { if (instance == null) instance = new ChiTietHoaDonDAL(); return instance; }
        private set => instance = value;
    }

    public ChiTietHoaDonDAL() { }

    // Lấy tất cả chi tiết hóa đơn
    public List<ChiTietHoaDon> GetAllChiTietHoaDon()
    {
        List<ChiTietHoaDon> chiTietHoaDons = new List<ChiTietHoaDon>();
        string query = "SELECT * FROM ChiTietHoaDon";
        DataTable data = DataProvider.Instance.ExecuteQuery(query);

        foreach (DataRow item in data.Rows)
        {
            ChiTietHoaDon chiTiet = new ChiTietHoaDon(item);
            chiTietHoaDons.Add(chiTiet);
        }
        return chiTietHoaDons;
    }

    // Thêm chi tiết hóa đơn mới
    public bool InsertChiTietHoaDon(ChiTietHoaDon chiTiet)
    {
        string query =string.Format( "INSERT INTO ChiTietHoaDon (MaHoaDon, MaVeXe, GiaVe) VALUES ({0}, {1}, {2})",chiTiet.MaHoaDon,chiTiet.MaVeXe,chiTiet.GiaVe);
        int result = DataProvider.Instance.ExecuteNonQuery(query);
        return result > 0;
    }

    // Xóa chi tiết hóa đơn
    public bool DeleteChiTietHoaDon(int maChiTiet)
    {
        string query = "DELETE FROM ChiTietHoaDon WHERE MaChiTiet = @MaChiTiet";
        int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { maChiTiet });
        return result > 0;
    }
}
