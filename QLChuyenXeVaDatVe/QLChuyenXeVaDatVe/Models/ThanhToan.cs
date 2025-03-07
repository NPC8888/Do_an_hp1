using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace QLChuyenXeVaDatVe.Models
{
	public class ThanhToan
	{
        public int MaThanhToan { get; set; }
        public int MaHoaDon { get; set; }
        public string PhuongThucThanhToan { get; set; }
        
        public string TrangThai { get; set; }
        public DateTime ThoiGianThanhToan { get; set; }

        // Constructor mặc định
        public ThanhToan() { }

        // Constructor khởi tạo từ DataRow
        public ThanhToan(DataRow row)
        {
            MaThanhToan = Convert.ToInt32(row["MaThanhToan"]);
            MaHoaDon = row["MaHoaDon"] != DBNull.Value ? Convert.ToInt32(row["MaHoaDon"]) : 0;
            PhuongThucThanhToan = row["PhuongThucThanhToan"].ToString();
            
            TrangThai = row["TrangThai"].ToString();
            ThoiGianThanhToan = row["ThoiGianThanhToan"] != DBNull.Value ? Convert.ToDateTime(row["ThoiGianThanhToan"]) : DateTime.Now;
        }

    }
}