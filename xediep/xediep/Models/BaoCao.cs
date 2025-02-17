using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Data;

namespace xediep.Models
{
    public class BaoCao
    {
        public BaoCao() { }

        public BaoCao(DataRow row)
        {
            this.MaBaoCao = row["MaBaoCao"] != DBNull.Value ? Convert.ToInt32(row["MaBaoCao"]) : 0;
            this.LoaiBaoCao = row["LoaiBaoCao"] != DBNull.Value ? row["LoaiBaoCao"].ToString() : "";
            this.NgayBatDau = row["NgayBatDau"] != DBNull.Value ? Convert.ToDateTime(row["NgayBatDau"]) : DateTime.MinValue;
            this.NgayKetThuc = row["NgayKetThuc"] != DBNull.Value ? Convert.ToDateTime(row["NgayKetThuc"]) : DateTime.MinValue;
            this.TongSoVe = row["TongSoVe"] != DBNull.Value ? Convert.ToInt32(row["TongSoVe"]) : 0;
            this.TongDoanhThu = row["TongDoanhThu"] != DBNull.Value ? Convert.ToDecimal(row["TongDoanhThu"]) : 0;
        }

        public BaoCao(int maBaoCao, string loaiBaoCao, DateTime ngayBatDau, DateTime ngayKetThuc, int tongSoVe, decimal tongDoanhThu)
        {
            this.MaBaoCao = maBaoCao;
            this.LoaiBaoCao = loaiBaoCao;
            this.NgayBatDau = ngayBatDau;
            this.NgayKetThuc = ngayKetThuc;
            this.TongSoVe = tongSoVe;
            this.TongDoanhThu = tongDoanhThu;
        }

        public BaoCao(BaoCao baoCao)
        {
            this.MaBaoCao = baoCao.MaBaoCao;
            this.LoaiBaoCao = baoCao.LoaiBaoCao;
            this.NgayBatDau = baoCao.NgayBatDau;
            this.NgayKetThuc = baoCao.NgayKetThuc;
            this.TongSoVe = baoCao.TongSoVe;
            this.TongDoanhThu = baoCao.TongDoanhThu;
        }
    
    private int maBaoCao;
        
        public int MaBaoCao { get => maBaoCao; set => maBaoCao = value; }

        private string loaiBaoCao;
        public string LoaiBaoCao { get => loaiBaoCao; set => loaiBaoCao = value; }

        private DateTime ngayBatDau;
        public DateTime NgayBatDau { get => ngayBatDau; set => ngayBatDau = value; }

        private DateTime ngayKetThuc;
        public DateTime NgayKetThuc { get => ngayKetThuc; set => ngayKetThuc = value; }

        private int tongSoVe;
        public int TongSoVe { get => tongSoVe; set => tongSoVe = value; }

        private decimal tongDoanhThu;
        public decimal TongDoanhThu { get => tongDoanhThu; set => tongDoanhThu = value; }
    }

}