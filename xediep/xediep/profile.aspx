<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="xediep.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="container">
          
            <!-- Thông tin cá nhân -->
            <div class="profile-card">
                <button id="editButton" style="margin-left:90%" >🖊️</button>
                <h2>Thông tin cá nhân</h2>
                <p><strong>Họ tên:</strong> <asp:Label ID="lblFullName" runat="server" /></p>
                <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></p>
                <p><strong>Số điện thoại:</strong> <asp:Label ID="lblPhone" runat="server" /></p>
            </div>

            <!-- Vé xe đã đặt -->
            <div class="ticket-history">
                <h2>Vé xe đã đặt</h2>
               <asp:GridView ID="gvTickets" runat="server" CssClass="ticket-table" DataKeyNames="MaChuyenXe" AutoGenerateColumns="False" BorderStyle="None" >
    <Columns>
        <asp:BoundField DataField="HoTen" HeaderText="Họ Tên" />
        <asp:BoundField DataField="soDT" HeaderText="Số Điện Thoại" />
        <asp:BoundField DataField="TenDiemDon" HeaderText="Điểm đi" />
        <asp:BoundField DataField="TenDiemTra" HeaderText="Điểm đến" />
        <asp:BoundField DataField="NgayDatVe" HeaderText="Ngày đi" DataFormatString="{0:dd/MM/yyyy}" />
       
    </Columns>
</asp:GridView>

            </div>

            <!-- Nút Đăng xuất -->
            <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" CssClass="logout-btn"
                OnClick="btnLogout_Click" />
        </div>

    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Chỉnh sửa thông tin cá nhân</h2>
          
                <div class="form-group">
                    <label for="editFullName">Họ và Tên:</label>
                    <input type="text" id="editFullName" name="editFullName" runat="server" required>
                </div>
                <div class="form-group">
                    <label for="editPhone">Số Điện Thoại:</label>
                    <input type="tel" id="editPhone" name="editPhone" runat="server" required>
                </div>
                <div class="form-group">
                    <label for="editEmail">Email:</label>
                    <input type="email" id="editEmail" name="editEmail" runat="server" required>
                </div>
                
                <asp:Button ID="btnfix" CssClass="modern-button" runat="server" OnClick="btnFix" Text="Lưu thay đổi" />
           
        </div>
    </div>

    <style>
        body {
    font-family: Arial, sans-serif;
    background: #f4f4f4;
    text-align: center;
    padding: 20px;
}

.container {
    width: 60%;
    margin: auto;
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
}

.profile-card {
    padding: 20px;
    background: #3498db;
    color: white;
    border-radius: 10px;
    margin-bottom: 20px;
}

.ticket-history {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.ticket-table {
    width: 100%;
    border-collapse: collapse;
}

.ticket-table th, .ticket-table td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.ticket-table th {
    background: #2ecc71;
    color: white;
}

.logout-btn {
    background: #e74c3c;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 20px;
    font-size: 16px;
}

.logout-btn:hover {
    background: #c0392b;
}/* Reset CSS */



/* Nút hiện đại */
.modern-button {
    background: linear-gradient(135deg, #6a11cb, #2575fc);
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 25px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.modern-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

/* Modal */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(5px); /* Hiệu ứng mờ nền */
}

.modal-content {
    background: white;
    margin: 10% auto;
    padding: 25px;
    border-radius: 15px;
    width: 90%;
    max-width: 400px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
    from {
        transform: translateY(-50px);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

/* Nút đóng modal */
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    transition: color 0.2s;
}

.close:hover {
    color: #333;
}

/* Form */
h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #333;
    font-weight: 600;
}



label {
    display: block;
    margin-bottom: 5px;
    color: #555;
    font-weight: 500;
}

input[type="text"],
input[type="tel"],
input[type="email"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.2s, box-shadow 0.2s;
}

input[type="text"]:focus,
input[type="tel"]:focus,
input[type="email"]:focus {
    border-color: #6a11cb;
    box-shadow: 0 0 8px rgba(106, 17, 203, 0.3);
    outline: none;
}
    </style>
    <script>
        // Lấy các phần tử DOM
        const editButton = document.getElementById('editButton');
        const modal = document.getElementById('editModal');
        const closeButton = document.querySelector('.close');
        const editForm = document.getElementById('editForm');
        
        // Hiển thị modal khi nhấn nút chỉnh sửa
        editButton.addEventListener('click', (event) => {
            event.preventDefault();
            modal.style.display = 'block';
        });

        // Ẩn modal khi nhấn nút đóng (x)
        closeButton.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        // Ẩn modal khi nhấn bên ngoài modal
        window.addEventListener('click', (event) => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });

        // Xử lý khi form chỉnh sửa được gửi
        editForm.addEventListener('submit', (event) => {
            event.preventDefault();

            // Lấy giá trị từ các trường nhập liệu
            const fullName = document.getElementById('editFullName').value;
            const phone = document.getElementById('editPhone').value;
            const email = document.getElementById('editEmail').value;

            // Hiển thị thông tin nhập vào console
            console.log('Họ và Tên mới:', fullName);
            console.log('Số Điện Thoại mới:', phone);
            console.log('Email mới:', email);

            // Đóng modal sau khi lưu
            modal.style.display = 'none';

            // Hiển thị thông báo thành công
            alert('Thông tin đã được cập nhật thành công!');
        });
        function iconlgclik() {
            window.location.href = "TrangChu.aspx"
        }
        function handleEditClick(maChuyenXe) {
            // Hiển thị mã chuyến xe trên console hoặc thực hiện hành động khác
            console.log("Đánh giá chuyến xe với mã: " + maChuyenXe);

            // Bạn có thể thực hiện các hành động khác, như hiển thị modal hoặc gửi dữ liệu đến server bằng AJAX
            return false; // Ngừng hành động mặc định của nút (không gửi yêu cầu đến server)
        }
    </script>

</asp:Content>
