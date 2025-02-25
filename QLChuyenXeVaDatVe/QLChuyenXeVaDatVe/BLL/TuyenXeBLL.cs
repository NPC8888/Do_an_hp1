using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using xediep.BLL.BLL;
using xediep.DAL;
using xediep.Models;

namespace xediep.BLL
{
    public class TuyenXeBLL
    {
        private static TuyenXeBLL instance;

        public static TuyenXeBLL Instance
        {
            get { if (instance == null) instance = new TuyenXeBLL(); return TuyenXeBLL.instance; }
            private set => instance = value;
        }
        public int GetMaTuyenXeByDiemDiDiemDen(string diemdi,string diemden)
        {
            int i=TuyenXeDAL.Instance.GetMaTuyenXe(diemdi,diemden);
            return i;
        }
        public (string DiemDi, string DiemDen) GetDiemDiDiemDenFromMaTuyenXe(int maTuyenXe)
        {
            return TuyenXeDAL.Instance.GetDiemDiDiemDenFromMaTuyenXe(maTuyenXe);
        }

        public List<TuyenXe> GetALLTuyenXe()
        {
            return TuyenXeDAL.Instance.GetAllTuyenXe();
        }
        public bool AddTuyenXe(TuyenXe xe)
        {
            return TuyenXeDAL.Instance.InsertTuyenXe(xe);
        }

        public bool EditTuyenXe(TuyenXe xe)
        {
            return TuyenXeDAL.Instance.UpdateTuyenXe(xe);
        }

        public bool RemoveTuyenXe(int maXe)
        {
            return TuyenXeDAL.Instance.DeleteTuyenXe(maXe);
        }
    }
}