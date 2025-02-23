using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAL;
using Models;

namespace BLL
{
    public class DiemDonTraKhachBLL
    {
        private static DiemDonTraKhachBLL instance;

        public static DiemDonTraKhachBLL Instance
        {
            get { if (instance == null) instance = new DiemDonTraKhachBLL(); return DiemDonTraKhachBLL.instance; }
            private set => instance = value;
        }

        public List<DiemDonTraKhach> GetListDiemDonByIDtuyenXe(int id)
        {
            List<DiemDonTraKhach> diemDonKhaches=DiemDonTraKhachDAL.Instance.GetlisDiemDonByIdtuyenXe(id);
            return diemDonKhaches;
        }
        public List<DiemDonTraKhach> GetListDiemTraByIDtuyenXe(int id)
        {
            List<DiemDonTraKhach> diemTraKhaches = DiemDonTraKhachDAL.Instance.GetlisDiemTraByIdtuyenXe(id);
            return diemTraKhaches;
        }
    }
}