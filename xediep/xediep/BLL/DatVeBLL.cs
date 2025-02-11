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
    public class DatVeBLL
    {
        private static DatVeBLL instance;

        public static DatVeBLL Instance
        {
            get { if (instance == null) instance = new DatVeBLL(); return DatVeBLL.instance; }
            private set => instance = value;
        }
        public int idma;
        public bool InsertDatVe(int maGhe, int maChuyenXe, int maKH, byte trangThai, DateTime ngayDat, string hoten, string sodt,int soghe,int madiemdon,int madiemtra)
        {
            GheNgoi ghe = new GheNgoi(maGhe, maChuyenXe, maKH, soghe, trangThai, ngayDat);
            int i = GheNgoiDAL.Instance.insertGheNgoi(ghe);
            idma = i;
           
            DatVe dat = new DatVe(0,idma, maChuyenXe, maKH, trangThai, ngayDat, hoten, sodt,madiemdon,madiemtra);
             i =DatVeDAL.Instance.DatVe(dat);
            
            
            return i>0;
        }
    }
}



