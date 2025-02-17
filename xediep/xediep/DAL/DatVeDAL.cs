using DAL;

using Models;
using System;
using System.Collections.Generic;
using System.Data;
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
        public int fixTrangThai(string Id)
        {
            string query = string.Format("UPDATE DatVe SET TrangThai = 'DDG' WHERE MaDatVe = {0};",Id);
            return DataProvider.Instance.ExecuteNonQuery(query);
        }
        public int fixTrangThaiHuy(string Id)
        {
            string q = "select MaGhe from DatVe where MaDatVe = " + Id;
            DataTable dt = DataProvider.Instance.ExecuteQuery(q);
            DataRow dr = dt.Rows[0];
            string MaGhe = dr["MaGhe"].ToString();
            string query = string.Format("UPDATE DatVe SET TrangThai = 'Huy' , MaGhe=NULL WHERE MaDatVe = {0}; Delete from GheNgoi where MaGhe= {1};", Id,MaGhe);
            return DataProvider.Instance.ExecuteNonQuery(query);
        }

        public List<DatVe> GetListDatVebyIdNguoiDung(string id)
        {
            List<DatVe> list = new List<DatVe>();
            string query = "SELECT * FROM DatVe WHERE MaKhachHang = @MaKhachHang";
            DataTable data = DataProvider.Instance.ExecuteQuery(query, new object[] { id });

            foreach (DataRow item in data.Rows)
            {
                DatVe ve = new DatVe(item);
                list.Add(ve);
            }

            return list;
        }
        public DataTable GetDatatableVebyIdNguoi(string id)
        {
            List<DatVe> list = new List<DatVe>();
            string query = "SELECT dv.TrangThai, dv.MaDatVe, dv.MaChuyenXe, dv.HoTen, dv.SoDT, ddon.TenDiem AS TenDiemDon, dtra.TenDiem AS TenDiemTra, dv.NgayDatVe, cx.ThoiGianKhoiHanh FROM DatVe dv JOIN DiemDonTraKhach ddon ON dv.DiemDon = ddon.IDDiem JOIN DiemDonTraKhach dtra ON dv.DiemTra = dtra.IDDiem JOIN ChuyenXe cx ON dv.MaChuyenXe = cx.MaChuyenXe WHERE dv.MaKhachHang = " + id + " ORDER BY dv.NgayDatVe DESC";


            DataTable data = DataProvider.Instance.ExecuteQuery(query);

           

            return data;
        }
    }
}