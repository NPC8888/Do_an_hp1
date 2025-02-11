using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

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
            string query = "select * from ChuyenXe";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                ChuyenXe chuyenXe = new ChuyenXe(item);
                list.Add(chuyenXe);
            }
            return list;

        }

        public List<ChuyenXe> SearchChuyenXeByName(string DiemDi ,string DiemDen)
        {
            List<ChuyenXe> list = new List<ChuyenXe>();
            string query = string.Format("SELECT * FROM ChuyenXe WHERE DiemDi LIKE N'%' + N'{0}' + '%' and DiemDen LIKE N'%' + N'{1}' + '%'", DiemDi,DiemDen);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                ChuyenXe coffee = new ChuyenXe(item);
                list.Add(coffee);
            }
            return list;

        }

        public bool InsertCoffee(string name, int id, decimal price)
        {
            string query = string.Format("INSERT dbo.Coffee(NameCoffee ,idCategory,Price )Values(N'{0}',{1},{2} )", name, id, price);

            int ruset = DataProvider.Instance.ExecuteNonQuery(query);

            return ruset > 0;

        }
        public bool UpdateCofee(int idcoffee, string name, int id, decimal price)
        {
            string query = string.Format("UPDATE dbo.Coffee SET NameCoffee=N'{0}',idCategory={1},Price={2} where idCoffee={3}", name, id, price, idcoffee);

            int ruset = DataProvider.Instance.ExecuteNonQuery(query);

            return ruset > 0;

        }
        public bool DeleteCofee(int idcoffee)
        {
            string query = string.Format("Delete dbo.Coffee where idCoffee={0}", idcoffee);
            int ruset = DataProvider.Instance.ExecuteNonQuery(query);

            return ruset > 0;

        }

    }
}