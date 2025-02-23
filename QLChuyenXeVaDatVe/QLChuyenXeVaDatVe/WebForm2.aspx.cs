using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using Newtonsoft.Json;

namespace xediep
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        private static readonly string apiKey = "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"; // Thay bằng API Key của bạn

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void btnSend_Click(object sender, EventArgs e)
        {
            string userInput = txtInput.Text;
            string response = await GetOpenAIResponse(userInput);

            lblResponse.Text = response; // Hiển thị lỗi nếu có
        }



        public static async Task<string> GetOpenAIResponse(string prompt)
        {
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", $"Bearer {apiKey}");

                var requestBody = new
                {
                    model = "gpt-3.5-turbo", // Hoặc "gpt-3.5-turbo"
                    messages = new[]
                    {
                new { role = "system", content = "Bạn là một trợ lý AI." },
                new { role = "user", content = prompt }
            },
                    temperature = 0.7
                };

                string jsonBody = JsonConvert.SerializeObject(requestBody);
                StringContent content = new StringContent(jsonBody, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync("https://api.openai.com/v1/chat/completions", content);
                string responseJson = await response.Content.ReadAsStringAsync();

                // Ghi log phản hồi từ OpenAI
                Console.WriteLine("Response JSON: " + responseJson);

                if (string.IsNullOrEmpty(responseJson))
                {
                    return "Lỗi: API không trả về dữ liệu.";
                }

                try
                {
                    dynamic result = JsonConvert.DeserializeObject(responseJson);

                    // Ghi log phản hồi JSON để debug
                    Console.WriteLine("Parsed Response: " + JsonConvert.SerializeObject(result, Formatting.Indented));

                    if (result?.choices == null || result.choices.Count == 0)
                    {
                        return "Lỗi: Không có phản hồi từ OpenAI. JSON: " + responseJson;
                    }

                    return result.choices[0].message.content;
                }
                catch (Exception ex)
                {
                    return $"Lỗi xử lý JSON: {ex.Message}. JSON: {responseJson}";
                }
            }
        }


    }
}