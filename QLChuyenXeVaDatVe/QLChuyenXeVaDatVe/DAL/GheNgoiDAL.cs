using DAL;
using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace DAL
{
    public class GheNgoiDAL
    {
        private static GheNgoiDAL instance;

        public static GheNgoiDAL Instance
        {
            get { if (instance == null) instance = new GheNgoiDAL(); return GheNgoiDAL.instance; }
            private set => instance = value;
        }
        public static List<GheNgoi> listChoNgoiDaDat = new List<GheNgoi>();
        private GheNgoiDAL() { }
        public int insertGheNgoi(GheNgoi ghe)
        {
            string query = string.Format(
    "INSERT INTO GheNgoi (MaChuyenXe, SoGhe, DaDat, ThoiGianDat) " +
    "VALUES ({0}, {1}, {2}, '{3}'); SELECT SCOPE_IDENTITY();",
    ghe.MaChuyenXe,
    ghe.SoGhe,
    ghe.DaDat,

    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")
);

            // Sử dụng ExecuteScalar để lấy giá trị của SCOPE_IDENTITY()
            object result = DataProvider.Instance.ExecuteScalar(query);
            int newGheId = Convert.ToInt32(result);
            return newGheId;


        }
        public int DeleteGheNgoiById(string Id)
        {
            
            string query = "Delete from GheNgoi where MaGhe= "+Id;
            int i=DataProvider.Instance.ExecuteNonQuery(query);
            return i;
        }


        public List<GheNgoi> GetListGheNgoibyIdNguoiDung(string id)
        {
            List<GheNgoi> list = new List<GheNgoi>();
            string query = "SELECT * FROM GheNgoi WHERE MaNguoiDung = @MaNguoiDung";
            DataTable data = DataProvider.Instance.ExecuteQuery(query, new object[] { id });

            foreach (DataRow item in data.Rows)
            {
                GheNgoi ghe = new GheNgoi(item);
                list.Add(ghe);
            }

            return list;
        }
        public List<GheNgoi> GetALL()
        {
            List<GheNgoi> list = new List<GheNgoi>();
            string query = "SELECT * FROM GheNgoi";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                GheNgoi ghe = new GheNgoi(item);
                list.Add(ghe);
            }
            return list;
        }
        public List<GheNgoi> GetListGheNgoibyId(string id)
        {
            List<GheNgoi> list = new List<GheNgoi>();
            string query = "SELECT * FROM GheNgoi WHERE MaChuyenXe = @MaChuyenXe";
            DataTable data = DataProvider.Instance.ExecuteQuery(query, new object[] { id });

            foreach (DataRow item in data.Rows)
            {
                GheNgoi ghe = new GheNgoi(item);
                list.Add(ghe);
            }

            return list;
        }



    }
}