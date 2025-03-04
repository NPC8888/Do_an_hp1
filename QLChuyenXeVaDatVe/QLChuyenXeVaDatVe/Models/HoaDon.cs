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
        public DateTime NgayThanhToan { get; set; }
        public decimal TongTien { get; set; }
        public int MaPhuongThuc { get; set; }
        public string TrangThai { get; set; }

        // Constructor mặc định
        public HoaDon() { }

        // Constructor khởi tạo từ DataRow
        public HoaDon(DataRow row)
        {
            MaHoaDon = Convert.ToInt32(row["MaHoaDon"]);
            MaKhachHang = row["MaKhachHang"] != DBNull.Value ? Convert.ToInt32(row["MaKhachHang"]) : (int?)null;
            NgayThanhToan = row["NgayThanhToan"] != DBNull.Value ? Convert.ToDateTime(row["NgayThanhToan"]) : DateTime.Now;
            TongTien = Convert.ToDecimal(row["TongTien"]);
            MaPhuongThuc = Convert.ToInt32(row["MaPhuongThuc"]);
            TrangThai = row["TrangThai"].ToString();
        }
    }
}