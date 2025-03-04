using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace QLChuyenXeVaDatVe.Models
{
	public class ChiTietHoaDon
	{
        public int MaChiTiet { get; set; }
        public int MaHoaDon { get; set; }
        public int MaVeXe { get; set; }
        public decimal GiaVe { get; set; }

        // Constructor mặc định
        public ChiTietHoaDon() { }

        // Constructor khởi tạo từ DataRow
        public ChiTietHoaDon(DataRow row)
        {
            MaChiTiet = Convert.ToInt32(row["MaChiTiet"]);
            MaHoaDon = Convert.ToInt32(row["MaHoaDon"]);
            MaVeXe = Convert.ToInt32(row["MaVeXe"]);
            GiaVe = Convert.ToDecimal(row["GiaVe"]);
        }
    }
}