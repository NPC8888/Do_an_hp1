using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QLChuyenXeVaDatVe.DAL.DataSet1TableAdapters;
namespace DAL
{
    public class DataProvider
    {
        private static DataProvider instance;
        public static DataProvider Instance
        {
            get { if (instance == null) instance = new DataProvider(); return DataProvider.instance; }
            private set => instance = value;
        }

        public DataProvider() { }


        private string connectionSTR = @"Data Source=LAPTOP-3B68DA7A\SQLEXPRESS;Initial Catalog=QLChuyenXe;Integrated Security=True;Timeout=100;";


        public DataTable ExecuteQuery(string query, object[] parameter = null)
        {
            DataTable dt = new DataTable();

            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameter != null)
                    {
                        string[] listPara = query.Split(' ');
                        int i = 0;
                        foreach (string s in listPara)
                        {
                            if (s.Contains('@'))
                            {
                                command.Parameters.AddWithValue(s, parameter[i]);
                                i++;
                            }
                        }
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dt);
                    }
                }
            }

            return dt;
        }


        public int ExecuteNonQuery(string query, object[] parameter = null)
        {
            int dt = 0;

            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                connection.Open();

                SqlCommand command = new SqlCommand(query, connection);


                if (parameter != null)
                {
                    string[] listPara = query.Split(' ');
                    int i = 0;
                    foreach (string s in listPara)
                    {
                        if (s.Contains('@'))
                        {
                            command.Parameters.AddWithValue(s, parameter[i]);
                            i++;
                        }
                    }
                }
                dt = command.ExecuteNonQuery();
                connection.Close();
            }
            return dt;
        }
        public DataTable GetUserByToken(string token)
        {
            string query = "SELECT * FROM NguoiDung WHERE Token = @Token";
            return ExecuteQuery(query, new object[] { token });

        }

        public object ExecuteScalar(string query, object[] parameters = null)
        {
            object result = null;
            using (SqlConnection connection = new SqlConnection(connectionSTR))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        // Giả sử bạn thêm các parameter theo thứ tự
                        for (int i = 0; i < parameters.Length; i++)
                        {
                            // Đặt tên parameter theo dạng @param0, @param1, v.v.
                            command.Parameters.AddWithValue("@param" + i, parameters[i]);
                        }
                    }
                    connection.Open();
                    result = command.ExecuteScalar();
                    connection.Close();
                }
            }
            return result;
        }



    }


    


    
}
