<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListChuyenXe.ascx.cs" Inherits="xediep.webControl.ListChuyenXe" %>

<% if (lchuyenxe != null && lchuyenxe.Count > 0)
    { %>
<% for (int i = 0; i < lchuyenxe.Count; i++)
    { %>
<div class="khung-xe">
    <div class="noi-dung">
        <div class="tieu-de">
            🚌 Tổng Thời Gian Chuyến Đi: 
    <%= (lchuyenxe[i].TgDen - lchuyenxe[i].TgKhoiHanh).Hours %>h
    <%= (lchuyenxe[i].TgDen - lchuyenxe[i].TgKhoiHanh).Minutes %>'
        </div>
        <div class="thong-tin"><%=xediep.BLL.BLL.XeKhachBLL.Instance.GetXeKhachByMaXe(lchuyenxe[i].MaXe).LoaiXe %></div>
        <div class="thong-tin">⏰ <b><%= lchuyenxe[i].TgKhoiHanh.Hour.ToString()+":"+lchuyenxe[i].TgKhoiHanh.Minute.ToString() %></b> • <%=LayDiemDiDiemDenByMaTuyenXe(lchuyenxe[i].MaTuyenXe.ToString()).DiemDon %></div>
        <div class="thong-tin">📍 <b><%= lchuyenxe[i].TgDen.Hour.ToString()+":"+lchuyenxe[i].TgDen.Minute.ToString() %></b> • <%=LayDiemDiDiemDenByMaTuyenXe(lchuyenxe[i].MaTuyenXe.ToString()).DiemDen %></div>
    </div>
    <div>
        <div class="gia-ve"><%=lchuyenxe[i].Price.ToString()+":VND" %></div>
        <a class="nut-chon" href="DatVe.aspx?id=<%= lchuyenxe[i].MaCx %>">Chọn chỗ</a>
        <button class="nut-chon" type="button" onclick="showDanhGia('<%= lchuyenxe[i].MaCx %>')">📢 Xem đánh giá</button>
    </div>
</div>
<div id="divDanhGia<%= lchuyenxe[i].MaCx %>" class="review-container">
    <%  
        var danhSachDanhGia = BLL.DanhGiaBLL.Instance.GetDanhGiaByMaCX(lchuyenxe[i].MaXe);
        for (int j = 0; j < danhSachDanhGia.Count(); j++)
        {
            var danhGia = danhSachDanhGia[j];
    %>
    <div class="review-item">
        <div class="review-avatar">
            <img src="../jpg/user.png" alt="User Avatar">
        </div>
        <div class="review-content">
            <div class="review-name"> <%=BLL.NguoiDungBLL.Instance.GetNguoiDungByMaND(danhGia.MaNguoiDung).HoTen %></div>
            <div class="review-stars">
                <% for (int s = 0; s < danhGia.DiemDanhGia; s++)
                    { %>
                    ⭐
                <% } %>
            </div>
            <div class="review-text"><%= danhGia.BinhLuan %></div>
            <div class="review-time">Ngày đánh giá:20/10 </div>
        </div>
    </div>
    <% } %>
</div>


<% } %>
<% }
    else
    { %>
<p>Không có chuyến xe ngày <%=Session["DateSh"] %>!</p>
<% } %>
<style>
    .review-container {
        display: none;
        background-color: rgba(230, 230, 230, 0.5);
    }

    * {
        color: black;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: Arial, sans-serif;
    }

    .khung-xe {
        display: flex;
        align-items: center;
        width: 100%;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px;
        background-color: rgba(200, 200, 200, 0.5);
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        gap: 15px;
    }

    .noi-dung {
        flex: 1;
    }

    .tieu-de {
        font-size: 16px;
        font-weight: bold;
        color: #333;
    }

    .thong-tin {
        font-size: 14px;
        color: #555;
        margin: 5px 0;
    }

    .gia-ve {
        font-size: 18px;
        font-weight: bold;
        color: #000;
    }

    .so-ghe {
        font-size: 14px;
        color: #777;
    }

    .nut-chon {
        padding: 5px 10px;
        font-size: 14px;
        border: 1px solid #333;
        border-radius: 5px;
        background: white;
        cursor: pointer;
        transition: 0.3s;
        color: black;
    }

        .nut-chon:hover {
            background: #ddd;
        }

    .review-container {
        width: 100%;
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .review-item {
        display: flex;
        align-items: flex-start;
        padding: 15px;
        border-bottom: 1px solid #ddd;
    }

        .review-item:last-child {
            border-bottom: none;
        }

    .review-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        overflow: hidden;
        margin-right: 15px;
    }

        .review-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

    .review-content {
        flex-grow: 1;
    }

    .review-name {
        font-weight: bold;
        color: #333;
    }

    .review-stars {
        color: #f8b400;
        font-size: 14px;
    }

    .review-text {
        margin-top: 5px;
        color: #555;
    }

    .review-time {
        font-size: 12px;
        color: #888;
        margin-top: 5px;
    }
</style>


<script>
    function showDanhGia(id) {
        let reviewDiv = document.getElementById("divDanhGia" + id);
        if (reviewDiv.style.display === "block") {
            reviewDiv.style.display = "none";
        } else {
            reviewDiv.style.display = "block";
        }
    }
</script>
