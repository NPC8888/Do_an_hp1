<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListChuyenXe.ascx.cs" Inherits="xediep.webControl.ListChuyenXe" %>

<div class="bus-ticket-container">
    <% if (lchuyenxe != null) { %>
        <% for (int i = 0; i < lchuyenxe.Count; i++) { %>
            <div class="bus-ticket-card animate-fade-in">
                <div class="bus-info">
                    <div class="route">
                        <%= LayDiemDiDiemDenByMaTuyenXe(lchuyenxe[i].MaTuyenXe.ToString()).DiemDon %> - 
                        <%= LayDiemDiDiemDenByMaTuyenXe(lchuyenxe[i].MaTuyenXe.ToString()).DiemDen %>
                    </div>
                    <p><strong>Giờ khởi hành:</strong> <%= lchuyenxe[i].TgKhoiHanh %></p>
                    <p><strong>Giờ đến:</strong> <%= lchuyenxe[i].TgDen %></p>
                    <p class="price">Giá vé: <%= lchuyenxe[i].Price %> VND</p>
                    <div class="button-container">
                        <a class="btn-add-to-cart" onclick="showDanhGia('<%= lchuyenxe[i].MaXe %>')">Xem đánh giá</a>
                        <a class="btn-add-to-cart" href="DatVe.aspx?id=<%= lchuyenxe[i].MaCx %>">Đặt vé ngay</a>
                    </div>
                </div>
                <div id="divDanhGia<%= lchuyenxe[i].MaXe %>" style="display: none;">
                    <!-- Nội dung đánh giá sẽ được load ở đây -->
                    <%for (int j = 0; j < BLL.DanhGiaBLL.Instance.GetDanhGiaByMaCX(lchuyenxe[i].MaXe).Count(); j++)
                        { %>
                    <p><%=BLL.DanhGiaBLL.Instance.GetDanhGiaByMaCX(lchuyenxe[i].MaXe)[j].BinhLuan %></p>  

                    <%} %>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <p>Không có chuyến xe nào!</p>
    <% } %>
</div>






<style>
    .bus-ticket-container {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        padding: 20px;
        animation: fadeIn 1s ease-in-out;
    }

    .bus-ticket-card {
        display: flex;
        flex-direction: column;
        width: 100%;
        border-radius: 12px;
        overflow: hidden;
        background: white;
        box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
        transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        opacity: 0;
        animation: slideUp 0.6s ease-in-out forwards;
    }

        .bus-ticket-card:hover {
            transform: scale(1.07);
            box-shadow: 0px 14px 25px rgba(0, 0, 0, 0.25);
        }

    .bus-image img {
        width: 100%;
        height: 180px;
        object-fit: cover;
        border-bottom: 3px solid #f1f1f1;
        transition: transform 0.3s ease-in-out;
    }

    .bus-ticket-card:hover .bus-image img {
        transform: scale(1.08);
    }

    .bus-info {
        padding: 20px;
        text-align: center;
        background: linear-gradient(to right, #ff7e5f, #feb47b);
        color: white;
        position: relative;
    }

        .bus-info h3 {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .bus-info p {
            font-size: 15px;
            margin: 5px 0;
        }

    .price {
        font-weight: bold;
        font-size: 18px;
        margin-bottom: 10px;
    }

    .button-container {
        margin-top: 10px;
    }

    .btn-add-to-cart {
        padding: 12px;
        width: 10%;
        display: inline-block;
        text-align: center;
        border: none;
        background: #296dc2;
        color: white;
        font-size: 16px;
        font-weight: bold;
        border-radius: 1px;
        cursor: pointer;
        transition: background 0.3s ease-in-out, transform 0.2s ease-in-out;
        text-decoration: none;
    }

        .btn-add-to-cart:hover {
            background: #27ae60;
            transform: translateY(-3px);
        }

        .btn-add-to-cart:active {
            transform: scale(0.95);
        }

    @keyframes fadeIn {
        from {
            opacity: 0;
        }

        to {
            opacity: 1;
        }
    }

    @keyframes slideUp {
        from {
            transform: translateY(20px);
            opacity: 0;
        }

        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
</style>
<script>
    function showDanhGia(id) {
        if (document.getElementById("divDanhGia" + id).style.display == "block") {
            document.getElementById("divDanhGia" + id).style.display = "none";
        }
        else {
            document.getElementById("divDanhGia" + id).style.display = "block";
        }

        
    }

</script>
