using BLL;
using Models;
using QLChuyenXeVaDatVe.DAL.DataSet1TableAdapters;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Script.Serialization;
using xediep.BLL;

namespace QLChuyenXeVaDatVe
{
    public partial class TTrangChu : System.Web.UI.Page
    {
        public NguoiDung ng = new NguoiDung();
        List<ChuyenXe> tuan = new List<ChuyenXe>();
        List<ChuyenXe> dachay = new List<ChuyenXe>();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                lblDate.Text = DateTime.Today.Date.ToString("dd/MM/yyyy"); // Hoặc "yyyy-MM-dd" tùy theo định dạng mong muốn
                Session["dateL"] = DateTime.Today.ToString("dd/MM/yyyy");
                litTimelineLeft.Text = RenderTimeline(0, 11);
                litTimelineRight.Text = RenderTimeline(12, 23);

            }
            ng = NguoiDungBLL.Instance.GetNguoiDungByMaND(int.Parse(Session["Role"].ToString()));
            loadNumbercxinWMonth();


        }
        void loadNumbercxinWMonth()
        {
            DateTime now = DateTime.Now;
            DateTime startOfWeek = now.Date.AddDays(-(int)now.DayOfWeek);



            int countWeek = 0, countend = 0;

            foreach (var cx in ChuyenXeBLL.Instance.GetALLChuyenXeByMaTaiXe(int.Parse(Session["Role"].ToString())))
            {
                if (cx.TgKhoiHanh >= startOfWeek) { countWeek++; tuan.Add(cx); }

                if (cx.TrangThai == "DaChay") { countend++; dachay.Add(cx); }
            }

            lblTuan.Text = countWeek.ToString();
            lblThang.Text = countend.ToString();
        }

        protected void divTuan_click(object sender, EventArgs e)
        {
            Session["listCX"] = tuan;
            Response.Redirect("TListChuyenXe.aspx");
        }
        protected void divDaChay_click(object sender, EventArgs e)
        {
            Session["listCX"] = dachay;
            Response.Redirect("TListChuyenXe.aspx");
        }
        protected void btnleft_click(object sender, EventArgs e)
        {
            if (DateTime.TryParseExact(Session["dateL"]?.ToString(), "dd/MM/yyyy",
    CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime dateTime))
            {
                dateTime = dateTime.AddDays(-1); // Hoặc +1 nếu là btnleft_click
                Session["dateL"] = lblDate.Text = dateTime.ToString("dd/MM/yyyy");
                lblDate.Text = dateTime.Date.ToString("dd/MM/yyyy");
                litTimelineLeft.Text = RenderTimeline(0, 11);
                litTimelineRight.Text = RenderTimeline(12, 23);
            }
        }
        protected void btnRight_click(object sender, EventArgs e)
        {
            if (DateTime.TryParseExact(Session["dateL"]?.ToString(), "dd/MM/yyyy",
     CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime dateTime))
            {
                dateTime = dateTime.AddDays(1); // Hoặc +1 nếu là btnleft_click
                Session["dateL"] = lblDate.Text = dateTime.ToString("dd/MM/yyyy");


                lblDate.Text = dateTime.Date.ToString("dd/MM/yyyy");
                litTimelineLeft.Text = RenderTimeline(0, 11);
                litTimelineRight.Text = RenderTimeline(12, 23);
            }
        }
        private string RenderTimeline(int startHour, int endHour)
        {
            DateTime dt = new DateTime();
            if (DateTime.TryParseExact(Session["dateL"]?.ToString(), "dd/MM/yyyy",
    CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime dateTime))
            {
                dt = dateTime;
            }
            else
            {
                dt = DateTime.Today.Date; // Gán ngày hiện tại nếu session không hợp lệ
            }

            List<ChuyenXe> cx = ChuyenXeBLL.Instance.GetALLChuyenXeByMaTaiXeaddDate(int.Parse(Session["Role"].ToString()), dt) ?? new List<ChuyenXe>();

            // Nếu không có chuyến nào, trả về chuỗi rỗng
            if (cx == null || cx.Count == 0)
            {
                return "<p>Không có chuyến xe nào</p>";
            }
            string html = "";
            for (int hour = startHour; hour <= endHour; hour++)
            {
                var List = cx.Where(e =>
                {
                    DateTime start = e.TgKhoiHanh;

                    return hour == start.Hour;
                }).ToList();

                if (List.Count > 0)
                {
                    html += "<div class='timeline-item'>";
                    html += "<strong>" + hour + ":00</strong>";


                    foreach (var evt in List)
                    {
                        int startHourEvent = evt.TgKhoiHanh.Hour;
                        int endHourEvent = evt.TgDen.Hour;
                        int duration = (endHourEvent - startHourEvent) * 50;

                        string eventClass = "event1";

                        html += $"<div class='event-bar {eventClass}' style='width: {duration * 2}px;max-width:100%;'>";
                        var t = TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(evt.MaTuyenXe);
                        html += t.DiemDi + "-" + t.DiemDen + " (" + evt.TgKhoiHanh.ToString("HH:mm") + " - " + evt.TgDen.ToString("HH:mm") + ")";
                        html += "</div>";
                    }

                    html += "</div>";
                }
            }
            return html;
        }



    }
}
