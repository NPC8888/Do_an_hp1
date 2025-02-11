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
            get { if (instance == null) instance = new  GheNgoiDAL(); return GheNgoiDAL.instance; }
            private set => instance = value;
        }
        public static List<GheNgoi> listChoNgoiDaDat=new List<GheNgoi>();
        private GheNgoiDAL() { }
        public int insertGheNgoi(GheNgoi ghe)
        {
            string query = string.Format(
    "INSERT INTO GheNgoi (MaChuyenXe, SoGhe, DaDat, MaKhachHang, ThoiGianDat) " +
    "VALUES ({0}, {1}, {2}, {3}, '{4}'); SELECT SCOPE_IDENTITY();",
    ghe.MaChuyenXe,
    ghe.SoGhe,
    ghe.DaDat,
    ghe.MaKH,
    DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")
);

            // Sử dụng ExecuteScalar để lấy giá trị của SCOPE_IDENTITY()
            object result = DataProvider.Instance.ExecuteScalar(query);
            int newGheId = Convert.ToInt32(result);
            return newGheId;


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