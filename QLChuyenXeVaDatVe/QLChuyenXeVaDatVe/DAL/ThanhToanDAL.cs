using System;
using System.Collections.Generic;
using System.Data;
using xediep.Models;
using DAL;
using QLChuyenXeVaDatVe.Models;

public class ThanhToanDAL
{
    private static ThanhToanDAL instance;

    public static ThanhToanDAL Instance
    {
        get { if (instance == null) instance = new ThanhToanDAL(); return instance; }
        private set => instance = value;
    }

    public ThanhToanDAL() { }

    // Lấy tất cả thanh toán
    public List<ThanhToan> GetAllThanhToan()
    {
        List<ThanhToan> thanhToans = new List<ThanhToan>();
        string query = "SELECT * FROM ThanhToan";
        DataTable data = DataProvider.Instance.ExecuteQuery(query);

        foreach (DataRow item in data.Rows)
        {
            ThanhToan thanhToan = new ThanhToan(item);
            thanhToans.Add(thanhToan);
        }
        return thanhToans;
    }

    // Thêm thanh toán mới
    public bool InsertThanhToan(ThanhToan thanhToan)
    {
        string query = string.Format("INSERT INTO ThanhToan ( MaHoaDon, PhuongThucThanhToan, TrangThai) VALUES ({0},'{1}','{2}')",thanhToan.MaHoaDon,thanhToan.PhuongThucThanhToan,thanhToan.TrangThai);
        int result = DataProvider.Instance.ExecuteNonQuery(query);
        return result > 0;
    }

    // Cập nhật trạng thái thanh toán
    public bool UpdateTrangThaiThanhToan(int maThanhToan, string trangThai)
    {
        string query = "UPDATE ThanhToan SET TrangThai = @TrangThai WHERE MaThanhToan = @MaThanhToan";
        int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { trangThai, maThanhToan });
        return result > 0;
    }
}
