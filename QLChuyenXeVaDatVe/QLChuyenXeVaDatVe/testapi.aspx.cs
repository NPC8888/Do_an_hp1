﻿using System;
using System.Diagnostics;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Services;
using BLL;
using Newtonsoft.Json;

namespace QLChuyenXeVaDatVe
{
    public partial class testapi : System.Web.UI.Page
    {
       
        protected  void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra giao dịch
                
                
            }
        }
        private static readonly string apiUrl = "https://my.sepay.vn/userapi/transactions/list";
        private static readonly string apiToken = "ZGCBSTFOZZ2YASMGIENPDKW7EQKRAFBCTXDYHW8EBCB9HMMRKOVHSDYV01N9M7P8"; // Thay bằng API Token thật

        public  async Task LapKiemTraThanhToan(double soTien, string noiDungChuyenKhoan, int soPhut)
        {
            XacThucThanhToanBLL thanhToanBLL = new XacThucThanhToanBLL();
            int tongSoLanLap = (soPhut * 60) / 2; // Số lần kiểm tra trong 5 phút (mỗi 2 giây)

            for (int i = 0; i < tongSoLanLap; i++)
            {
                string ketQua = await thanhToanBLL.XacThucThanhToan(soTien, noiDungChuyenKhoan);
                Debug.WriteLine($"[{DateTime.Now:HH:mm:ss}] Kiểm tra lần {i + 1}: {ketQua}");

                if (ketQua == "thanhcong")
                {
                    Debug.WriteLine("✅ Thanh toán thành công! Dừng kiểm tra.");
                    lbl1.Text = "✅ Thanh toán thành công! Dừng kiểm tra.";
                    break;
                }

                await Task.Delay(2000); // Chờ 2 giây trước lần kiểm tra tiếp theo
            }
        }
        public async Task<string> XacThucThanhToan(double soTien, string noiDungChuyenKhoan)
        {
            string response = await GetTransactions();
            dynamic jsonResponse = JsonConvert.DeserializeObject(response);

            if (jsonResponse.status == 200 && jsonResponse.transactions.Count > 0)
            {
                foreach (var transaction in jsonResponse.transactions)
                {
                    // Kiểm tra số tiền và nội dung giao dịch có khớp không
                    if (transaction.amount_in == soTien.ToString("0.00") &&
                       transaction.transaction_content.ToString().Contains(noiDungChuyenKhoan))
                    {
                        return "thanhcong";
                    }
                }
                return "khongthanhcong";
            }
            else
            {
                return "loi";
            }
        }

        private static async Task<string> GetTransactions()
        {
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", $"Bearer {apiToken}");

                try
                {
                    HttpResponseMessage response = await client.GetAsync(apiUrl);
                    return await response.Content.ReadAsStringAsync();
                }
                catch (Exception ex)
                {
                    return $"Lỗi: {ex.Message}";
                }
            }
        }



    }
}


