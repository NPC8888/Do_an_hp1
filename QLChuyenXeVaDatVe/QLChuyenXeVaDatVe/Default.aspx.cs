using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using Newtonsoft.Json;

public partial class Default : Page
{
    private static readonly string apiKey = "YOUR_OPENAI_API_KEY"; // Thay bằng API Key của bạn

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected async void btnSend_Click(object sender, EventArgs e)
    {
        string userInput = .Text;
        string response = await GetOpenAIResponse(userInput);
        lblResponse.Text = response;
    }

    public static async Task<string> GetOpenAIResponse(string prompt)
    {
        using (HttpClient client = new HttpClient())
        {
            client.DefaultRequestHeaders.Add("Authorization", $"Bearer {apiKey}");

            var requestBody = new
            {
                model = "gpt-4", // hoặc "gpt-3.5-turbo"
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

            dynamic result = JsonConvert.DeserializeObject(responseJson);
            return result.choices[0].message.content;
        }
    }
}
