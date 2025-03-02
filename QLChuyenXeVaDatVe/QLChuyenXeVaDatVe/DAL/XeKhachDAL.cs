using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using xediep.Models;

public class XeKhachDAL
{
    private static XeKhachDAL instance;

    public static XeKhachDAL Instance
    {
        get { if (instance == null) instance = new XeKhachDAL(); return instance; }
        private set => instance = value;
    }

    public XeKhachDAL() { }
    //get
    public XeKhach XeKhachByMaXe(int maXe)
    {
        string query = "SELECT * FROM XeKhach WHERE MaXe = " + maXe;
        DataTable data = DataProvider.Instance.ExecuteQuery(query);
        foreach (DataRow item in data.Rows)
        {
            return new XeKhach(item);
        }
        return null;
    }
    public List<XeKhach> GetAllXeKhach()
    {
        List<XeKhach> xeKhachs = new List<XeKhach>();
        string query = "SELECT * FROM XeKhach";
        DataTable data = DataProvider.Instance.ExecuteQuery(query);

        foreach (DataRow item in data.Rows)
        {
            XeKhach xeKhach = new XeKhach(item);
            xeKhachs.Add(xeKhach);
        }

        return xeKhachs;
    }
  

    public bool InsertXeKhach(XeKhach xe)
    {
        string query = string.Format("INSERT INTO XeKhach (BienSoXe, LoaiXe, SoChoNgoi , SoTang, SoDay, SoGheMoiDay) VALUES ('{0}', N'{1}', {2}, {3}, {4}, {5})", xe.BienSoXe,xe.LoaiXe,xe.SoChoNgoi,xe.SoTang,xe.SoDay,xe.SoGheMoiDay);
        int result = DataProvider.Instance.ExecuteNonQuery(query);
        return result > 0; 
    }

    public bool UpdateXeKhach(XeKhach xe)
    {
        string query = string.Format("UPDATE XeKhach SET BienSoXe = '{0}', LoaiXe = N'{1}', SoChoNgoi = {2}, SoTang={3}, SoDay={4}, SoGheMoiDay={5} WHERE MaXe = {6}", xe.BienSoXe,xe.LoaiXe,xe.SoChoNgoi, xe.SoTang,xe.SoDay,xe.SoGheMoiDay, xe.MaXe);
        int result = DataProvider.Instance.ExecuteNonQuery(query);
        return result > 0;
    }

    public bool DeleteXeKhach(int maXe)
    {
        string query = "DELETE FROM XeKhach WHERE MaXe = "+maXe;
        int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { maXe });
        return result > 0;
    }
}
