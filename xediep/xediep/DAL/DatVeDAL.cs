using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DAL
{
    public class DatVeDAL
    {
        private static DatVeDAL instance;

        public static DatVeDAL Instance
        {
            get { if (instance == null) instance = new DatVeDAL(); return DatVeDAL.instance; }
            private set => instance = value;
        }
        public int DatVe(DatVe dat)
        {
            string query = string.Format("INSERT INTO DatVe (MaKhachHang, MaChuyenXe, MaGhe, NgayDatVe, TrangThai, HoTen, SoDT, DiemDon, DiemTra) VALUES ( {0} , {1} , {2} , '{3}', N'DD', N'{4}', '{5}', {6} , {7})", dat.MaKH, dat.MaChuyenXe, dat.MaGhe, DateTime.Now, dat.HoTen, dat.SoDT, dat.MaDiemDon, dat.MaDiemTra);
            return DataProvider.Instance.ExecuteNonQuery(query);
        }

    }
}