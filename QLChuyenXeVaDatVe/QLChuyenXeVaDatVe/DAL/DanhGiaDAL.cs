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
            string query = string.Format("UPDATE DanhGia SET MaXe = {0}  , MaNguoiDung = {1} , DiemDanhGia = {2} , BinhLuan = N'{3}' WHERE MaDanhGia = {4} ", danhGia.MaXe, danhGia.MaNguoiDung, danhGia.DiemDanhGia, danhGia.BinhLuan, danhGia.MaDanhGia);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }
        public bool DeleteDanhGia(int maDanhGia)
        {
            string query = string.Format("DELETE FROM DanhGia WHERE MaDanhGia = {0} ", maDanhGia);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

    }
}
