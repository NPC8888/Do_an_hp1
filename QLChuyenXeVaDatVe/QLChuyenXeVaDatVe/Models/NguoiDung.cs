using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Models
{
    public class NguoiDung
    {
        public NguoiDung() { }
        public NguoiDung(NguoiDung a) {
            this.tenDangNhap = a.TenDangNhap; ;
            this.maNguoiDung = a.MaNguoiDung;
            this.hoTen =a.HoTen;
            this.matKhau = a.MatKhau;
            this.sDT = a.SDT;
            this.eMai = a.eMai;
            this.vaiTro =a.vaiTro;




        }
        public NguoiDung(DataRow row)
        {
            
            this.tenDangNhap = row["TenDangNhap"] != DBNull.Value ? (row["TenDangNhap"]).ToString() : "";
            this.maNguoiDung = row["MaNguoiDung"] != DBNull.Value ? Convert.ToInt32(row["MaNguoiDung"]) : 0;
            this.hoTen = row["HoTen"] != DBNull.Value ? (row["HoTen"]).ToString() : "";
            this.matKhau = row["MatKhau"] != DBNull.Value ? (row["MatKhau"]).ToString() : "";
            this.sDT = row["SoDienThoai"] != DBNull.Value ? (row["SoDienThoai"]).ToString() : "";
            this.eMai = row["Email"] != DBNull.Value ? (row["Email"]).ToString() : "";
            this.vaiTro = row["VaiTro"] != DBNull.Value ? (row["VaiTro"]).ToString() : "";
            this.token = row["Token"] != DBNull.Value ? (row["Token"]).ToString() : "";
        }





        private int maNguoiDung;
        public int MaNguoiDung { get => maNguoiDung; set => maNguoiDung = value; }
        private string tenDangNhap;
        public string TenDangNhap { get => tenDangNhap; set => tenDangNhap = value; }
        private string hoTen;
        public string HoTen { get => hoTen; set => hoTen = value; }

        private string matKhau;
        public string MatKhau { get => matKhau; set => matKhau = value; }
        private string sDT;
        public string SDT { get => sDT; set => sDT = value; }
        private string eMai;
        public string EMai { get => eMai; set => eMai = value; }
        private string vaiTro;
        public string VaiTro { get => vaiTro; set => vaiTro = value; }
        private string token;
        public string Token { get => token; set => token = value; }



    }

}
