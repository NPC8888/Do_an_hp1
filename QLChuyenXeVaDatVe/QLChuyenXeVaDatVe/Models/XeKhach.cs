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
        private int soTang;

        public int SoTang { get => soTang; set => soTang = value; }
        private int soDay;

        public int SoDay { get => soDay; set => soDay = value; }
        private int soGheMoiDay;

        public int SoGheMoiDay { get => soGheMoiDay; set => soGheMoiDay = value; }


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
            this.soTang = row["SoTang"] != DBNull.Value ? Convert.ToInt32(row["SoTang"]) : 0;
            this.soDay = row["SoDay"] != DBNull.Value ? Convert.ToInt32(row["SoDay"]) : 0;
            this.soGheMoiDay = row["SoGheMoiDay"] != DBNull.Value ? Convert.ToInt32(row["SoGheMoiDay"]) : 0;
        }

       

        public XeKhach(XeKhach xeKhach)
        {
            this.MaXe = xeKhach.MaXe;
            this.BienSoXe = xeKhach.BienSoXe;
            this.LoaiXe = xeKhach.LoaiXe;
            this.SoChoNgoi = xeKhach.SoChoNgoi;
            this.SoTang = xeKhach.SoChoNgoi;
            this.SoDay = xeKhach.SoChoNgoi;
            this.SoGheMoiDay = xeKhach.SoChoNgoi;
        }
    }
}