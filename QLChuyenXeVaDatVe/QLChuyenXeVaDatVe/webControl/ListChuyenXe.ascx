<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListChuyenXe.ascx.cs" Inherits="xediep.webControl.ListChuyenXe" %>

<div class="bus-ticket-container">
    <% if (lchuyenxe != null) { %>
        <% for (int i = 0; i < lchuyenxe.Count; i++) { %>
            <div class="bus-ticket-card">
                <div class="bus-header">
                    <p class="route">
                        <strong><%= LayDiemDiDiemDenByMaTuyenXe(lchuyenxe[i].MaTuyenXe.ToString()).DiemDon %></strong>
                        <span class="arrow">→</span>
                        <strong><%= LayDiemDiDiemDenByMaTuyenXe(lchuyenxe[i].MaTuyenXe.ToString()).DiemDen %></strong>
                    </p>
                </div>
                <div class="bus-info">
                    <p><strong>🕒 Giờ khởi hành:</strong> <%= lchuyenxe[i].TgKhoiHanh %></p>
                    <p><strong>🏁 Giờ đến:</strong> <%= lchuyenxe[i].TgDen %></p>
                    <p class="price"><strong>💰 Giá vé:</strong> <%= lchuyenxe[i].Price %> VND</p>
                </div>
                <div class="button-container">
                    <button class="btn-show-review" type="button" onclick="showDanhGia('<%= lchuyenxe[i].MaXe %>')">📢 Xem đánh giá</button>
                    <a class="btn-book-now" href="DatVe.aspx?id=<%= lchuyenxe[i].MaCx %>">🛒 Đặt vé ngay</a>
                </div>
                <div id="divDanhGia<%= lchuyenxe[i].MaXe %>" class="review-container">
                    <%for (int j = 0; j < BLL.DanhGiaBLL.Instance.GetDanhGiaByMaCX(lchuyenxe[i].MaXe).Count(); j++) { %>
                        <p>⭐ <%=BLL.DanhGiaBLL.Instance.GetDanhGiaByMaCX(lchuyenxe[i].MaXe)[j].BinhLuan %></p>  
                    <% } %>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <p>Không có chuyến xe nào!</p>
    <% } %>
</div>

<style>
    .bus-ticket-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        padding: 20px;
    }

    .bus-ticket-card {
        background: #fff;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease-in-out;
    }

    .bus-ticket-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
    }

    .bus-header {
        background:royalblue;
        color: white;
        padding: 15px;
        text-align: center;
        font-size: 18px;
        font-weight: bold;
    }

    .route {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .arrow {
        font-size: 22px;
    }

    .bus-info {
        padding: 15px;
        text-align: center;
    }

    .bus-info p {
        margin: 5px 0;
        font-size: 16px;
    }

    .price {
        font-weight: bold;
        color: #d9534f;
        font-size: 18px;
    }

    .button-container {
        display: flex;
        justify-content: space-around;
        padding: 15px;
    }

    .btn-show-review, .btn-book-now {
        padding: 10px 15px;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
        text-align: center;
        text-decoration: none;
        display: inline-block;
    }

    .btn-show-review {
        background: #ffc107;
        color: #fff;
    }

    .btn-show-review:hover {
        background: #e0a800;
    }

    .btn-book-now {
        background: #28a745;
        color: #fff;
    }

    .btn-book-now:hover {
        background: #218838;
    }

    .review-container {
        display: none;
        padding: 15px;
        background: #f8f9fa;
        border-top: 1px solid #ddd;
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
