using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Models
{
    public class DiemDonTraKhach
    {
        public DiemDonTraKhach() { }
        public DiemDonTraKhach(int MaChuyenXe, string TenDiem,string Diachi,string LoaiDiem,DateTime TG) {
            
            maChuyenXe = MaChuyenXe;
            tenDiem = TenDiem;
            diaChi = Diachi;
            loaiDiem = LoaiDiem;
            thoiGian = TG;
                
        
        
        }
        public DiemDonTraKhach(DiemDonTraKhach a)
        {
            this.tenDiem = a.tenDiem;
            this.maDiem = a.maDiem;
            this.maChuyenXe = a.maChuyenXe;
            this.diaChi = a.diaChi;
            this.loaiDiem = a.loaiDiem;
            this.thoiGian=a.thoiGian;




        }
        public DiemDonTraKhach(DataRow row)
        {

            this.tenDiem = row["TenDiem"] != DBNull.Value ? (row["TenDiem"]).ToString() : "";
            this.maDiem = row["IDDiem"] != DBNull.Value ? Convert.ToInt32(row["IDDiem"]) : 0;
            this.maChuyenXe = row["MaChuyenXe"] != DBNull.Value ? Convert.ToInt32(row["MaChuyenXe"]) : 0;
            this.diaChi = row["DiaChi"] != DBNull.Value ? (row["DiaChi"]).ToString() : "";
            this.loaiDiem = row["LoaiDiem"] != DBNull.Value ? (row["LoaiDiem"]).ToString() : "";
            this.thoiGian = row["ThoiGian"] != DBNull.Value
                  ? DateTime.Parse(row["ThoiGian"].ToString())
                  : DateTime.MinValue;
        }





        private int maDiem;
        public int MaDiem { get => maDiem; set => maDiem = value; }
        private int maChuyenXe;
        public int MaChuyenXe { get => maChuyenXe; set => maChuyenXe = value; }
        private string tenDiem;
        public string TenDiem { get => tenDiem; set => tenDiem = value; }
        private string diaChi;
        public string DiaChi { get => diaChi; set => diaChi = value; }

        private string loaiDiem;
        public string LoaiDiem { get => loaiDiem; set => loaiDiem = value; }
        private DateTime thoiGian;
        public DateTime ThoiGian { get => thoiGian; set => thoiGian = value; }
        
        
        
        
        



    }
}
