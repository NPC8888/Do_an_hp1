using BLL;
using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace xediep.BLL
{
    public class ChuyenXeBLL
    {
        private static ChuyenXeBLL instance;

        public static ChuyenXeBLL Instance
        {
            get { if (instance == null) instance = new ChuyenXeBLL(); return instance; }
            private set => instance = value;
        }
       public List<ChuyenXe> GetALLChuyenXe()
        {
            List<ChuyenXe> l= new List<ChuyenXe>();
            l = ChuyenXeDAL.Instance.GetListChuyenXe();
           
            return l;
        }
        public List<ChuyenXe> GetALLChuyenXeByTuyenXeAndDate(int MaTuyen ,string date)
        {
            List<ChuyenXe> l = new List<ChuyenXe>();
            l = ChuyenXeDAL.Instance.SearchChuyenXeByMaTuyenXe(MaTuyen,date);
           
            return l;
        }

    }
}