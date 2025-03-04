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


        .popup {
            display: flex;
            align-items: center;
            justify-content: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.5);
        }

        .popup-content {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
            width: 300px;
        }

        #imgQR {
            width: 100%;
            border-radius: 5px;
        }

        .info {
            margin-top: 10px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .countdown {
            font-size: 18px;
            color: red;
            font-weight: bold;
            margin-top: 5px;
        }

        .close-btn {
            background: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
        }

            .close-btn:hover {
                background: darkred;
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
            <div class="form-group">
                <label for="txtSoDienThoai">Gamil nhận hóa đơn và vé điện tử:</label>
                <asp:TextBox ID="txtGmail" runat="server" CssClass="form-control" placeholder="Nhập gmail" />
            </div>


        </div>

    </div>

    <div id="StepContent3" class="container" style="display: none;">
        <h2>Bước 3: Xác nhận đặt vé</h2>

        <asp:Panel ID="pnlBookingConfirmation" runat="server" CssClass="booking-confirmation">
            <label for="paymentMethod">Chọn phương thức thanh toán:</label>
            <select id="paymentMethod">
                <option value="online">Thanh toán online</option>
                <option value="onboard">Thanh toán khi lên xe</option>
            </select>
            <h2>Nội dung</h2>
            <p>
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
    <!--popup thanh toán-->
    <div id="popupDiv" class="popup" style="visibility:hidden">
        <div class="popup-content">

            <img src="" id="imgQR" alt="QR Code" />
            <div class="info">Số tiền: <span id="amount">100,000</span> VNĐ</div>
            <div class="info">Thời gian còn lại: <span id="countdown" class="countdown">02:00</span></div>
            <button type="button" class="close-btn" onclick="closePopup()">Hủy</button>
        </div>
    </div>
    <asp:HiddenField ID="hdnSelectedSeats" runat="server" />

    <script defer>
        let price = Number(document.getElementById('<%= lblTotalPrice.ClientID %>').innerText);
        
        const totalSteps = 3; // Tổng số bước
        let currentStep = 1; // Bắt đầu ở bước 1
        const nextButton = document.getElementById('<%= btnNext.ClientID %>');
        const hiddenField = document.getElementById('<%= hdnSelectedSeats.ClientID %>');
        let selectedSeats = [];
        var imgQR = document.getElementById('imgQR');
        let tongtieng = 0;



        let timeLeft = 120; // 2 phút
        const countdownEl = document.getElementById("countdown");

        function updateCountdown() {
            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;
            countdownEl.textContent = `${minutes}:${seconds < 10 ? "0" : ""}${seconds}`;
            if (timeLeft > 0) {
                timeLeft--;
                setTimeout(updateCountdown, 1000);
            } else {
                closePopup();
            }
        }

        function closePopup() {
            document.getElementById("popupDiv").style.visibility='hidden';
        }
        //updateCountdown();

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

                    document.getElementById(`Line${currentStep - 1}`).classList.add('active'); tent = "Thanh toán";
                }

            }
        }

        // Gắn sự kiện cho nút "Tiếp theo"
        nextButton.addEventListener('click', (e) => {
            e.preventDefault();
            if (currentStep === 1 && document.getElementById('<%=SoGheDaChon.ClientID%>').innerText == "") {
                if (confirm("Vui lòng chọn ít nhất 1 ghế?")) { }
                return;



            }
            else if (currentStep === 2) {

                nextButton.value = "Thanh toán";
                moveToNextStep();
            }
            else if (currentStep === 3) {

                var MachuyenXe =<%=cx.MaCx %>;
                var SoGhe = document.getElementById('<%= SoGheDaChon.ClientID %>').innerText;
                var txtHoVaTen = document.getElementById('<%= txtHoTen.ClientID %>').value;
                var txtSDT = document.getElementById('<%= txtSoDienThoai.ClientID %>').value;
                var don = document.getElementById('<%= ddlDiemDon.ClientID %>');
                var MaDiemDon = don.value;
                var tra = document.getElementById('<%= ddlDiemTra.ClientID %>');
                var MaDiemTra = tra.value;
                var magiaodich ='<%=QLChuyenXeVaDatVe.BLL.ThanhToanBLL.Magiaodichtamthoi() %>';
                imgQR.src = "https://img.vietqr.io/image/970422-0888501238888-compact.png?amount=" + tongtieng + "&addInfo="+magiaodich;
                document.getElementById("popupDiv").style.visibility = 'visible';
                document.getElementById('amount').innerText = tongtieng;
                updateCountdown();
                kiemTraThanhToan(tongtieng,magiaodich)
                
                

               

                //PageMethods.SaveBooking(MachuyenXe, txtHoVaTen, txtSDT, SoGhe, MaDiemDon, MaDiemTra, tongtieng,magiaodich, function (response) {

                //    alert("Server response: " + response);
                    
                //}, function (error) {
                //    console.error(error);
                //});
            } else {
                moveToNextStep();
            }
        });
 
        function kiemTraThanhToan(tien, magd) {
            fetch("DatVe.aspx/KiemTraThanhToan", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ tongtieng: String(tien), magiaodich: String(magd) })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.d === "thanhcong") {  // Kiểm tra phản hồi từ server
                        alert("Thanh toán thành công!");
                    } else {
                        setTimeout(() => kiemTraThanhToan(tien, magd), 3000); // 🔹 Truyền lại tham số
                    }
                })
                .catch(error => console.error("Lỗi:", error));
        }
        function toggleSeatSelection(seatId, seatNumber) {

            let seat = document.getElementById(seatId);


            if (seat.classList.contains('selected')) {
                seat.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s !== seatNumber);
                tongtieng = tongtieng - price;
                document.getElementById('<%= lblTotalPrice.ClientID %>').innerText = tongtieng;

            } else {
                seat.classList.add('selected');
                selectedSeats.push(seatNumber);
                tongtieng = tongtieng + price;
                document.getElementById('<%= lblTotalPrice.ClientID %>').innerText = tongtieng;
            }

            updateSelectedSeats();

        };
        const seletPhuongThuc = document.getElementById("paymentMethod").addEventListener("change", function () {
            let selectedValue = this.value;
            if (selectedValue == "online") {
                nextButton.value = "Thanh toán";
            }
            else {
                nextButton.value = "Đặt vé"
            }
        });


    </script>

</asp:Content>
