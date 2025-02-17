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



        public List<ChuyenXe> GetListChuyenXe()
        {
            List<ChuyenXe> list = new List<ChuyenXe>();
            string query = string.Format("select * from ChuyenXe where ThoiGianKhoiHanh > '{0}'",DateTime.Now);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                ChuyenXe chuyenXe = new ChuyenXe(item);
                list.Add(chuyenXe);
            }
            return list;

        }

        public List<ChuyenXe> SearchChuyenXeByMaTuyenXe(int maTuyenXe, string ngayKhoiHanh)
        {
            List<ChuyenXe> list = new List<ChuyenXe>();
            string query = string.Format("SELECT * FROM ChuyenXe WHERE MaTuyenXe = {0} AND ThoiGianKhoiHanh >= '{1}'", maTuyenXe, ngayKhoiHanh);
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