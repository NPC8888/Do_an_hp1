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

        public List<DiemDonTraKhach> GetListDiemDonByIDChuyenXe(int id)
        {
            List<DiemDonTraKhach> diemDonKhaches=DiemDonTraKhachDAL.Instance.GetlisDiemDonByIdChuyenXe(id);
            return diemDonKhaches;
        }
        public List<DiemDonTraKhach> GetListDiemTraByIDChuyenXe(int id)
        {
            List<DiemDonTraKhach> diemTraKhaches = DiemDonTraKhachDAL.Instance.GetlisDiemTraByIdChuyenXe(id);
            return diemTraKhaches;
        }
    }
}