using Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using xediep.Models;

namespace DAL
{
    public class NguoiDungDAL
    {
        private static NguoiDungDAL instance;

        public static NguoiDungDAL Instance
        {
            get { if (instance == null) instance = new NguoiDungDAL(); return NguoiDungDAL.instance; }
            private set => instance = value;
        }
        // Kiểm tra thông tin đăng nhập
        public int CheckLogin(string username, string passwordHash)
        {
            string query = "SELECT MaNguoiDung FROM NguoiDung WHERE TenDangNhap = @Username AND MatKhau = @PasswordHash";
            object[] parameters = { username, passwordHash };

            DataTable dt = DataProvider.Instance.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                return Convert.ToInt32(dt.Rows[0]["MaNguoiDung"]);
            }
            return -1; // Đăng nhập thất bại
        }

        // Cập nhật token
        public void UpdateToken(int userId, string token, DateTime expiry)
        {
            string query = "UPDATE NguoiDung SET Token = @Token , TokenExpiry = @Expiry WHERE MaNguoiDung = @UserID";
            object[] parameters = { token, expiry, userId };

            DataProvider.Instance.ExecuteNonQuery(query, parameters);
        }

        // Xác thực token
        public int ValidateToken(string token)
        {
            string query = "SELECT MaNguoiDung FROM NguoiDung WHERE Token = @Token AND TokenExpiry > @Now";
            object[] parameters = { token, DateTime.Now };

            DataTable dt = DataProvider.Instance.ExecuteQuery(query, parameters);

            if (dt.Rows.Count > 0)
            {
                return Convert.ToInt32(dt.Rows[0]["MaNguoiDung"]);
            }
            return -1; // Token không hợp lệ hoặc hết hạn
        }


        // Xóa token (khi đăng xuất)
        public void ClearToken(string token)
        {
            string query = "UPDATE NguoiDung SET Token = NULL, TokenExpiry = NULL WHERE Token = @Token";
            object[] parameters = { token };

            DataProvider.Instance.ExecuteNonQuery(query, parameters);
        }
        public void FixProfile(string id, string ten, string sdt, string email)
        {
            int Id = int.Parse(id);
            string query = string.Format("UPDATE NguoiDung SET HoTen = N'{0}' , SoDienThoai = '{1}' , Email = '{2}' WHERE MaNguoiDung = {3}", ten, sdt, email, id);


            int i = DataProvider.Instance.ExecuteNonQuery(query);


        }
        public List<NguoiDung> GetAllTaiXe()
        {
            List<NguoiDung> nd = new List<NguoiDung>();
            string query = "SELECT * FROM NguoiDung where VaiTro='TaiXe'";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                NguoiDung nguoidung = new NguoiDung(item);
                nd.Add(nguoidung);
            }

            return nd;
        }
        public List<NguoiDung> GetAll()
        {
            List<NguoiDung> nd = new List<NguoiDung>();
            string query = "SELECT * FROM NguoiDung";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                NguoiDung nguoidung = new NguoiDung(item);
                nd.Add(nguoidung);
            }

            return nd;
        }


        //them sua xoa
        public bool InsertNguoiDung(NguoiDung nguoiDung )
        {
            string query = string.Format("INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, SoDienThoai, Email, VaiTro) VALUES (N'{0}', N'{1}', N'{2}', N'{3}', N'{4}', N'{5}')", nguoiDung.TenDangNhap, nguoiDung.MatKhau, nguoiDung.HoTen, nguoiDung.SDT, nguoiDung.EMai, nguoiDung.VaiTro);
            
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool UpdateNguoiDung(NguoiDung nd)
        {
            string query = string.Format("UPDATE NguoiDung SET TenDangNhap = '{0}', MatKhau = N'{1}', HoTen = '{2}',  SoDienThoai={3}, Email='{4}', VaiTro='{5}' WHERE MaNguoiDung = {6} ", nd.TenDangNhap,nd.MatKhau,nd.HoTen,nd.SDT,nd.EMai,nd.VaiTro,nd.MaNguoiDung);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool DeleteNguoiDung(int nd)
        {
            string query = "DELETE FROM NguoiDung WHERE MaNguoiDung = " + nd.ToString();
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { nd });
            return result > 0;
        }
    }
}
    

    
