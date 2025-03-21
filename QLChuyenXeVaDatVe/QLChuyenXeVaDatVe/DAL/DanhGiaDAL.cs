using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Models;

namespace DAL
{
    public class DanhGiaDAL
    {
        private static DanhGiaDAL instance;

        public static DanhGiaDAL Instance
        {
            get { if (instance == null) instance = new DanhGiaDAL(); return instance; }
            private set => instance = value;
        }

        private DanhGiaDAL() { }

        // Thêm một đánh giá
        public int InsertDanhGia(DanhGia danhGia)
        {
            string query = string.Format("INSERT INTO DanhGia (MaXe, MaNguoiDung, DiemDanhGia, BinhLuan) " +
                           "VALUES ({0}, {1}, {2}, N'{3}');", danhGia.MaXe, danhGia.MaNguoiDung, danhGia.DiemDanhGia, danhGia.BinhLuan);



            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result;
        }


        // Lấy danh sách đánh giá của chuyến xe
        public List<DanhGia> GetDanhGiaByMaCX(int maCX)
        {
            List<DanhGia> danhGias = new List<DanhGia>();
            string query = string.Format("SELECT * FROM DanhGia WHERE MaXe = {0}", maCX);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                DanhGia danhGia = new DanhGia(item);
                danhGias.Add(danhGia);
            }

            return danhGias;
        }
        public List<DanhGia> GetAllDanhGia()
        {
            List<DanhGia> danhGias = new List<DanhGia>();
            string query = "SELECT * FROM DanhGia";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow row in data.Rows)
            {
                danhGias.Add(new DanhGia(row));
            }
            return danhGias;
        }
        public bool UpdateDanhGia(DanhGia danhGia)
        {
            string query = "UPDATE DanhGia SET MaXe = @MaXe, MaNguoiDung = @MaNguoiDung, DiemDanhGia = @DiemDanhGia, BinhLuan = @BinhLuan WHERE MaDanhGia = @MaDanhGia";
            int result = DataProvider.Instance.ExecuteNonQuery(query,
                new object[] { danhGia.MaXe, danhGia.MaNguoiDung, danhGia.DiemDanhGia, danhGia.BinhLuan, danhGia.MaDanhGia });
            return result > 0;
        }
        public bool DeleteDanhGia(int maDanhGia)
        {
            string query = "DELETE FROM DanhGia WHERE MaDanhGia = @MaDanhGia";
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { maDanhGia });
            return result > 0;
        }

    }
}
