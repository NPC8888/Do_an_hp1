<%@ Page Title="Đặt Vé" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="DatVe.aspx.cs" Inherits="xediep.DatVe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <style>
        .container {
            max-width: 600px;
            margin: 20px auto;
            text-align: center;
              display:flex-start;
        }
        


        .seat-grid {
            display: grid;
            grid-template-columns: repeat(4, 60px); /* 4 cột mỗi hàng */
            gap: 10px;
            justify-content: center;
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
              font-size: 1rem; /* Kích thước chữ nhãn */
              color: #4CAF50;
              margin-bottom: 5px;
              display: block;
        }
        .btnNext{
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
        .aaa{
            display:flex;
        }

.form-group .form-control {
    width: 100%; /* Chiếm toàn bộ chiều rộng container */
    padding: 10px; /* Khoảng cách bên trong */
    font-size: 1rem; /* Kích thước chữ */
    border: 1px solid #ccc; /* Viền */
    border-radius: 4px; /* Bo góc mềm mại */
    box-sizing: border-box;
    transition: border-color 0.3s ease;
}

.form-group .form-control:focus {
    border-color: #3498db; /* Đổi màu viền khi focus */
    outline: none; /* Xóa viền mặc định */
    box-shadow: 0 0 5px rgba(52, 152, 219, 0.5); /* Đổ bóng khi focus */
}
/* Tạo kiểu cho dropdown */
/* Tạo bố cục cho dropdown */
.dropdown-container {
    margin-bottom: 15px;
}

/* Kiểu chữ mô tả (label) */
.dropdown-container label {
    display: block;
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 5px;
    color: #007bff;
}

/* Kiểu cho dropdown */
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

/* Hiệu ứng hover */
.custom-dropdown:hover {
    border-color: #0056b3;
}

/* Hiệu ứng focus */
.custom-dropdown:focus {
    border-color: #0056b3;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    outline: none;
}

/*css cua pnel xac nhan thanh toan*/
    .booking-confirmation {
        width: 400px;
        margin:15%;
        
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
    <div style="display: flex; justify-content: center; align-items: center;margin:5% 10% 5% 10%">
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
        <h2>Bước 1: Chọn ghế Và Điểm Đón,Trả</h2>
       <div class="dropdown-container">
    <label for="ddlDiemDon">🚏 Điểm đón:</label>
    <asp:DropDownList ID="ddlDiemDon" runat="server" CssClass="custom-dropdown" >
      
    </asp:DropDownList>
</div>
        
<div class="dropdown-container">
    <label for="ddlDiemTra">🎯 Điểm trả:</label>
    <asp:DropDownList ID="ddlDiemTra" runat="server" CssClass="custom-dropdown" >
     
    </asp:DropDownList>
</div>
        
            

    <div class="aaa">
        <div class="container">
        <div class="seat-grid" id="seatGrid"></div>
        <p>Ghế đã chọn: <span id="selectedSeats"></span></p>
        </div>
     <div style="position: absolute;">
    
    <!-- Nút bấm hiển thị/ẩn -->
    <p style="cursor:pointer; background-color:chocolate" href="javascript:void(0);" onclick="toggleDanhGia()">Dánh Giá<i class="fas fa-comment-dots"></i> </p>

    <!-- Div chứa danh sách đánh giá, ẩn mặc định -->
    <div id="danhGiaContainer" style="display: none; margin-top: 10px; background-color:aquamarine">
        <asp:ListView ID="LvDanhGia" runat="server">
            <LayoutTemplate>
                <div class="comment-container">
                    <div id="itemPlaceholder" runat="server"></div>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="comment">
                    <div class="comment-header">
                        <span class="user-name"><%# Eval("_Star") %></span>
                    </div>
                    <div class="comment-content">
                        <%# Eval("BinhLuan") %>
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
     <p><strong>MaXe:</strong> <asp:Label ID="lblmaxe" runat="server" Text="10/03/2025 08:00 AM"></asp:Label></p>
    <p><strong>Số ghế:</strong><asp:Label ID="SoGheDaChon" runat="server"></asp:Label></p>
    <p><strong>Số tiền/vé:</strong> <asp:Label ID="lblTotalPrice" runat="server" Text="0"></asp:Label></p>
    <p><strong>Chuyến xe:</strong> <asp:Label ID="lblTripName" runat="server" Text="Hà Nội - Sài Gòn"></asp:Label></p>
    <p><strong>Thời gian:</strong> <asp:Label ID="lblDepartureTime" runat="server" Text="10/03/2025 08:00 AM"></asp:Label></p>

            

   
</asp:Panel>

    </div>

    <!-- Nút điều hướng -->
    <div style="text-align: center; margin-top: 20px;">
        <asp:Button ID="btnNext" runat="server" Text="Tiếp theo" CssClass="btnNext" />
    </div>
    <asp:Button  runat="server" OnClick="datve"/>
    <asp:HiddenField ID="hdnSelectedSeats" runat="server" />
   
    <script>
        
        document.addEventListener('DOMContentLoaded', () => {
            const totalSteps = 3; // Tổng số bước
            let currentStep = 1; // Bắt đầu ở bước 1
            const seatGrid = document.getElementById('seatGrid');
            const selectedSeatsDisplay = document.getElementById('selectedSeats');
            const nextButton = document.getElementById('<%= btnNext.ClientID %>');
            const hiddenField = document.getElementById('<%= hdnSelectedSeats.ClientID %>');
            let selectedSeats = [];

            // Tạo danh sách ghế
            const seatStatus = JSON.parse('<%= Newtonsoft.Json.JsonConvert.SerializeObject(ViewState["SeatStatus"] ?? new string[0]) %>');
            seatStatus.forEach((status, index) => {
                const seat = document.createElement('div');
                seat.className = 'seat';
                seat.textContent = index + 1;

                if (status === '1') {
                    seat.classList.add('taken');
                } else {
                    seat.addEventListener('click', () => toggleSeatSelection(seat, index + 1));
                }

                seatGrid.appendChild(seat);
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
                selectedSeatsDisplay.textContent = selectedSeats.length
                    ? selectedSeats.join(',')
                    : '';
                document.getElementById('<%= SoGheDaChon.ClientID %>').innerText = selectedSeatsDisplay.textContent;
                
               

               
                
            }

            // Chuyển bước
            function moveToNextStep() {
                if (currentStep < totalSteps) {
                    // Ẩn nội dung bước hiện tại
                    document.getElementById(`StepContent${currentStep}`).style.display = 'none';
                    document.getElementById(`Step${currentStep}`).classList.remove('active');
                    if (currentStep < totalSteps - 1) {
                        document.getElementById(`Line${currentStep}`).classList.remove('active');
                    }

                    currentStep++;

                    // Hiển thị nội dung bước tiếp theo
                    document.getElementById(`StepContent${currentStep}`).style.display = 'block';
                    document.getElementById(`Step${currentStep}`).classList.add('active');
                    if (currentStep > 1) {
                        document.getElementById(`Line${currentStep - 1}`).classList.add('active');
                    }
                }
            }

            // Gắn sự kiện click cho nút "Tiếp theo"
            nextButton.addEventListener('click', (e) => {
                e.preventDefault();
                if (currentStep === 1 && document.getElementById('<%= SoGheDaChon.ClientID %>').innerText == "" ) {
                    if (confirm("Vui lòng chọn ít nhất 1 ghế?")) {
                        
                    }
                    return;
                }
                else if (currentStep === 3) {
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
                        window.location.href = "TrangChu.aspx";
                    }, function (error) {
                        console.error(error);
                    });
                    
                }
             
                else {
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
