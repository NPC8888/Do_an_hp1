using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;

namespace BLL
{
    public class XacThucThanhToanBLL
    {
        public XacThucThanhToanBLL() { }
        private static readonly string apiUrl = "https://my.sepay.vn/userapi/transactions/list";
        private static readonly string apiToken = "ZGCBSTFOZZ2YASMGIENPDKW7EQKRAFBCTXDYHW8EBCB9HMMRKOVHSDYV01N9M7P8"; // Thay bằng API Token thật

        public static async Task<int> LapKiemTraThanhToan(double soTien, string noiDungChuyenKhoan, int soPhut)
        {
            XacThucThanhToanBLL thanhToanBLL = new XacThucThanhToanBLL();
            int tongSoLanLap = (soPhut * 60) / 2; // Số lần kiểm tra trong 5 phút (mỗi 2 giây)

            for (int i = 0; i < tongSoLanLap; i++)
            {
                string ketQua = await thanhToanBLL.XacThucThanhToan(soTien, noiDungChuyenKhoan);
                Console.WriteLine($"[{DateTime.Now:HH:mm:ss}] Kiểm tra lần {i + 1}: {ketQua}");

                if (ketQua == "thanhcong")
                {
                    Console.WriteLine("✅ Thanh toán thành công! Dừng kiểm tra.");
                    return 1;
                }

                await Task.Delay(2000); // Chờ 2 giây trước lần kiểm tra tiếp theo
            }
            return 0;
        }
        public async Task<string> XacThucThanhToan(double soTien, string noiDungChuyenKhoan)
        {
            try
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
            catch(Exception ex)
            {
                return "loi"+ ex.Message;
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
