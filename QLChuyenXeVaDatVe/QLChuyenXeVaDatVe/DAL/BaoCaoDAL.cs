using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using xediep.Models;

namespace QLChuyenXeVaDatVe.DAL
{
    public class BaoCaoDAL
    {
        private static BaoCaoDAL instance;

        public static BaoCaoDAL Instance
        {
            get { if (instance == null) instance = new BaoCaoDAL(); return instance; }
            private set => instance = value;
        }

        private BaoCaoDAL() { }

        public List<BaoCao> GetAllBaoCao()
        {
            List<BaoCao> baoCaos = new List<BaoCao>();
            string query = "SELECT * FROM BaoCao";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                BaoCao baoCao = new BaoCao(item);
                baoCaos.Add(baoCao);
            }

            return baoCaos;
        }

    }
}