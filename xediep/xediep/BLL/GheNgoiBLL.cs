using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace xediep.BLL
{
    public class GheNgoiBLL
    {

        private static GheNgoiBLL instance;

        public static GheNgoiBLL Instance
        {
            get { if (instance == null) instance = new GheNgoiBLL(); return GheNgoiBLL.instance; }
            private set => instance = value;
        }
        public bool DeleteGheNgoiById(string id)
        {
            int i =GheNgoiDAL.Instance.DeleteGheNgoiById(id);
            return i > 0;

        }
        public List<GheNgoi> GetListGheNgiByIdMaNguoiDung(int id)
        {
            return GheNgoiBLL.instance.GetListGheNgiByIdMaNguoiDung(id);

        }
    }
}