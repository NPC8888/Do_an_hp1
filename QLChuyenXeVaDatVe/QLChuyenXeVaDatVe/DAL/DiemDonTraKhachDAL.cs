using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Models;
using xediep.Models;

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
        public List<DiemDonTraKhach> GetALLDiemDonTra()
        {
            List<DiemDonTraKhach> diem = new List<DiemDonTraKhach>();
            string query = string.Format("Select *from DiemDonTraKhach");
            DataTable dataTable = DataProvider.Instance.ExecuteQuery(query, null);
            foreach (DataRow row in dataTable.Rows)
            {
                DiemDonTraKhach diemDonTraKhach = new DiemDonTraKhach(row);
                diem.Add(diemDonTraKhach);


            }
            return diem;

        }

        public List<DiemDonTraKhach> GetlisDiemDonByIdtuyenXe(int id)
        {
            List<DiemDonTraKhach> diem=new List<DiemDonTraKhach>();
            string query = string.Format("Select *from DiemDonTraKhach where MaTuyenXe = {0} and LoaiDiem='DD'", id);
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
            string query = string.Format("Select *from DiemDonTraKhach where MaTuyenXe = {0} and LoaiDiem='DT'", id);
            DataTable dataTable = DataProvider.Instance.ExecuteQuery(query, null);
            foreach (DataRow row in dataTable.Rows)
            {
                DiemDonTraKhach diemDonTraKhach = new DiemDonTraKhach(row);
                diem.Add(diemDonTraKhach);


            }
            return diem;

        }
        public bool InsertDiemDonTraKhach(DiemDonTraKhach DiemDonTraKhach)
        {
            string query = string.Format("INSERT INTO DiemDonTraKhach (MaTuyenXe, TenDiem, DiaChi , LoaiDiem) VALUES ({0}, N'{1}', N'{2}','{3}' )", DiemDonTraKhach.MaTuyenXe,DiemDonTraKhach.TenDiem,DiemDonTraKhach.DiaChi,DiemDonTraKhach.LoaiDiem);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool UpdateDiemDonTraKhach(DiemDonTraKhach DiemDonTraKhach)
        {
            string query = string.Format("UPDATE DiemDonTraKhach SET MaTuyenXe ={0}, TenDiem= N'{1}', DiaChi= N'{2}' , LoaiDiem=N'{3}' Where IDDiem={4} ", DiemDonTraKhach.MaTuyenXe, DiemDonTraKhach.TenDiem, DiemDonTraKhach.DiaChi, DiemDonTraKhach.LoaiDiem,DiemDonTraKhach.MaDiem);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool DeleteDiemDonTraKhach(int Ma)
        {
            string query = "DELETE FROM DiemDonTraKhach WHERE IDDiem = " + Ma;
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { Ma });
            return result > 0;
        }





    }
}