using QLChuyenXeVaDatVe.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLChuyenXeVaDatVe.BLL
{
    public class ThanhToanBLL
    {
        //kh trung voi nhau
        public static string Magiaodichtamthoi()
            {
                return Guid.NewGuid().ToString("N").Substring(0, 10).ToUpper();
            }
        
        public List<ThanhToan> GetAllThanhToan()
        {
            return ThanhToanDAL.Instance.GetAllThanhToan();
        }

        public bool InsertThanhToan(ThanhToan thanhToan)
        {
            return ThanhToanDAL.Instance.InsertThanhToan(thanhToan);
        }

        public bool UpdateTrangThaiThanhToan(int maThanhToan, string trangThai)
        {
            return ThanhToanDAL.Instance.UpdateTrangThaiThanhToan(maThanhToan, trangThai);
        }
    }
}