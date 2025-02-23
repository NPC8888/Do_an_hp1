using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Models;

namespace DAL
{
    public class DiemDonTraKhachDAL
    {
        private static DiemDonTraKhachDAL instance;

        public static DiemDonTraKhachDAL Instance
        {
            get { if (instance == null) instance = new DiemDonTraKhachDAL(); return DiemDonTraKhachDAL.instance; }
            private set => instance = value;
        }
        
        public List<DiemDonTraKhach> GetlisDiemDonByIdtuyenXe(int id)
        {
            List<DiemDonTraKhach> diem=new List<DiemDonTraKhach>();
            string query = string.Format("Select *from DiemDonTraKhach where MaTuyenXe = {0} and LoaiDiem='Don'", id);
            DataTable dataTable=DataProvider.Instance.ExecuteQuery(query, null);
            foreach(DataRow row in dataTable.Rows)  {
                DiemDonTraKhach diemDonTraKhach = new DiemDonTraKhach(row);
                diem.Add(diemDonTraKhach);

                
            }
            return diem;

        }
        public List<DiemDonTraKhach> GetlisDiemTraByIdtuyenXe(int id)
        {
            List<DiemDonTraKhach> diem = new List<DiemDonTraKhach>();
            string query = string.Format("Select *from DiemDonTraKhach where MaTuyenXe = {0} and LoaiDiem='Tra'", id);
            DataTable dataTable = DataProvider.Instance.ExecuteQuery(query, null);
            foreach (DataRow row in dataTable.Rows)
            {
                DiemDonTraKhach diemDonTraKhach = new DiemDonTraKhach(row);
                diem.Add(diemDonTraKhach);


            }
            return diem;

        }

    }
}