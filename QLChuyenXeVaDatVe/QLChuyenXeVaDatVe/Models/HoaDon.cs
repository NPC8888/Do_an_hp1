using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
namespace QLChuyenXeVaDatVe.Models
{
    public class HoaDon
    {
        public int MaHoaDon { get; set; }
        public int? MaKhachHang { get; set; }

        public decimal TongTien { get; set; }

        public string TrangThai { get; set; }
        public DateTime ThoiGianThanhToan { get; set; }

        // Constructor mặc định
        public HoaDon() { }

        // Constructor khởi tạo từ DataRow
        public HoaDon(DataRow row)
        {
            MaHoaDon = Convert.ToInt32(row["MaHoaDon"]);
            MaKhachHang = row["MaKhachHang"] != DBNull.Value ? Convert.ToInt32(row["MaKhachHang"]) : (int?)null;
            ThoiGianThanhToan = row["NgayThanhToan"] != DBNull.Value ? Convert.ToDateTime(row["NgayThanhToan"]) : DateTime.Now;
            TongTien = Convert.ToDecimal(row["TongTien"]);

            TrangThai = row["TrangThai"].ToString();
        }
    }
}