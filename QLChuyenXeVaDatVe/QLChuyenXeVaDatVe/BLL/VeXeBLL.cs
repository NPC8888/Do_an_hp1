using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using DAL;
using Models;

namespace BLL
{
    public class VeXeBLL
    {
        private static VeXeBLL instance;

        public static VeXeBLL Instance
        {
            get { if (instance == null) instance = new VeXeBLL(); return VeXeBLL.instance; }
            private set => instance = value;
        }
        public int idma;
        public int InsertDatVe(int maGhe, int maChuyenXe, int maKH, string trangThai, DateTime ngayDat, string hoten, string sodt, int soghe, int madiemdon, int madiemtra)
        {
            GheNgoi ghe = new GheNgoi(maGhe, maChuyenXe, soghe, 1, ngayDat);
            int i = GheNgoiDAL.Instance.insertGheNgoi(ghe);
            idma = i;

            VeXe dat = new VeXe { MaChuyenXe = maChuyenXe, MaGhe=idma, MaKH = maKH, TrangThai = trangThai, NgayDat = ngayDat, HoTen = hoten, SoDT = sodt, MaDiemDon = madiemdon, MaDiemTra = madiemtra };
            int idve = DatVeDAL.Instance.DatVe(dat);


            return idve;
        }
        public bool FixTrangThaiKhiDanhGia(string Idve)
        {
            int i =DatVeDAL.Instance.fixTrangThai(Idve);
            return i > 0;
        }
        public bool FixTrangThaiKhiHuy(string Idve)
        {
            int i = DatVeDAL.Instance.fixTrangThaiHuy(Idve);
            return i > 0;
        }
        public List<VeXe> GetListDatVebyIdNguoiDung(string id)
        {
            return DatVeDAL.Instance.GetListDatVebyIdNguoiDung(id);
        }
        public DataTable GetDTVebyIdNguoiDung(string id)
        {
            return DatVeDAL.Instance.GetDatatableVebyIdNguoi(id);
        }
    }
}



