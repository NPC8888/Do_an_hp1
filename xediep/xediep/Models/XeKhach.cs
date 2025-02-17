using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace xediep.Models
{
    
    public class XeKhach
    {
        private int maXe;
     
        public int MaXe { get => maXe; set => maXe = value; }

        private string bienSoXe;
        public string BienSoXe { get => bienSoXe; set => bienSoXe = value; }

        private string loaiXe;
        public string LoaiXe { get => loaiXe; set => loaiXe = value; }

        private int soChoNgoi;
        public int SoChoNgoi { get => soChoNgoi; set => soChoNgoi = value; }

        // Constructors
        public XeKhach() { }

        public XeKhach(DataRow row)
        {
            this.MaXe = row["MaXe"] != DBNull.Value ? Convert.ToInt32(row["MaXe"]) : 0;
            this.BienSoXe = row["BienSoXe"] != DBNull.Value ? row["BienSoXe"].ToString() : "";
            this.LoaiXe = row["LoaiXe"] != DBNull.Value ? row["LoaiXe"].ToString() : "";
            this.SoChoNgoi = row["SoChoNgoi"] != DBNull.Value ? Convert.ToInt32(row["SoChoNgoi"]) : 0;
        }

        public XeKhach(int maXe, string bienSoXe, string loaiXe, int soChoNgoi)
        {
            this.MaXe = maXe;
            this.BienSoXe = bienSoXe;
            this.LoaiXe = loaiXe;
            this.SoChoNgoi = soChoNgoi;
        }

        public XeKhach(XeKhach xeKhach)
        {
            this.MaXe = xeKhach.MaXe;
            this.BienSoXe = xeKhach.BienSoXe;
            this.LoaiXe = xeKhach.LoaiXe;
            this.SoChoNgoi = xeKhach.SoChoNgoi;
        }
    }
}