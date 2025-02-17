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
            
            maTuyenXe = MaChuyenXe;
            tenDiem = TenDiem;
            diaChi = Diachi;
            loaiDiem = LoaiDiem;
           
                
        
        
        }
        public DiemDonTraKhach(DiemDonTraKhach a)
        {
            this.tenDiem = a.tenDiem;
            this.maDiem = a.maDiem;
            this.maTuyenXe = a.maTuyenXe;
            this.diaChi = a.diaChi;
            this.loaiDiem = a.loaiDiem;
       




        }
        public DiemDonTraKhach(DataRow row)
        {

            this.tenDiem = row["TenDiem"] != DBNull.Value ? (row["TenDiem"]).ToString() : "";
            this.maDiem = row["IDDiem"] != DBNull.Value ? Convert.ToInt32(row["IDDiem"]) : 0;
            this.maTuyenXe = row["MaTuyenXe"] != DBNull.Value ? Convert.ToInt32(row["MaTuyenXe"]) : 0;
            this.diaChi = row["DiaChi"] != DBNull.Value ? (row["DiaChi"]).ToString() : "";
            this.loaiDiem = row["LoaiDiem"] != DBNull.Value ? (row["LoaiDiem"]).ToString() : "";
           
        }





        private int maDiem;
        public int MaDiem { get => maDiem; set => maDiem = value; }
        private int maTuyenXe;
        public int MaTuyenXe { get => maTuyenXe; set => maTuyenXe = value; }
        private string tenDiem;
        public string TenDiem { get => tenDiem; set => tenDiem = value; }
        private string diaChi;
        public string DiaChi { get => diaChi; set => diaChi = value; }

        private string loaiDiem;
        public string LoaiDiem { get => loaiDiem; set => loaiDiem = value; }
     
        
        
        
        
        



    }
}
