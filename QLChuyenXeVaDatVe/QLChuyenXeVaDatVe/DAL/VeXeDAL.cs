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
        public int DatVe(VeXe dat)
        {
            string query = string.Format("INSERT INTO VeXe (MaKhachHang, MaChuyenXe, MaGhe, NgayDatVe, TrangThai, HoTen, SoDT, DiemDon, DiemTra) " +
                             "VALUES ( {0} , {1} , ISNULL({2}, NULL) , '{3}', N'DD', N'{4}', '{5}', {6} , {7} );SELECT mave = SCOPE_IDENTITY();",
                             dat.MaKH == 0 ? "NULL" : dat.MaKH.ToString(),
                             dat.MaChuyenXe,
                             dat.MaGhe == 0 ? "NULL" : dat.MaGhe.ToString(),
                             DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                             dat.HoTen.Replace("'", "''"),  // Tránh lỗi SQL Injection
                             dat.SoDT,
                             dat.MaDiemDon,
                             dat.MaDiemTra);
            object result = DataProvider.Instance.ExecuteScalar(query);
            int Id = Convert.ToInt32(result);
            return Id;
        }
        public int fixTrangThai(string Id)
        {
            string query = string.Format("UPDATE VeXe SET TrangThai = 'DDG' WHERE MaVeXe = {0};", Id);
            return DataProvider.Instance.ExecuteNonQuery(query);
        }
        public int fixTrangThaiHuy(string Id)
        {
            string q = "select VeXe from DatVe where MaVeXe = " + Id;
            DataTable dt = DataProvider.Instance.ExecuteQuery(q);
            DataRow dr = dt.Rows[0];
            string MaGhe = dr["MaGhe"].ToString();
            string query = string.Format("UPDATE VeXe SET TrangThai = 'Huy' , MaGhe=NULL WHERE MaVeXe = {0}; Delete from GheNgoi where MaGhe= {1};", Id, MaGhe);
            return DataProvider.Instance.ExecuteNonQuery(query);
        }

        public List<VeXe> GetListDatVebyIdNguoiDung(string id)
        {
            List<VeXe> list = new List<VeXe>();
            string query = "SELECT * FROM VeXe WHERE MaKhachHang = @MaKhachHang";
            DataTable data = DataProvider.Instance.ExecuteQuery(query, new object[] { id });

            foreach (DataRow item in data.Rows)
            {
                VeXe ve = new VeXe(item);
                list.Add(ve);
            }

            return list;
        }
        public DataTable GetDatatableVebyIdNguoi(string id)
        {
            List<VeXe> list = new List<VeXe>();
            string query = "SELECT dv.TrangThai, dv.MaVeXe, dv.MaChuyenXe, dv.HoTen, dv.SoDT, ddon.TenDiem AS TenDiemDon, dtra.TenDiem AS TenDiemTra, dv.NgayDatVe, cx.ThoiGianKhoiHanh FROM VeXe dv JOIN DiemDonTraKhach ddon ON dv.DiemDon = ddon.IDDiem JOIN DiemDonTraKhach dtra ON dv.DiemTra = dtra.IDDiem JOIN ChuyenXe cx ON dv.MaChuyenXe = cx.MaChuyenXe WHERE dv.MaKhachHang = " + id + " ORDER BY dv.NgayDatVe DESC";


            DataTable data = DataProvider.Instance.ExecuteQuery(query);



            return data;
        }
        public List<VeXe> GetALL()
        {
            List<VeXe> list = new List<VeXe>();
            string query = "SELECT * FROM VeXe";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                VeXe ve = new VeXe(item);
                list.Add(ve);
            }

            return list;
        }
    }

}