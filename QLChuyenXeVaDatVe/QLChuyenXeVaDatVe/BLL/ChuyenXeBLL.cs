using BLL;
using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
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
       public List<ChuyenXe> GetALLChuyenXeByDatatimeMoreThanNow()
        {
            List<ChuyenXe> l= new List<ChuyenXe>();
            l = ChuyenXeDAL.Instance.GetALLCX();
            
           
            return l;
        }
        public List<ChuyenXe> GetALLChuyenXeToDay()
        {
            List<ChuyenXe> cxs = new List<ChuyenXe>();
            List<ChuyenXe> l = new List<ChuyenXe>();
            l = ChuyenXeDAL.Instance.GetALLCX();
            foreach (var cx in l)
            {
                if (cx.TgKhoiHanh.Date == DateTime.Today.Date) cxs.Add(cx);

            }

            return cxs;
        }
        public List<ChuyenXe> GetALLChuyenXe()
        {
            List<ChuyenXe> l = new List<ChuyenXe>();
            l = ChuyenXeDAL.Instance.GetALLCX();

            return l;
        }
        public List<ChuyenXe> GetALLChuyenXeByTuyenXeAndDate(int MaTuyen ,string date)
        {
            List<ChuyenXe> l = new List<ChuyenXe>();
            foreach(var cx in ChuyenXeBLL.Instance.GetALLChuyenXe())
            {
                if (cx.TgKhoiHanh.Date == DateTime.Parse(date).Date && cx.MaTuyenXe == MaTuyen) l.Add(cx);
            }
           
            return l;
        }
       
        public List<ChuyenXe> GetALLChuyenXeByTuyenXe(int MaTuyen)
        {
            List<ChuyenXe> l = new List<ChuyenXe>();
           foreach (ChuyenXe item in ChuyenXeDAL.Instance.GetALLCX())
            {
                if (item.MaTuyenXe == MaTuyen)
                {
                    l.Add(item);
                }
            }
            return l;
        }
        public List<ChuyenXe> GetALLChuyenXeByMaTaiXe(int id)
        {
            List<ChuyenXe> l = new List<ChuyenXe>();
            foreach (ChuyenXe item in ChuyenXeDAL.Instance.GetALLCX())
            {
                if (item.MaTaiXe == id)
                {
                    l.Add(item);
                }
            }
            return l;
        }
        public List<ChuyenXe> GetALLChuyenXeByMaTaiXeaddDate(int id, DateTime d)
        {
            List<ChuyenXe> l = new List<ChuyenXe>();
            foreach (ChuyenXe item in ChuyenXeDAL.Instance.GetALLCX())
            {
                if (item.MaTaiXe == id&&item.TgKhoiHanh.Date==d)
                {
                    l.Add(item);
                }
            }
            return l;
        }
        public ChuyenXe GetChuyenXeByMaCX(int MaCX)
        {
            List<ChuyenXe> l = ChuyenXeDAL.Instance.GetALLCX();
            foreach (ChuyenXe item in l)
            {
                if (item.MaCx == MaCX)
                {

                    return item;
                }
            }


            return null;
        }
        public bool InsertChuyenXe(ChuyenXe cx)
        {
            if (cx.Price < 0) throw new Exception("Giá vé không thể âm!");
            return ChuyenXeDAL.Instance.InsertChuyenXe(cx);
        }

        public bool UpdateChuyenXe(ChuyenXe cx)
        {
            if (cx.Price < 0) throw new Exception("Giá vé không thể âm!");
            return ChuyenXeDAL.Instance.UpdateChuyenXe(cx);
        }

        public bool DeleteChuyenXe(int maCx)
        {
            return ChuyenXeDAL.Instance.DeleteChuyenXe(maCx);
        }

        public List<ChuyenXe> SearchChuyenXe(string maTuyenXe)
        {
            return ChuyenXeDAL.Instance.SearchChuyenXe(maTuyenXe);
        }

        //hàm tự động cập nhật trạng thái chuyến xe mỗi 1p
        private static Timer _timer;
        public static void Start()
        {
            
            _timer = new Timer(autoUpdateTrangThai, null, TimeSpan.Zero, TimeSpan.FromMinutes(1));
        }


        public static void autoUpdateTrangThai(object state) 
        {
            List<ChuyenXe> cxs = ChuyenXeBLL.Instance.GetALLChuyenXe();
            foreach (var cx in cxs)
            {
                int count = 0;
                if (cx.TgKhoiHanh <= DateTime.Now && cx.TgDen > DateTime.Now)
                {
                    cx.TrangThai = "DangChay";
                    count++;
                }
                else if (cx.TgDen <= DateTime.Now)
                {
                    cx.TrangThai = "DaChay";
                    count++;
                }
                if (count > 0)
                {
                    ChuyenXeDAL.Instance.UpdateChuyenXe(cx);
                }
            }
        }

    }
}