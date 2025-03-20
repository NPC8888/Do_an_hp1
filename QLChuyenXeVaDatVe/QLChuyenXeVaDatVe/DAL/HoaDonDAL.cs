using System;
using System.Collections.Generic;
using System.Data;
using xediep.Models;
using DAL;
using QLChuyenXeVaDatVe.Models;
namespace QLChuyenXeVaDatVe.DAL
{
    public class HoaDonDAL
    {
        private static HoaDonDAL instance;

        public static HoaDonDAL Instance
        {
            get { if (instance == null) instance = new HoaDonDAL(); return instance; }
            private set => instance = value;
        }

        public HoaDonDAL() { }

        // Lấy tất cả hóa đơn
        public List<HoaDon> GetAllHoaDon()
        {
            List<HoaDon> hoaDons = new List<HoaDon>();
            string query = "SELECT * FROM HoaDon";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                HoaDon hoaDon = new HoaDon(item);
                hoaDons.Add(hoaDon);

            }
            return hoaDons;
        }

        // Cập nhật trạng thái hóa đơn
        public bool UpdateTrangThaiHoaDon(int maHoaDon, string trangThai)
        {
            string query = "UPDATE HoaDon SET TrangThai = @TrangThai WHERE MaHoaDon = @MaHoaDon";
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { trangThai, maHoaDon });
            return result > 0;
        }

        // Thêm hóa đơn mới
        public bool InsertHoaDon(HoaDon hoaDon)
        {
            string query = "INSERT INTO HoaDon (MaKhachHang, TongTien, TrangThai) VALUES (@MaKhachHang, @TongTien, @TrangThai)";
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { hoaDon.MaKhachHang, hoaDon.TongTien, hoaDon.TrangThai });
            return result > 0;
        }
        public int InsertHoaDonback(HoaDon hoaDon)
        {
            string query = string.Format("INSERT INTO HoaDon (MaKhachHang, TongTien, TrangThai) VALUES ({0}, {1}, '{2}'); SELECT SCOPE_IDENTITY()", hoaDon.MaKhachHang, hoaDon.TongTien, hoaDon.TrangThai);

            object result = DataProvider.Instance.ExecuteScalar(query);
            int newGheId = Convert.ToInt32(result);
            return newGheId;

        }
    }
}
