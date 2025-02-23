using Newtonsoft.Json.Linq;
using System;
using System.Data;
using System.Web;

namespace DAL
{
    public class NguoiDungDAL
    {
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
        public void FixProfile(string id,string ten,string sdt,string email)
        {   int Id=int.Parse(id);
           string query=string.Format("UPDATE NguoiDung SET HoTen = N'{0}' , SoDienThoai = '{1}' , Email = '{2}' WHERE MaNguoiDung = {3}",ten,sdt,email,id);
            

            int i=DataProvider.Instance.ExecuteNonQuery(query);
        
           
        }
    }
}
