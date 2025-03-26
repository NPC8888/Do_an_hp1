using DAL;
using Models;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class DanhGiaBLL
    {

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

            return DanhGiaDAL.Instance.GetDanhGiaByMaCX(maCX);
        }
        public DanhGia GetDanhGiaByMaDanhGia(int madanhgia)
        { foreach(var d in DanhGiaBLL.instance.GetALL())
            {
                if (d.MaDanhGia == madanhgia)
                {
                    return d;
                }
            }
        return null;
        }
        public List<DanhGia> GetALL()
        {

            return DanhGiaDAL.Instance.GetAllDanhGia();
        }
        // Thêm một đánh giá mới
        public bool AddDanhGia(DanhGia danhGia)
        {

            if (danhGia.DiemDanhGia < 1 || danhGia.DiemDanhGia > 5 || string.IsNullOrEmpty(danhGia.BinhLuan))
            {
                return false;
            }


            int newDanhGiaId = DanhGiaDAL.Instance.InsertDanhGia(danhGia);


            return newDanhGiaId > 0;
        }
        public bool DeleteDanhGia(int danhGia)
        {
            // Kiểm tra dữ liệu đầu vào (có thể thêm các kiểm tra khác nếu cần)
            if (danhGia == 0)
            {
                return false;
            }


            int newDanhGiaId = DanhGiaDAL.Instance.DeleteDanhGia(danhGia) ? 1 : 0;


            return newDanhGiaId > 0;
        }

        public bool UpdateDanhGia(DanhGia danhGia)
        {
            // Kiểm tra dữ liệu đầu vào (có thể thêm các kiểm tra khác nếu cần)
            if (danhGia == null)
            {
                return false;
            }


            int newDanhGiaId = DanhGiaDAL.Instance.UpdateDanhGia(danhGia) ? 1 : 0;


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
