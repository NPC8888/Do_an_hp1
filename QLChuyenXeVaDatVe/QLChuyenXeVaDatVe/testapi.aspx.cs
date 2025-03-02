using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace QLChuyenXeVaDatVe
{
    public partial class testapi : System.Web.UI.Page
    {
        private static readonly string apiUrl = "https://my.sepay.vn/userapi/transactions/list";
        private static readonly string apiToken = "ZGCBSTFOZZ2YASMGIENPDKW7EQKRAFBCTXDYHW8EBCB9HMMRKOVHSDYV01N9M7P8"; // Thay bằng API Token thật

        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                await XacThucThanhToan(2000.00, "DH102969"); // Kiểm tra giao dịch
            }
        }

        private async Task XacThucThanhToan(double soTien, string noiDungChuyenKhoan)
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
                        lbl1.Text = "✅ Giao dịch hợp lệ!";
                        return;
                    }
                }

                lbl1.Text = "❌ Không tìm thấy giao dịch hợp lệ.";
            }
            else
            {
                lbl1.Text = "❌ Lỗi API hoặc không có giao dịch.";
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

