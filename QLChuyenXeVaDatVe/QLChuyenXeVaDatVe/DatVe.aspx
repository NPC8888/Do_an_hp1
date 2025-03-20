<%@ Page Title="Đặt Vé" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="DatVe.aspx.cs" Inherits="xediep.DatVe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .container {
            max-width: 600px;
            margin: auto;
            text-align: center;
        }

        .containerr {
            display: flex;
            max-width: 600px;
            margin: auto;
            text-align: center;
        }
        /* Cấu trúc ghế: driver, tầng 1 & tầng 2 */
        .seat-grid {
            display: grid;
            grid-template-columns: repeat( 60px);
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
            background-color: #fff;
            border-radius: 5px;
            border: 2px solid;
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
            background-color: #a59f9f;
            cursor: not-allowed;
        }


        .seat.selected {
            background-color: #3498db; /* Chỗ đang chọn */
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
            color: black;
            margin-bottom: 5px;
            display: block;
        }

        .btnNext {
            background: #fff;
            color: black;
            border: 2px solid;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            padding: 10px;
            margin-bottom: 5%;
        }

            .btnNext:hover {
                background: #a59f9f;
            }

        .aaa {
            display: flex;
            position: relative;
        }

        .form-group .form-control {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
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
                color: black;
            }

        .custom-dropdown {
            width: 50%;
            padding: 10px;
            border: 2px solid #007bff;
            border-radius: 5px;
            background-color: #f8f9fa;
            font-size: 16px;
            color: #333;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
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

        GhiChu {
            height: 20px;
            width: 20px;
        }
    </style>

    <asp:ScriptManager runat="server" EnablePageMethods="true" />

    <!-- Thanh trạng thái -->
    <div style="display: flex; justify-content: center; align-items: center; margin: auto">
        <div style="display: flex; justify-content: center; align-items: center; min-width: 40%; margin: 2% 0 1% 0">
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
    </div>
    <!-- Nội dung từng bước -->
    <div id="StepContent1" class="container">

        <div class="dropdown-container">
            <label for="ddlDiemDon">🚏 Điểm đón:</label>
            <asp:DropDownList ID="ddlDiemDon" runat="server" CssClass="custom-dropdown">
            </asp:DropDownList>
        </div>

        <div class="dropdown-container">
            <label for="ddlDiemTra">🎯 Điểm trả :</label>
            <asp:DropDownList ID="ddlDiemTra" runat="server" CssClass="custom-dropdown">
            </asp:DropDownList>
        </div>
        <div style="display: flex; align-items: center; gap: 30px; margin: 10px 30%">
            <div style="display: flex; align-items: center; gap: 5px;">
                <div style="background-color: white; width: 15px; height: 15px; border: 1px solid black;"></div>
                <p style="margin: 0;">Ghế trống</p>
            </div>

            <div style="display: flex; align-items: center; gap: 5px;">
                <div style="background-color: gray; width: 15px; height: 15px; border: 1px solid black;"></div>
                <p style="margin: 0;">Đã đặt</p>
            </div>
        </div>

        <div class="containerr">

            <% int soghe = 1; for (int i = 1; i <= tang; i++)
                { %>
            <div class="container">

                <p>Tầng<%=i %></p>
                <div class="containerr">

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
                </div>
            </div>
            <% } %>
        </div>


        <p>Ghế đã chọn: <span id="selectedSeats"></span></p>
    </div>

    <!-- Nội dung từng bước -->
    <div id="StepContent2" class="container" style="display: none; background:none">

        <div style="background:none">
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
    <!-- Nội dung từng bước -->
    <div id="StepContent3" class="container" style="display: none;">


        <asp:Panel ID="pnlBookingConfirmation" runat="server" CssClass="booking-confirmation">
            <label for="paymentMethod">phương thức thanh toán:</label>
            <select id="paymentMethod" class="custom-dropdown" style="max-width:150px;max-height:60px; font-size:12px">
                <option value="online">Thanh toán online</option>
                <option value="onboard">Thanh toán khi lên xe</option>
            </select>
            
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
    <div id="popupDiv" class="popup" style="visibility: hidden">
        <div class="popup-content">

            <img src="" id="imgQR" alt="QR Code" />
            <div class="info" id="pr">Số tiền: <span id="amount">100,000</span> VNĐ</div>
            <div class="info" id="t">Thời gian còn lại: <span id="countdown" class="countdown">02:00</span></div>
            <button type="button" class="close-btn" onclick="(() => window.location.href = '/TrangChu.aspx')()">Về trang chủ</button>
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
                document.getElementById("popupDiv").style.visibility = "hidden";
            }
        }

        function closePopup() {
            // document.getElementById("popupDiv").style.visibility = 'hidden';
            document.getElementById("t").innerText = "Thanh toán thành công";
            document.getElementById("pr").style.display = "none";

            imgQR.src = 'https://i.pinimg.com/originals/70/a5/52/70a552e8e955049c8587b2d7606cd6a6.gif';


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
                var phuongthucc = document.getElementById('paymentMethod');

                if (phuongthucc.value == "online") {
                    var magiaodich = '<%=QLChuyenXeVaDatVe.BLL.ThanhToanBLL.Magiaodichtamthoi() %>';
                    imgQR.src = "https://img.vietqr.io/image/970422-0888501238888-compact.png?amount=" + tongtieng + "&addInfo=" + magiaodich;
                    document.getElementById("popupDiv").style.visibility = 'visible';
                    document.getElementById('amount').innerText = tongtieng;
                    updateCountdown();
                    kiemTraThanhToan(magiaodich, MachuyenXe, txtHoVaTen, txtSDT, SoGhe, MaDiemDon, MaDiemTra, tongtieng);
                }
                else {

                    PageMethods.SaveBookingb(MachuyenXe, txtHoVaTen, txtSDT, SoGhe, MaDiemDon, MaDiemTra, tongtieng, function (response) {

                        alert(response);
                        window.location.href = "TrangChu.aspx";


                    }, function (error) {

                    });

                }



            }
            else {
                moveToNextStep();
            }
        });

        function kiemTraThanhToan(magd, MachuyenXe, txtHoVaTen, txtSDT, SoGhe, MaDiemDon, MaDiemTra, tongtieng) {
            fetch("DatVe.aspx/KiemTraThanhToan", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ tongtieng: String(tongtieng), magiaodich: String(magd) })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.d === "thanhcong") {  // Kiểm tra phản hồi từ server
                        PageMethods.SaveBooking(MachuyenXe, txtHoVaTen, txtSDT, SoGhe, MaDiemDon, MaDiemTra, tongtieng, function (response) {

                            alert(response);

                        }, function (error) {

                        });

                        closePopup();
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
