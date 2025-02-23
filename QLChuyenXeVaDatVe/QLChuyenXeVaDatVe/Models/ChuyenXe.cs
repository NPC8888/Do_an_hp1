using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Models
{
    public class ChuyenXe
    {
        public ChuyenXe()
        {

        }

        public ChuyenXe(DataRow row)
        {
            this.maCx = (int)row["MaChuyenXe"];
            this.maTuyenXe = (int)row["MaTuyenXe"];

            if (row["price"] != DBNull.Value && decimal.TryParse(row["price"].ToString(), out decimal parsedPrice))
            {
                this.price = parsedPrice;
            }
            else
            {
                this.price = 0; // Giá trị mặc định nếu không thể chuyển đổi
            }
            this.tgKhoiHanh = DateTime.Parse(row["ThoiGianKhoiHanh"].ToString());
            this.tgDen = DateTime.Parse(row["ThoiGianDen"].ToString());

            this.maTaiXe = (int)row["MaTaiXe"];
            this.maXe = (int)row["MaXe"];
            this.trangThai = row["TrangThai"].ToString();
        }
       public ChuyenXe(ChuyenXe cx)
        {
            this.MaCx = cx.MaCx;
            this.MaTuyenXe=cx.MaTuyenXe;
            this.maXe= cx.maXe;
            this.maTaiXe=cx.maTaiXe;
            this.TrangThai=cx.TrangThai;
            this.TgKhoiHanh=cx.TgKhoiHanh;
            this.tgDen=cx.tgDen;
            this.price=cx.price;
        }




        private int maCx;
        public int MaCx { get => maCx; set => maCx = value; }

        private int maTuyenXe;
        public int MaTuyenXe { get => maTuyenXe; set => maTuyenXe = value; }
        private DateTime tgKhoiHanh;
        public DateTime TgKhoiHanh { get => tgKhoiHanh; set => tgKhoiHanh = value; }
        private DateTime tgDen;
        public DateTime TgDen { get => tgDen; set => tgDen = value; }
        private decimal price;
        public decimal Price { get => price; set => price = value; }
        private int maTaiXe;
        public int MaTaiXe { get => maTaiXe; set => maTaiXe = value; }
        private int maXe;
        public int MaXe { get => maXe; set => maXe = value; }
        private string trangThai;
        public string TrangThai { get => trangThai; set => trangThai = value; }


    }

}
