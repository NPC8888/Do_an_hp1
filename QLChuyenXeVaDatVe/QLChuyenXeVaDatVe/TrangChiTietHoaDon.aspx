<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrangChiTietHoaDon.aspx.cs" ValidateRequest="false" Inherits="QLChuyenXeVaDatVe.TrangChiTietHoaDon" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chi Tiết Hóa Đơn</title>
</head>
<body>

    <form id="form1" runat="server">
        <div class="container">
            <div runat="server" id="IconMaill" style="display: block; margin-left: 80%; align-items: center; cursor: pointer">
                <div style="display: flex; flex-direction: column; align-items: center; text-align: center;"onclick="openMail()()">
                    <img style="height: 20px" src="https://icon666.com/f/_thumb/a7b/a7b5c0r5e91p_64.png" />
                    <strong>Hóa đơn điện tử</strong>
                </div>
            </div>

            <h2>Chi Tiết Hóa Đơn</h2>

            <div class="info" id="hd">
                <div>
                    <label>Mã Hóa Đơn:</label>
                    <asp:Label ID="lblMaHD" runat="server" CssClass="value"></asp:Label>
                </div>
                <div>
                    <label>Ngày Lập:</label>
                    <asp:Label ID="lblNgayLap" runat="server" CssClass="value"></asp:Label>
                </div>
                <div>
                    <label>Tổng tiền:</label>
                    <asp:Label ID="lblTongTien" runat="server" CssClass="value"></asp:Label>
                </div>
                <div>
                    <label>Trạng Thái:</label>
                    <asp:Label ID="lblTrangThai" runat="server" CssClass="value"></asp:Label>
                </div>
            </div>

            <asp:Button ID="btnDanhGia" runat="server" CssClass="btn-primary" OnClientClick="openReview(); return false;" Text="📝 Đánh giá" />

            <h3>Chi Tiết Đơn Hàng</h3>
            <div class="table-container">
                <asp:GridView ID="gvChiTietHoaDon" runat="server" CssClass="table" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="TenChuyen" HeaderText="🚍 Chuyến Xe" />
                        <asp:BoundField DataField="SoGhe" HeaderText="💺 Số Ghế" />
                        <asp:BoundField DataField="GiaVe" HeaderText="💰 Giá Vé" />
                    </Columns>
                </asp:GridView>
            </div>

            <button type="button" class="btn-secondary" onclick="quaylai()">Quay lại</button>
        </div>
        <!-- Button mở đánh giá -->


        <!-- Div đánh giá (Ẩn mặc định) -->
        <div class="rating-container" id="reviewPopup">
            <button style="margin-left: 80%; background: none" class="btn-close" onclick="closeReview()">❌</button>
            <h3>Đánh giá dịch vụ</h3>
            <asp:HiddenField ID="hdnDiem" runat="server" />


            <div class="star-rating">
                <span class="star" data-value="1">★</span>
                <span class="star" data-value="2">★</span>
                <span class="star" data-value="3">★</span>
                <span class="star" data-value="4">★</span>
                <span class="star" data-value="5">★</span>
            </div>


            <textarea runat="server" id="txtNoiDung" placeholder="Nhập đánh giá của bạn..."></textarea>
            <div class="buttons">
                <button runat="server" id="btnGuiDanhGia" onserverclick="btnDanhGia_Click" class="btn-submit">Gửi Đánh Giá</button>
            </div>
        </div>
         <!-- nhap maill nhận hóa đơn -->
        <div class="rating-container"  id="maill">
            <button style="margin-left: 80%; background: none" class="btn-close" onclick="close()">❌</button>
            <h3>Đánh giá dịch vụ</h3>
            <p>Địa chỉ Gmail nhận hóa đơn:</p>
            <textarea runat="server" style="max-height:50px;" id="txtMaill"></textarea>
            <div class="buttons">
                <button id="Button1" onclick="sendEmail()" class="btn-submit">Gửi hóa đơn</button>
            </div>
        </div>

        <style>
            /* Ẩn popup mặc định */
            .rating-container {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 500px;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                text-align: center;
                z-index: 1000;
            }



            /* Chọn sao */
            .star-rating {
                font-size: 30px;
                cursor: pointer;
                color: #ccc;
                margin-bottom: 10px;
            }

            .star {
                transition: color 0.3s;
            }

                .star:hover,
                .star.active {
                    color: #FFD700;
                }

            /* Ô nhập đánh giá */
            textarea {
                width: 100%;
                height: 80px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                resize: none;
            }

            .buttons {
                margin-top: 15px;
            }

            .btn-submit, .btn-close, .btn-open {
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                margin: 5px;
            }

            .btn-submit {
                background: #007BFF;
                color: white;
            }

                .btn-submit:hover {
                    background: #0056b3;
                }

            .btn-close {
                background: #dc3545;
                color: white;
            }

                .btn-close:hover {
                    background: #a71d2a;
                }

            /* Nút mở đánh giá */
            .btn-open {
                display: block;
                margin: 20px auto;
                background: #28a745;
                color: white;
                font-size: 18px;
            }

                .btn-open:hover {
                    background: #218838;
                }
        </style>

        <script>
            document.addEventListener("DOMContentLoaded", function () {


                const stars = document.querySelectorAll(".star");
                let selectedRating = 0;

                stars.forEach(star => {
                    star.addEventListener("click", function () {
                        selectedRating = this.getAttribute("data-value");
                        updateStars(selectedRating);
                    });
                });

                function updateStars(rating) {
                    stars.forEach(star => {
                        star.classList.remove("active");
                        if (star.getAttribute("data-value") <= rating) {
                            star.classList.add("active");
                        }
                    });
                    setDiem(selectedRating);
                }
            });
            function setDiem(diem) {
                document.getElementById('<%= hdnDiem.ClientID %>').value = diem;
            }

            function openReview() {
                document.getElementById("reviewPopup").style.display = "block";

            }

            function closeReview() {
                document.getElementById("reviewPopup").style.display = "none";

            }
            function openMail() {
                document.getElementById("maill").style.display = "block";

            }

            function close() {
                document.getElementById("maill").style.display = "none";

            }
            //Post gui mail
            function sendEmail() {
                const maHoaDon = document.getElementById('<%=lblMaHD.ClientID%>').innerText;
                const Gmaill = document.getElementById('<%=txtMaill.ClientID%>').value;
                fetch('/TrangChiTietHoaDon.aspx/SendEmail', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ maHoaDon: maHoaDon,Gmaill:Gmaill }) // Truyền mã hóa đơn
                })
                    .then(response => response.json())
                    .then(data => {
                        alert("Kết quả: " + data.d); // Hiển thị kết quả
                    })
                    .catch(error => console.error('Lỗi:', error));
            }




        </script>

        <style>
            body {
                background: #F4F4F4;
                font-family: 'Arial', sans-serif;
                color: #333333;
                display: flex;
                justify-content: center;
                align-items: center;
                height: auto;
            }

            .container {
                width: 100%;
                background: none;
                padding: 30px;
                border-radius: 12px;
              
                text-align: center;
            }

            h2, h3 {
                font-weight: bold;
                color: #333333;
                margin-bottom: 15px;
            }

            .info {
                display: flex;
                flex-direction: column;
                gap: 10px;
                text-align: left;
                margin-bottom: 20px;
            }

                .info label {
                    font-weight: 600;
                    color: #555555;
                    width: 120px;
                    display: inline-block;
                }

            .value {
                font-weight: bold;
                color: #007BFF;
            }

            /* Bố cục bảng đẹp hơn */
            .table-container {
                overflow-x: auto;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                margin-top: 10px;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                background: white;
            }

                .table th, .table td {
                    border: 1px solid #ddd;
                    padding: 12px;
                    text-align: center;
                }

                .table th {
                    background-color: #007BFF;
                    color: white;
                    font-weight: bold;
                }

                .table tr:nth-child(even) {
                    background-color: #F1F1F1;
                }

            /* Nút bấm có icon */
            .btn-primary {
                width: 100%;
                padding: 12px;
                font-size: 18px;
                margin-top: 20px;
                background: #c1af09;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s;
            }

                .btn-primary:hover {
                    background: #0056b3;
                }

            .btn-secondary {
                width: 100%;
                padding: 10px;
                font-size: 16px;
                margin-top: 10px;
                color: black;
                border: 2px solid;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s;
            }

                .btn-secondary:hover {
                    background: #5A6268;
                }
        </style>
    </form>
    <script>
        function quaylai() {
            window.history.go(-1);
        }
    </script>
</body>
</html>
