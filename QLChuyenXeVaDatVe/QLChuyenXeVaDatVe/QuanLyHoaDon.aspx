<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyHoaDon.aspx.cs" Inherits="xediep.QuanLyHoaDon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="margin: 0 100px 0 100px">
        <h2>Quản Lý doanh thu </h2>
        <link rel="stylesheet" href="css/QuanLy.css">
        <div style="display: flex;">
            <asp:Button ID="btnAdd" runat="server" Text="Tạo báo cáo" OnClick="ThemMoi" CssClass="btn-primary" />
            <asp:TextBox ID="txtS" runat="server" TextMode="Date" class="date-picker"></asp:TextBox>
            <asp:TextBox ID="txtE" runat="server" TextMode="Date" class="date-picker"></asp:TextBox>
            <asp:Button ID="btnTK" runat="server" Text="Thống kê" OnClick="ThongKe" CssClass="btn-primary" BackColor="#FF9999" />
        </div>
        <!-- GridView to display Xe Khach List -->
        <asp:GridView ID="gvXeKhach" runat="server" AutoGenerateColumns="False" CssClass="GridViewClass"
            DataKeyNames="MaHoaDon,MaKhachHang,TongTien,TrangThai,ThoiGianThanhToan"
            OnSelectedIndexChanged="gvXeKhach_SelectedIndexChanged" BackColor="#FF99FF" BorderColor="#3333FF">
            <Columns>
                <asp:BoundField DataField="MaHoaDon" HeaderText="Mã hóa đơn" SortExpression="MaHoaDon" />
                <asp:BoundField DataField="MaKhachHang" HeaderText="Mã khách hàng" SortExpression="MaKhachHang" />
                <asp:BoundField DataField="TongTien" HeaderText="Tổng tiền" SortExpression="TongTien" />
                <asp:BoundField DataField="TrangThai" HeaderText="Trạng thái" SortExpression="TrangThai" />
                <asp:BoundField DataField="ThoiGianThanhToan" HeaderText="Thời gian thanh toán" SortExpression="ThoiGianThanhToan" />
                <asp:CommandField
                    ShowSelectButton="True"
                    SelectText="Chi tiết"
                    ControlStyle-CssClass="btn-select" />

            </Columns>
        </asp:GridView>



    </div>
    <div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7fc;
                margin: 0;
                padding: 0;
            }

            .dashboard {
                width: 70%;
                max-height: 50%;
                margin: 2px auto;
            }

            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: white;
            }

            .summary {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(50px, 1fr));
                gap: 10px;
                margin: 5px 0;
            }

            .card {
                padding: 2px;
                border-radius: 8px;
                color: white;
                text-align: center;
                font-size: 10px;
            }

            .blue {
                background-color: #2d86fa;
            }

            .cyan {
                background-color: #00bcd4;
            }

            .orange {
                background-color: #ff9800;
            }

            .charts {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 10px;
            }

            .chart {
                background: white;
                padding: 10px;
                border-radius: 8px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            canvas {
                width: 100% !important;
                height: 50% !important;
            }
        </style>

        <div class="dashboard">


            <section class="summary">
                <div class="card blue">
                    <h2><%=doanhthutheoloai[3]%> Vé</h2>
                    <p>Số lượng vé</p>
                </div>
                <div class="card blue">
                    <h2><%=doanhthutheoloai[2]%> VND</h2>
                    <p>Tổng giá trị đơn hàng</p>
                </div>
                <div class="card cyan">
                    <h2><%=doanhthutheoloai[0]%> VND</h2>
                    <p>Đã thanh toán</p>
                </div>
                <div class="card orange">
                    <h2><%=doanhthutheoloai[1] %> VND</h2>
                    <p>Số chưa thanh toán</p>
                </div>
            </section>

            <section class="charts">
                <div class="chart">
                    <canvas id="barChart"></canvas>
                </div>

            </section>
        </div>

        <script>
            // Dữ liệu từ C#
            var doanhThu24h = <%=doanhThu24h %>;



            // Biểu đồ cột - Doanh thu 24h
            // Lấy đối tượng canvas và khởi tạo biểu đồ dạng cột (bar chart)
            const ctxBar = document.getElementById('barChart').getContext('2d');

            new Chart(ctxBar, {
                type: 'bar', // Loại biểu đồ là biểu đồ cột
                data: {
                    labels: Array.from({ length: 24 }, (_, i) => i + ":00"), // Nhãn trục X: 24 giờ trong ngày (00:00 - 23:00)
                    datasets: [{
                        label: 'Doanh thu theo giờ (VND)', // Chú thích của dataset
                        data: doanhThu24h, // Mảng dữ liệu doanh thu theo từng giờ, đơn vị là VND
                        backgroundColor: '#2d86fa' // Màu nền của các cột
                    }]
                },
                options: {
                    scales: {
                        y: {
                            ticks: {
                                stepSize: 1000,//bước nhảy
                                // Tùy chỉnh cách hiển thị giá trị trên trục Y (định dạng số tiền VND)
                                callback: function (value) {
                                    return value.toLocaleString('vi-VN') + " VND";
                                    // toLocaleString('vi-VN') giúp định dạng số có dấu phân cách hàng nghìn
                                    // Ví dụ: 5000000 -> "5.000.000 VND"
                                }
                            }
                        }
                    }
                }
            });


            // Biểu đồ tròn - Thanh toán Online vs Trực tiếp

        </script>
    </div>
    <asp:ScriptManager runat="server" />

    <!-- Popup Panel -->


    <!-- Nút mở popup -->


    <!-- Popup (ẩn mặc định) -->
    <div id="popupDiv" class="popup">
        <div class="popup-content">
            <div>
                <button type="button" onclick="hidePopup()" style="margin-left: 95%" class="btn-danger">X </button>
                <h3>Thông Tin Chuyến Xe</h3>
            </div>
            <label for="txtTgKhoiHanh">Ngày bắt đầu:</label>
            <asp:TextBox ID="txtStar" runat="server" CssClass="popup-input"></asp:TextBox>
            <label for="txtTgDen">Ngày kết thúc:</label>
            <asp:TextBox ID="txtEnd" runat="server" CssClass="popup-input"></asp:TextBox>
            <label for="txtPrice">Tổng số vé:</label>
            <asp:TextBox ID="txtTongVe" runat="server" CssClass="popup-input"></asp:TextBox>
            <label for="txtPrice">Tổng tiền:</label>
            <asp:TextBox ID="txtTongTien" runat="server" CssClass="popup-input"></asp:TextBox>
            <label for="txtMaTaiXe">Loại báo cáo:</label>
            <asp:DropDownList ID="ddlLoaiBaoCao" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>

            <asp:Button ID="btnFix" runat="server" Text="Xác nhận tạo báo cáo" OnClick="ThemMoi" CssClass="btn-primary" />
        </div>
    </div>



    <script>
        function showPopup() {
            document.getElementById("popupDiv").style.display = "block";
        }

        function hidePopup() {
            document.getElementById("popupDiv").style.display = "none";
        }
    </script>

</asp:Content>
