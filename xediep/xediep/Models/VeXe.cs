using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Models
{
    public class VeXe
    {
        public VeXe(DataRow row)
        {
            this.maDatVe = row["MaVeXe"] != DBNull.Value ? Convert.ToInt32(row["MaVeXe"]) : 0;
            this.maGhe = row["MaGhe"] != DBNull.Value ? Convert.ToInt32(row["MaGhe"]) : 0;
            this.maDiemDon = row["DiemDon"] != DBNull.Value ? Convert.ToInt32(row["DiemDon"]) : 0;
            this.maDiemTra = row["DiemTra"] != DBNull.Value ? Convert.ToInt32(row["DiemTra"]) : 0;
            this.maChuyenXe = row["MaChuyenXe"] != DBNull.Value ? Convert.ToInt32(row["MaChuyenXe"]) : 0;
            this.maKH = row["MaKhachHang"] != DBNull.Value ? Convert.ToInt32(row["MaKhachHang"]) : 0;
            this.trangThai = row["TrangThai"] != DBNull.Value ? row["TrangThai"].ToString() : "";
            this.hoTen = row["HoTen"] != DBNull.Value ? (row["HoTen"]).ToString() : "";
            this.soDT = row["SoDT"] != DBNull.Value ? (row["SoDT"]).ToString() : "";
            this.ngayDat = row["NgayDatVe"] != DBNull.Value
                ? DateTime.Parse(row["NgayDatVe"].ToString())
                : DateTime.MinValue;
        }
        public VeXe(int maDatVe,int maGhe,int maChuyenXe,int maKH,string trangThai,DateTime ngayDat,string hoten,string sodt,int madiemdon,int madiemtra)
        {
            this.MaDatVe = maDatVe;
            this.maGhe = maGhe;
            this.maChuyenXe= maChuyenXe;
            this.maKH = maKH;
            this.trangThai= trangThai;
            this.ngayDat = ngayDat;
            this.hoTen = hoten;
            this.soDT = sodt;
            this.maDiemDon= madiemdon;
            this.maDiemTra= madiemtra;
        }

        public VeXe(VeXe datVe)
        {
            this.MaDatVe = datVe.MaDatVe;
            this.maGhe  = datVe.maGhe;
            this.maChuyenXe = datVe.maChuyenXe;
            this.maKH= datVe.maKH;
            this.trangThai = datVe.trangThai;
            this.ngayDat= datVe.ngayDat;
            this.hoTen= datVe.hoTen;
            this.soDT= datVe.soDT;
            this.MaDiemDon= datVe.MaDiemDon;
            this.maDiemTra= datVe.maDiemTra;
        }



        private int maDatVe;
        public int MaDatVe { get => maDatVe; set => maDatVe = value; }
        private int maDiemDon;
        public int MaDiemDon { get => maDiemDon; set => maDiemDon = value; }
        private int maDiemTra;
        public int MaDiemTra { get => maDiemTra; set => maDiemTra = value; }

        private int maChuyenXe;
        public int MaChuyenXe { get => maChuyenXe; set => maChuyenXe = value; }
        private int maKH;
        public int MaKH { get => maKH; set => maKH = value; }
        private int maGhe;
        public int MaGhe { get => maGhe; set => maGhe = value; }
        private string hoTen;
        public string HoTen { get => hoTen; set => hoTen = value; }
        private string soDT;
        public string SoDT { get => soDT; set => soDT = value; }
        private string trangThai;
        public string TrangThai { get => trangThai; set => trangThai = value; }
        private DateTime ngayDat;
        public DateTime NgayDat { get => ngayDat; set => ngayDat = value; }

    }
}