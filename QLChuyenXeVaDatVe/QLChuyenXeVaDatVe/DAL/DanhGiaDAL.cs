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
                           "VALUES ({0}, {1}, {2}, '{3}');",danhGia.MaXe,danhGia.MaNguoiDung,danhGia.DiemDanhGia,danhGia.BinhLuan);

            

            int result = DataProvider.Instance.ExecuteNonQuery(query);
            
            return result;
        }

        // Lấy danh sách đánh giá của chuyến xe
        public List<DanhGia> GetDanhGiaByMaCX(int maCX)
        {
            List<DanhGia> danhGias = new List<DanhGia>();
            string query = string.Format("SELECT * FROM DanhGia WHERE MaXe = {0}",maCX);
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
