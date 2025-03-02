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
            grid-template-columns: repeat( 60px); /* 4 ghế mỗi hàng */
            gap: 10px;
            justify-content: center;
            margin-bottom: 20px;
        }

        .seat-row {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }

        .seat {
            width: 40px;
            height: 40px;
            margin: 5px;
            text-align: center;
            line-height: 40px;
            background-color: darkgray;
            border-radius: 5px;
            cursor: pointer;
        }

        .taken {
            width: 40px;
            height: 40px;
            margin: 5px;
            text-align: center;
            line-height: 40px;
            border-radius: 5px;
            cursor: pointer;
            background-color: darkkhaki;
            cursor: not-allowed;
        }


        .seat.selected {
            background-color: #3498db; /* Chỗ đang chọn */
        }

        .seat-driver {
            width: 30px;
            height: 30px;
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
                <% int soghe = 1; for (int i = 1; i <= tang; i++)
                    { %>
                <!-- Tầng <%=i %> -->
                <p>Tầng<%=i %></p>
                <div class="seat-grid floor-<%=i %>">
                    <% for (int j = 1; j <= day; j++)
                        { %>
                    <div class="seat-row">
                        <% for (int k = 1; k <= ghe; k++)
                            {
                                if (trangThaiGhe[soghe] == "0")
                                {  %>
                        <div class="seat" id="seat<%=i %><%=j %><%=k %>"
                            onclick="toggleSeatSelection('seat<%=i %><%=j %><%=k %>',<%=soghe %>)">
                            <%=soghe %>
                        </div>
                        <% }
                            else
                            {  %>
                        <div class="taken">
                            <%=soghe %>
                        </div>
                        <%} %>
                        <% soghe++;
                            } %>
                    </div>
                    <% } %>
                </div>
                <% } %>

                <p>Ghế đã chọn: <span id="selectedSeats"></span></p>
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
            <p>
                <strong>Xe khách:</strong>
                <asp:Label ID="lblmaxe" runat="server"></asp:Label>
            </p>
            <p>
                <strong>Số ghế:</strong>
                <asp:Label ID="SoGheDaChon" runat="server"></asp:Label>
            </p>
            <p>
                <strong>Số tiền/vé:</strong>
                <asp:Label ID="lblTotalPrice" runat="server" Text="0"></asp:Label>
            </p>
            <p>
                <strong>Chuyến xe:</strong>
                <asp:Label ID="lblTripName" runat="server" Text="Hà Nội - Sài Gòn"></asp:Label>
            </p>
            <p>
                <strong>Thời gian:</strong>
                <asp:Label ID="lblDepartureTime" runat="server" Text="10/03/2025 08:00 AM"></asp:Label>
            </p>
        </asp:Panel>
    </div>

    <!-- Nút điều hướng -->
    <div style="text-align: center; margin-top: 20px;">
        <asp:Button ID="btnNext" runat="server" Text="Tiếp theo" CssClass="btnNext" />
    </div>

    <asp:HiddenField ID="hdnSelectedSeats" runat="server" />

    <script defer>

        const totalSteps = 3; // Tổng số bước
        let currentStep = 1; // Bắt đầu ở bước 1
        const nextButton = document.getElementById('<%= btnNext.ClientID %>');
        const hiddenField = document.getElementById('<%= hdnSelectedSeats.ClientID %>');
        let selectedSeats = [];





        // Render ghế cho từng tầng







        // Hàm chọn/bỏ chọn ghế
        function so(alt) {

            alert(alt);
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
               // var MachuyenXe = document.getElementById('<%= lblmaxe.ClientID %>').innerText;
                var MachuyenXe =<%=cx.MaCx %>;
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

        function toggleSeatSelection(seatId, seatNumber) {

            let seat = document.getElementById(seatId);
            if (!seat) alert("a" + seatId); // Kiểm tra nếu phần tử không tồn tại

            if (seat.classList.contains('selected')) {
                seat.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s !== seatNumber);
            } else {
                seat.classList.add('selected');
                selectedSeats.push(seatNumber);
            }

            updateSelectedSeats();
        }

    </script>

</asp:Content>
