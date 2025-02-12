using DAL;
using Models;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class DanhGiaBLL
    {
        // Singleton pattern để chỉ có một instance của DanhGiaBLL
        private static DanhGiaBLL instance;

        public static DanhGiaBLL Instance
        {
            get { if (instance == null) instance = new DanhGiaBLL(); return instance; }
            private set => instance = value;
        }

        private DanhGiaBLL() { }

        // Lấy danh sách đánh giá cho một chuyến xe
        public List<DanhGia> GetDanhGiaByMaCX(int maCX)
        {
            // Sử dụng DAL để lấy dữ liệu từ cơ sở dữ liệu
            return DanhGiaDAL.Instance.GetDanhGiaByMaCX(maCX);
        }

        // Thêm một đánh giá mới
        public bool AddDanhGia(DanhGia danhGia)
        {
            // Kiểm tra dữ liệu đầu vào (có thể thêm các kiểm tra khác nếu cần)
            if (danhGia.DiemDanhGia < 1 || danhGia.DiemDanhGia > 5 || string.IsNullOrEmpty(danhGia.BinhLuan))
            {
                return false; // Trả về false nếu dữ liệu không hợp lệ
            }

            // Sử dụng DAL để thêm dữ liệu vào cơ sở dữ liệu
            int newDanhGiaId = DanhGiaDAL.Instance.InsertDanhGia(danhGia);

            // Kiểm tra nếu việc thêm thành công (trả về id đánh giá mới)
            return newDanhGiaId > 0;
        }

        // Tính điểm trung bình cho chuyến xe
        public double CalculateAverageRating(int maCX)
        {
            // Lấy danh sách các đánh giá cho chuyến xe
            List<DanhGia> danhGias = GetDanhGiaByMaCX(maCX);
            if (danhGias.Count == 0) return 0; // Không có đánh giá nào, trả về 0

            // Tính điểm trung bình
            double totalPoints = 0;
            foreach (var danhGia in danhGias)
            {
                totalPoints += danhGia.DiemDanhGia;
            }

            return totalPoints / danhGias.Count;
        }
    }
}
