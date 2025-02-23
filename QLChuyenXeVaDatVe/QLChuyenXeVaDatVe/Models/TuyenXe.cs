using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace xediep.Models
{
    public class TuyenXe
    {

        public TuyenXe() { }

        public TuyenXe(DataRow row)
        {
            this.MaTuyenXe = row["MaTuyenXe"] != DBNull.Value ? Convert.ToInt32(row["MaTuyenXe"]) : 0;
            this.DiemDi = row["DiemDi"] != DBNull.Value ? row["DiemDi"].ToString() : "";
            this.DiemDen = row["DiemDen"] != DBNull.Value ? row["DiemDen"].ToString() : "";
            this.TrangThai = row["TrangThai"] != DBNull.Value ? row["TrangThai"].ToString() : "";
        }

        public TuyenXe(int maTuyenXe, string diemDi, string diemDen, string trangThai)
        {
            this.MaTuyenXe = maTuyenXe;
            this.DiemDi = diemDi;
            this.DiemDen = diemDen;
            this.TrangThai = trangThai;
        }

        public TuyenXe(TuyenXe tuyenXe)
        {
            this.MaTuyenXe = tuyenXe.MaTuyenXe;
            this.DiemDi = tuyenXe.DiemDi;
            this.DiemDen = tuyenXe.DiemDen;
            this.TrangThai = tuyenXe.TrangThai;
        }
        private int maTuyenXe;
        public int MaTuyenXe { get => maTuyenXe; set => maTuyenXe = value; }

        private string diemDi;
        public string DiemDi { get => diemDi; set => diemDi = value; }

        private string diemDen;
        public string DiemDen { get => diemDen; set => diemDen = value; }

        private string trangThai;
        public string TrangThai { get => trangThai; set => trangThai = value; } // Hoạt động, Ngừng hoạt động


    }
}