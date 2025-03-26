using QLChuyenXeVaDatVe.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using xediep.Models;

namespace QLChuyenXeVaDatVe.BLL
{
    public class BaoCaoBLL
    {

        private static BaoCaoBLL instance;

        public static BaoCaoBLL Instance
        {
            get { if (instance == null) instance = new BaoCaoBLL(); return instance; }
            private set => instance = value;
        }
        public List<BaoCao> GetALLBaoCao()
        {
            List<BaoCao> l = new List<BaoCao>();
            l = BaoCaoDAL.Instance.GetAllBaoCao();
            return l;
        }
        public bool InsertBaoCao(BaoCao bc)
        {
            return BaoCaoDAL.Instance.InsetBaoCap(bc);
        }
    }
}
