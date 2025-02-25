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
                 <div class="route"><%# LayDiemDiDiemDenByMaTuyenXe(Eval("MaTuyenXe").ToString()).DiemDon %>-<%# LayDiemDiDiemDenByMaTuyenXe(Eval("MaTuyenXe").ToString()).DiemDen %></div>
                <p><strong>Giờ khởi hành:</strong> <%# Eval("TgKhoiHanh") %></p>
                <p><strong>Giờ đến:</strong> <%# Eval("TgDen") %></p>
                <p class="price">Giá vé: <%# Eval("Price", "{0:C}") %></p>
                <div class="button-container">
                    <a class="btn-add-to-cart" href='<%# "DatVe.aspx?id=" + Eval("MaCx") %>'>Đặt vé ngay</a>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:ListView>

 



<style>
    .bus-ticket-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
        padding: 20px;
        animation: fadeIn 1s ease-in-out;
    }
    .bus-ticket-card {
        display: flex;
        flex-direction: column;
        width: 290px;
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
        width: 100%;
        display: inline-block;
        text-align: center;
        border: none;
        background: #2ecc71;
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
        from { opacity: 0; }
        to { opacity: 1; }
    }
    @keyframes slideUp {
        from { transform: translateY(20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

</style>
