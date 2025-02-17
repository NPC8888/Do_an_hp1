<%@ Page Title="Đặt Vé" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="DatVe.aspx.cs" Inherits="xediep.DatVe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .container {
            max-width: 600px;
            margin: 20px auto;
            text-align: center;
        }

        /* Cấu trúc ghế: driver, tầng 1 & tầng 2 */
        .seat-grid {
            display: grid;
            grid-template-columns: repeat(4, 60px); /* 4 ghế mỗi hàng */
            gap: 10px;
            justify-content: center;
            margin-bottom: 20px;
        }

        .seat {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            background-color: #c4e17f; /* Chỗ trống */
        }

        .seat.taken {
            background-color: #ff6b6b; /* Chỗ đã đặt */
            cursor: not-allowed;
        }

        .seat.selected {
            background-color: #3498db; /* Chỗ đang chọn */
        }

        .seat-driver {
            width: 60px;
            height: 60px;
            background-color: #f39c12;
            color: #fff;
            font-size: 14px;
            font-weight: bold;
            border-radius: 8px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: not-allowed;
            margin: 0 auto;
        }

        /* Các tầng ghế có thể có khoảng cách riêng */
        .floor-1 {
            margin-top: 20px;
        }

        .floor-2 {
            margin-top: 20px;
        }

        .circle {
            width: 40px;
            height: 40px;
            line-height: 40px;
            border-radius: 50%;
            background-color: #ddd;
            color: #fff;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            margin: auto;
            transition: background-color 0.3s ease;
        }

        .circle.active {
            background-color: #4CAF50;
        }

        .progress-line {
            flex-grow: 1;
            height: 5px;
            background-color: #ddd;
            margin: 0 10px;
            transition: background-color 0.3s ease;
        }

        .progress-line.active {
            background-color: #4CAF50;
        }

        .form-group label {
            font-size: 1rem;
            color: #4CAF50;
            margin-bottom: 5px;
            display: block;
        }

        .btnNext {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 25px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .aaa {
            display: flex;
            position: relative;
        }

        .form-group .form-control {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .form-group .form-control:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
        }

        /* Dropdown */
        .dropdown-container {
            margin-bottom: 15px;
        }

        .dropdown-container label {
            display: block;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #007bff;
        }

        .custom-dropdown {
            width: 100%;
            padding: 10px;
            border: 2px solid #007bff;
            border-radius: 5px;
            background-color: #f8f9fa;
            font-size: 16px;
            color: #333;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .custom-dropdown:hover {
            border-color: #0056b3;
        }

        .custom-dropdown:focus {
            border-color: #0056b3;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            outline: none;
        }

        /* Panel xác nhận đặt vé */
        .booking-confirmation {
            width: 400px;
            margin: 15%;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            font-family: Arial;
        }

        .booking-confirmation h2 {
            text-align: center;
            color: #007bff;
        }

        .booking-confirmation p {
            font-size: 16px;
        }

        .booking-confirmation strong {
            color: #333;
        }

        /* Phần đánh giá */
        .review-container {
            margin-top: 10px;
        }

        .review-item {
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
        }

        .review-header {
            font-size: 18px;
            color: #f39c12; /* Màu vàng cho sao đánh giá */
            margin-bottom: 5px;
        }

        .review-rating {
            font-size: 20px;
        }

        .review-content p {
            margin: 0;
            font-size: 16px;
            color: #333;
        }
    </style>

    <asp:ScriptManager runat="server" EnablePageMethods="true" />

    <!-- Thanh trạng thái -->
    <div style="display: flex; justify-content: center; align-items: center; margin: 5% 10%;">
        <div>
            <div id="Step1" class="circle active">1</div>
            <span>Chọn ghế</span>
        </div>
        <div id="Line1" class="progress-line"></div>
        <div>
            <div id="Step2" class="circle">2</div>
            <span>Nhập thông tin</span>
        </div>
        <div id="Line2" class="progress-line"></div>
        <div>
            <div id="Step3" class="circle">3</div>
            <span>Xác nhận đặt vé</span>
        </div>
    </div>

    <!-- Nội dung từng bước -->
    <div id="StepContent1" class="container">
        <h2>Bước 1: Chọn ghế Và Điểm Đón, Trả</h2>
        <div class="dropdown-container">
            <label for="ddlDiemDon">🚏 Điểm đón:</label>
            <asp:DropDownList ID="ddlDiemDon" runat="server" CssClass="custom-dropdown">
            </asp:DropDownList>
        </div>

        <div class="dropdown-container">
            <label for="ddlDiemTra">🎯 Điểm trả:</label>
            <asp:DropDownList ID="ddlDiemTra" runat="server" CssClass="custom-dropdown">
            </asp:DropDownList>
        </div>

        <div class="aaa">
            <div class="container">
                <!-- Ghế tài xế -->
                <div class="seat-grid" id="driverSeat">
                    <div class="seat-driver">Tài xế</div>
                </div>
                <!-- Tầng 1 -->
                <div class="seat-grid floor-1" id="seatGridFloor1"></div>
                <!-- Tầng 2 -->
                <div class="seat-grid floor-2" id="seatGridFloor2"></div>
                <p>Ghế đã chọn: <span id="selectedSeats"></span></p>
            </div>
            <div style="position: absolute;">
                <!-- Nút bấm hiển thị/ẩn đánh giá -->
                <p style="cursor: pointer; background-color: chocolate; padding:5px; border-radius:5px;" onclick="toggleDanhGia()">
                    Đánh Giá <i class="fas fa-comment-dots"></i>
                </p>
                <!-- Div chứa danh sách đánh giá, ẩn mặc định -->
                <div id="danhGiaContainer" style="display: none; margin-top: 10px; background-color: aquamarine; padding:10px; border-radius:5px;">
                    <h3 style="color:#007bff; text-align:center;">Đánh Giá Chuyến Xe</h3>
                    <asp:ListView ID="LvDanhGia" runat="server">
                        <LayoutTemplate>
                            <div class="review-container">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="review-item">
                                <div class="review-header">
                                    <span class="review-rating"><%# Eval("_Star") %></span>
                                </div>
                                <div class="review-content">
                                    <p><%# Eval("BinhLuan") %></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
    </div>

    <div id="StepContent2" class="container" style="display: none;">
        <h2>Bước 2: Nhập thông tin</h2>
        <div class="form-container">
            <!-- Họ tên -->
            <div class="form-group">
                <asp:Label ID="lbID" runat="server"></asp:Label>
                <label for="txtHoTen">Họ và Tên:</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nhập họ và tên" />
            </div>

            <!-- Số điện thoại -->
            <div class="form-group">
                <label for="txtSoDienThoai">Số điện thoại:</label>
                <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại" />
            </div>
        </div>
    </div>

    <div id="StepContent3" class="container" style="display: none;">
        <h2>Bước 3: Xác nhận đặt vé</h2>
        <asp:Panel ID="pnlBookingConfirmation" runat="server" CssClass="booking-confirmation">
            <h2>Xác nhận đặt vé</h2>
            <p><strong>MaXe:</strong>
                <asp:Label ID="lblmaxe" runat="server" Text="10/03/2025 08:00 AM"></asp:Label>
            </p>
            <p><strong>Số ghế:</strong>
                <asp:Label ID="SoGheDaChon" runat="server"></asp:Label>
            </p>
            <p><strong>Số tiền/vé:</strong>
                <asp:Label ID="lblTotalPrice" runat="server" Text="0"></asp:Label>
            </p>
            <p><strong>Chuyến xe:</strong>
                <asp:Label ID="lblTripName" runat="server" Text="Hà Nội - Sài Gòn"></asp:Label>
            </p>
            <p><strong>Thời gian:</strong>
                <asp:Label ID="lblDepartureTime" runat="server" Text="10/03/2025 08:00 AM"></asp:Label>
            </p>
        </asp:Panel>
    </div>

    <!-- Nút điều hướng -->
    <div style="text-align: center; margin-top: 20px;">
        <asp:Button ID="btnNext" runat="server" Text="Tiếp theo" CssClass="btnNext" />
    </div>
  
    <asp:HiddenField ID="hdnSelectedSeats" runat="server" />

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const totalSteps = 3; // Tổng số bước
            let currentStep = 1; // Bắt đầu ở bước 1
            const nextButton = document.getElementById('<%= btnNext.ClientID %>');
            const hiddenField = document.getElementById('<%= hdnSelectedSeats.ClientID %>');
            let selectedSeats = [];

            // Lấy các container ghế của tầng 1 và tầng 2
            const seatGridFloor1 = document.getElementById('seatGridFloor1');
            const seatGridFloor2 = document.getElementById('seatGridFloor2');

            // Lấy trạng thái ghế từ ViewState (ví dụ: '0' là trống, '1' là đã đặt)
            const seatStatus = JSON.parse('<%= Newtonsoft.Json.JsonConvert.SerializeObject(ViewState["SeatStatus"] ?? new string[0]) %>');
            const seatsPerFloor = Math.ceil(seatStatus.length / 2);

            seatStatus.forEach((status, index) => {
                const seat = document.createElement('div');
                seat.className = 'seat';
                seat.textContent = index + 1;

                if (status === '1') {
                    seat.classList.add('taken');
                } else {
                    seat.addEventListener('click', () => toggleSeatSelection(seat, index + 1));
                }

                if (index < seatsPerFloor) {
                    seatGridFloor1.appendChild(seat);
                } else {
                    seatGridFloor2.appendChild(seat);
                }
            });

            // Hàm chọn/bỏ chọn ghế
            function toggleSeatSelection(seat, seatNumber) {
                if (seat.classList.contains('selected')) {
                    seat.classList.remove('selected');
                    selectedSeats = selectedSeats.filter(s => s !== seatNumber);
                } else {
                    seat.classList.add('selected');
                    selectedSeats.push(seatNumber);
                }
                updateSelectedSeats();
            }

            // Cập nhật danh sách ghế đã chọn
            function updateSelectedSeats() {
                const selSeats = document.getElementById('selectedSeats');
                selSeats.textContent = selectedSeats.length ? selectedSeats.join(',') : '';
                document.getElementById('<%= SoGheDaChon.ClientID %>').innerText = selSeats.textContent;
            }

            // Chuyển bước
            function moveToNextStep() {
                if (currentStep < totalSteps) {
                    document.getElementById(`StepContent${currentStep}`).style.display = 'none';
                    document.getElementById(`Step${currentStep}`).classList.remove('active');
                    if (currentStep < totalSteps - 1) {
                        document.getElementById(`Line${currentStep}`).classList.remove('active');
                    }
                    currentStep++;
                    document.getElementById(`StepContent${currentStep}`).style.display = 'block';
                    document.getElementById(`Step${currentStep}`).classList.add('active');
                    if (currentStep > 1) {
                        document.getElementById(`Line${currentStep - 1}`).classList.add('active');
                    }
                }
            }

            // Gắn sự kiện cho nút "Tiếp theo"
            nextButton.addEventListener('click', (e) => {
                e.preventDefault();
                if (currentStep === 1 && document.getElementById('<%= SoGheDaChon.ClientID %>').innerText == "") {
                    if (confirm("Vui lòng chọn ít nhất 1 ghế?")) { }
                    return;
                } else if (currentStep === 3) {
                    var MachuyenXe = document.getElementById('<%= lblmaxe.ClientID %>').innerText;
                    var SoGhe = document.getElementById('<%= SoGheDaChon.ClientID %>').innerText;
                    var txtHoVaTen = document.getElementById('<%= txtHoTen.ClientID %>').value;
                    var txtSDT = document.getElementById('<%= txtSoDienThoai.ClientID %>').value;
                    var don = document.getElementById('<%= ddlDiemDon.ClientID %>');
                    var MaDiemDon = don.value;
                    var tra = document.getElementById('<%= ddlDiemTra.ClientID %>');
                    var MaDiemTra = tra.value;

                    PageMethods.SaveBooking(MachuyenXe, txtHoVaTen, txtSDT, SoGhe, MaDiemDon, MaDiemTra, function (response) {
                        alert("Server response: " + response);
                        
                    }, function (error) {
                        console.error(error);
                    });
                } else {
                    moveToNextStep();
                }
            });
        });

        function toggleDanhGia() {
            var container = document.getElementById('danhGiaContainer');
            container.style.display = (container.style.display === 'none' || container.style.display === '') ? 'block' : 'none';
        }
    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</asp:Content>
