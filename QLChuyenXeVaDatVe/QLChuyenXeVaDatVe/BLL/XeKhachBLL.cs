using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using xediep.Models;

namespace xediep.BLL
{
    namespace BLL
    {
        public class XeKhachBLL
        {
            private static XeKhachBLL instance;

            public static XeKhachBLL Instance
            {
                get { if (instance == null) instance = new XeKhachBLL(); return instance; }
                private set => instance = value;
            }
            private XeKhachDAL xeKhachDAL = new XeKhachDAL();
            
            public List<XeKhach> GetAllXeKhach()
            {
                return xeKhachDAL.GetAllXeKhach();
            }

            public bool AddXeKhach(XeKhach xe)
            {
                return xeKhachDAL.InsertXeKhach(xe);
            }

            public bool EditXeKhach(XeKhach xe)
            {
                return xeKhachDAL.UpdateXeKhach(xe);
            }

            public bool RemoveXeKhach(int maXe)
            {
                return xeKhachDAL.DeleteXeKhach(maXe);
            }
        }
    }

}