using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using xediep.Models;

namespace xediep.DAL
{
    public class TuyenXeDAL
    {
        private static TuyenXeDAL instance;

        public static TuyenXeDAL Instance
        {
            get { if (instance == null) instance = new TuyenXeDAL(); return instance; }
            private set => instance = value;
        }

        private TuyenXeDAL() { }

        public List<TuyenXe> GetAllTuyenXe()
        {
            List<TuyenXe> tuyenXes = new List<TuyenXe>();
            string query = "SELECT * FROM TuyenXe";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                TuyenXe tuyenXe = new TuyenXe(item);
                tuyenXes.Add(tuyenXe);
            }

            return tuyenXes;
        }
     
        public (string DiemDi, string DiemDen) GetDiemDiDiemDenFromMaTuyenXe(int maTuyenXe)
        {
            string query = string.Format("SELECT DiemDi, DiemDen FROM TuyenXe WHERE MaTuyenXe = {0}", maTuyenXe);
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            if (data.Rows.Count > 0)
            {
                string diemDi = data.Rows[0]["DiemDi"].ToString();
                string diemDen = data.Rows[0]["DiemDen"].ToString();
                return (diemDi, diemDen);
            }
            else
            {
                return (null, null); // Nếu không tìm thấy, trả về giá trị null
            }
        }
        public int GetMaTuyenXe(string diemDi, string diemDen)
        {
            string query = string.Format("SELECT MaTuyenXe FROM TuyenXe WHERE DiemDi = N'{0}' AND DiemDen = N'{1}'", diemDi, diemDen);
            object result = DataProvider.Instance.ExecuteScalar(query);
            return result != null ? Convert.ToInt32(result) : -1;
        }
        public bool InsertTuyenXe(TuyenXe Tuyen)
        {
            string query = string.Format("INSERT INTO TuyenXe (DiemDi, DiemDen, TrangThai) VALUES (N'{0}', N'{1}', N'{2}')",Tuyen.DiemDi,Tuyen.DiemDen,Tuyen.TrangThai);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool UpdateTuyenXe(TuyenXe Tuyen)
        {
            string query = string.Format("UPDATE TuyenXe SET DiemDi = N'{0}', DiemDen = N'{1}', TrangThai = '{2}' WHERE MaTuyenXe = {3}",Tuyen.DiemDi, Tuyen.DiemDen, Tuyen.TrangThai,Tuyen.MaTuyenXe);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool DeleteTuyenXe(int maXe)
        {
            string query = "DELETE FROM TuyenXe WHERE MaXe = " + maXe;
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { maXe });
            return result > 0;
        }
    }



    public class BaoCaoDAL
    {
        private static BaoCaoDAL instance;

        public static BaoCaoDAL Instance
        {
            get { if (instance == null) instance = new BaoCaoDAL(); return instance; }
            private set => instance = value;
        }

        private BaoCaoDAL() { }

        public List<BaoCao> GetAllBaoCao()
        {
            List<BaoCao> baoCaos = new List<BaoCao>();
            string query = "SELECT * FROM BaoCao";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                BaoCao baoCao = new BaoCao(item);
                baoCaos.Add(baoCao);
            }

            return baoCaos;
        }
        
    }
}

