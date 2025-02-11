<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListChuyenXe.ascx.cs" Inherits="xediep.webControl.ListChuyenXe" %>
<asp:ListView ID="ListView1" runat="server">
    <LayoutTemplate>
        <div class="bus-ticket-container">
            <div id="itemPlaceholder" runat="server"></div>
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div class="bus-ticket-card animate-fade-in">
            <div class="bus-image">
                <img src='/jpg/1.jpg' alt='<%# Eval("MaCx") %>' />
            </div>
            <div class="bus-info">
                <h3><%# Eval("DDi") %> → <%# Eval("DDen") %></h3>
                <p><strong>Giờ khởi hành:</strong> <%# Eval("TgKhoiHanh") %></p>
                <p><strong>Giờ đến:</strong> <%# Eval("TgDen") %></p>
                <p class="price">Giá vé: <%# Eval("Price", "{0:C}") %></p>
                <a class="btn-add-to-cart" href='<%# "DatVe.aspx?id=" + Eval("MaCx") %>'>Đặt vé ngay</a>

                   
            </div>
        </div>
    </ItemTemplate>
</asp:ListView>


    <style>
/* Container chính */
.bus-ticket-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    padding: 20px;
    animation: fadeIn 1s ease-in-out;
}

/* Card vé xe */
.bus-ticket-card {
    display: flex;
    flex-direction: column;
    width: 270px;
    border-radius: 12px;
    overflow: hidden;
    background: white;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
    opacity: 0;
    animation: slideUp 0.6s ease-in-out forwards;
}

.bus-ticket-card:hover {
    transform: scale(1.05);
    box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2);
}

/* Hiệu ứng ảnh */
.bus-image img {
    width: 100%;
    height: 160px;
    object-fit: cover;
    border-bottom: 2px solid #f1f1f1;
    transition: transform 0.3s ease-in-out;
}

.bus-ticket-card:hover .bus-image img {
    transform: scale(1.05);
}

/* Thông tin chuyến xe */
.bus-info {
    padding: 15px;
    text-align: center;
}

.bus-info h3 {
    font-size: 18px;
    color: #333;
}

.bus-info p {
    font-size: 14px;
    color: #666;
}

.price {
    font-weight: bold;
    color: #e74c3c;
    margin-top: 5px;
}

/* Nút "Thêm vào giỏ hàng" */
.btn-add-to-cart {
    margin-top: 10px;
    padding: 10px;
    width: 100%;
    border: none;
    background: #3498db;
    color: white;
    font-size: 14px;
    font-weight: bold;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s ease-in-out, transform 0.2s ease-in-out;
}

.btn-add-to-cart:hover {
    background: #2980b9;
    transform: translateY(-3px);
}

.btn-add-to-cart:active {
    transform: scale(0.95);
}

/* Hiệu ứng xuất hiện */
@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

/* Hiệu ứng trượt lên khi load */
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

/* Hiệu ứng khi thêm vào giỏ hàng */
@keyframes pulse {
    0% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.1);
    }
    100% {
        transform: scale(1);
    }
}

    </style>
    <script>
      


    </script>

