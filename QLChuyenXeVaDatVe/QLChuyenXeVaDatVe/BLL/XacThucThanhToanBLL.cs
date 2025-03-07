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
