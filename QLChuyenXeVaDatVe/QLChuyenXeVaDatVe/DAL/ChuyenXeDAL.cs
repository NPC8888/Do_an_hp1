using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using xediep.DAL;
using xediep.Models;

namespace DAL
{
    public class ChuyenXeDAL
    {
        private static ChuyenXeDAL instance;

        public static ChuyenXeDAL Instance
        {
            get { if (instance == null) instance = new ChuyenXeDAL(); return ChuyenXeDAL.instance; }
            private set => instance = value;
        }

        private ChuyenXeDAL() { }

        public static int diemdi =23;
        public static int diemden = 26;

        public bool InsertChuyenXe(ChuyenXe cx)
        {
            string query = string.Format(
                "INSERT INTO ChuyenXe (MaTuyenXe, ThoiGianKhoiHanh, ThoiGianDen, Price, MaTaiXe, MaXe, TrangThai) " +
                "VALUES ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}', N'{6}')",
                cx.MaTuyenXe, cx.TgKhoiHanh.ToString("yyyy-MM-dd HH:mm:ss"), cx.TgDen.ToString("yyyy-MM-dd HH:mm:ss"),
                cx.Price, cx.MaTaiXe, cx.MaXe, cx.TrangThai
            );

            return DataProvider.Instance.ExecuteNonQuery(query) > 0;
        }

        public bool UpdateChuyenXe(ChuyenXe cx)
        {
            string query = string.Format(
                "UPDATE ChuyenXe SET MaTuyenXe='{0}', ThoiGianKhoiHanh='{1}', ThoiGianDen='{2}', Price='{3}', MaTaiXe='{4}', MaXe='{5}', TrangThai=N'{6}' " +
                "WHERE MaChuyenXe='{7}'",
                cx.MaTuyenXe, cx.TgKhoiHanh.ToString("yyyy-MM-dd HH:mm:ss"), cx.TgDen.ToString("yyyy-MM-dd HH:mm:ss"),
                cx.Price, cx.MaTaiXe, cx.MaXe, cx.TrangThai, cx.MaCx
            );

            return DataProvider.Instance.ExecuteNonQuery(query) > 0;
        }

        public bool DeleteChuyenXe(int maCx)
        {
            string query = string.Format("DELETE FROM ChuyenXe WHERE MaChuyenXe='{0}'", maCx);
            return DataProvider.Instance.ExecuteNonQuery(query) > 0;
        }

        public List<ChuyenXe> SearchChuyenXe(string maTuyenXe)
        {
            string query = string.Format("SELECT * FROM ChuyenXe WHERE MaTuyenXe LIKE '%{0}%'", maTuyenXe);
            DataTable dt = DataProvider.Instance.ExecuteQuery(query);

            List<ChuyenXe> list = new List<ChuyenXe>();
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new ChuyenXe(row));
            }

            return list;
        }


        public List<ChuyenXe> GetListChuyenXe()
        {
            List<ChuyenXe> list = new List<ChuyenXe>();
            string query = string.Format("select * from ChuyenXe where ThoiGianKhoiHanh = '{0}'",DateTime.Now);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                ChuyenXe chuyenXe = new ChuyenXe(item);
                list.Add(chuyenXe);
            }
            return list;

        }
        public List<ChuyenXe> GetALLCX()
        {
            List<ChuyenXe> list = new List<ChuyenXe>();
            string query = string.Format("select * from ChuyenXe");
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                ChuyenXe chuyenXe = new ChuyenXe(item);
                list.Add(chuyenXe);
            }
            return list;

        }

  
        public ChuyenXe getGiaXeByMaXe(string id)
        {
            int i = int.Parse(id);
            string query = string.Format("select * from ChuyenXe where MaChuyenXe={0}", i);
            DataTable dt = DataProvider.Instance.ExecuteQuery(query);

            DataRow dr = dt.Rows[0];
            ChuyenXe cx=new ChuyenXe(dr);
            
            return cx;
        }

        

    }
}