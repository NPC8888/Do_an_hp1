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
            string query = "INSERT INTO DanhGia (MaCX, MaNguoiDung, DiemDanhGia, BinhLuan) " +
                           "VALUES (@MaCX, @MaNguoiDung, @DiemDanhGia, @BinhLuan);";

            var parameters = new object[]
            {
                new SqlParameter("@MaCX", danhGia.MaCX),
                new SqlParameter("@MaNguoiDung", danhGia.MaNguoiDung),
                new SqlParameter("@DiemDanhGia", danhGia.DiemDanhGia),
                new SqlParameter("@BinhLuan", danhGia.BinhLuan)
            };

            object result = DataProvider.Instance.ExecuteNonQuery(query, parameters);
            int newDanhGiaId = Convert.ToInt32(result);
            return newDanhGiaId;
        }

        // Lấy danh sách đánh giá của chuyến xe
        public List<DanhGia> GetDanhGiaByMaCX(int maCX)
        {
            List<DanhGia> danhGias = new List<DanhGia>();
            string query = string.Format("SELECT * FROM DanhGia WHERE MaCX = {0}",maCX);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                DanhGia danhGia = new DanhGia(item);
                danhGias.Add(danhGia);
            }

            return danhGias;
        }
    }
}
