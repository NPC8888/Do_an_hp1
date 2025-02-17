using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Models
{
    public class GheNgoi
    {
        public GheNgoi() { }
        public GheNgoi(int maghe,int machuyenxe ,int soghe,byte dadat,DateTime time ) {
            this.maGhe = maghe;
            this.maChuyenXe = machuyenxe;
            this.soGhe = soghe;
           
            this.daDat = dadat;
            this.tgdat = time;
        
        
        }
        public GheNgoi(DataRow row)
        {
            this.maGhe = row["MaGhe"] != DBNull.Value ? Convert.ToInt32(row["MaGhe"]) : 0;
            this.maChuyenXe = row["MaChuyenXe"] != DBNull.Value ? Convert.ToInt32(row["MaChuyenXe"]) : 0;
           
            this.daDat = row["DaDat"] != DBNull.Value ? Convert.ToByte(row["DaDat"]) : (byte)0;
            this.soGhe = row["SoGhe"] != DBNull.Value ? Convert.ToInt32(row["SoGhe"]) : 0;
            this.tgdat = row["ThoiGianDat"] != DBNull.Value
                ? DateTime.Parse(row["ThoiGianDat"].ToString())
                : DateTime.MinValue;
        }



        

        private int maGhe;
        public int MaGhe { get => maGhe; set => maGhe = value; }
        private int maChuyenXe;
        public int MaChuyenXe { get => maChuyenXe; set => maChuyenXe = value; }
      
        private int soGhe;
        public int SoGhe { get => soGhe; set => soGhe = value; }
        private byte daDat;
        public byte DaDat { get => daDat; set => daDat = value; }
        private DateTime tgdat;
        public DateTime TGDat { get => tgdat; set => tgdat = value; }
        
    } 
      
    
}