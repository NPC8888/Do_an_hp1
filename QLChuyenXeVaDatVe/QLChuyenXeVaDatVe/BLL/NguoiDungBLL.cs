using System;
using System.Collections.Generic;
using System.Data;
using DAL;
using Models;

namespace BLL
{
    public class NguoiDungBLL
    {
        private static NguoiDungBLL instance;

        public static NguoiDungBLL Instance
        {
            get { if (instance == null) instance = new NguoiDungBLL(); return NguoiDungBLL.instance; }
            private set => instance = value;
        }
        private NguoiDungDAL userDal = new NguoiDungDAL();

        public string Login(string username, string password)
        {
            
            int userId = userDal.CheckLogin(username, password);

            if (userId > 0)
            {
                string token = Guid.NewGuid().ToString();
                DateTime expiry = DateTime.Now.AddHours(1);
                userDal.UpdateToken(userId, token, expiry);
                return token;
            }

            return null; // Đăng nhập thất bại
        }

        public bool ValidateToken(string token)
        {
            int userId = userDal.ValidateToken(token);
            return userId > 0;
        }
        public DataRow AuthenticateByToken(string token)
        {
            DataTable dt = DataProvider.Instance.GetUserByToken(token);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]; // Trả về dòng đầu tiên (nếu token hợp lệ)
            }
            return null;
        }
        public void Logout(string token)
        {
            userDal.ClearToken(token);
        }
        public void FixProfile(string id, string ten, string sdt, string email)
        {
            userDal.FixProfile(id, ten, sdt, email);
        }

      public List<NguoiDung> GetAllTaiXe()
        {
            return NguoiDungDAL.Instance.GetAllTaiXe();
        }
        public List<NguoiDung> GetAll()
        {
            return NguoiDungDAL.Instance.GetAll();
        }
    }
}
