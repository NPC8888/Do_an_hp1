using System;
using System.Data;

namespace Models
{
    public class DanhGia
    {   public DanhGia() { }
        public DanhGia(DataRow row)
        {
            this.MaDanhGia = row["MaDanhGia"] != DBNull.Value ? Convert.ToInt32(row["MaDanhGia"]) : 0;
            this.MaXe = row["MaXe"] != DBNull.Value ? Convert.ToInt32(row["MaXe"]) : 0;
            this.MaNguoiDung = row["MaNguoiDung"] != DBNull.Value ? Convert.ToInt32(row["MaNguoiDung"]) : 0;
            this.DiemDanhGia = row["DiemDanhGia"] != DBNull.Value ? Convert.ToInt32(row["DiemDanhGia"]) : 0;
            this.BinhLuan = row["BinhLuan"] != DBNull.Value ? row["BinhLuan"].ToString() : "";
            this._Star= row["DiemDanhGia"] != DBNull.Value ? row["DiemDanhGia"].ToString() : "";
        }

        public DanhGia(int maDanhGia, int maCX, int maNguoiDung, int diemDanhGia, string binhLuan)
        {
            this.MaDanhGia = maDanhGia;
            this.MaXe = maXe;
            this.MaNguoiDung = maNguoiDung;
            this.DiemDanhGia = diemDanhGia;
            this.BinhLuan = binhLuan;
        }

        public DanhGia(DanhGia danhGia)
        {
            this.MaDanhGia = danhGia.MaDanhGia;
            this.maXe = danhGia.maXe;
            this.MaNguoiDung = danhGia.MaNguoiDung;
            this.DiemDanhGia = danhGia.DiemDanhGia;
            this.BinhLuan = danhGia.BinhLuan;
            
        }
        
        public string Star()
        {
            string a = "";
            for (int i = 0; i <diemDanhGia ; i++) {


                a += "★";


            }
          
            return a;
        }
        private string star;
        public string _Star { get => star; set => star = Star(); }

        private int maDanhGia;
        public int MaDanhGia { get => maDanhGia; set => maDanhGia = value; }

        private int maXe;
        public int MaXe { get => maXe; set => maXe = value; }

        private int maNguoiDung;
        public int MaNguoiDung { get => maNguoiDung; set => maNguoiDung = value; }

        private int diemDanhGia;
        public int DiemDanhGia { get => diemDanhGia; set => diemDanhGia = value; }

        private string binhLuan;
        public string BinhLuan { get => binhLuan; set => binhLuan = value; }
    }
}
