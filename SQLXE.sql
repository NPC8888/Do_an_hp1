/*USE master;
ALTER DATABASE QLChuyenXe SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE QLChuyenXe;

*/
Create Database QLChuyenXe;
go
use QLChuyenXe;
GO

-- Bảng NguoiDung: Quản lý thông tin người dùng
CREATE TABLE NguoiDung (
    MaNguoiDung INT PRIMARY KEY IDENTITY,
    TenDangNhap NVARCHAR(50) UNIQUE,
    MatKhau NVARCHAR(255),
    HoTen NVARCHAR(100),
    SoDienThoai NVARCHAR(15),	
    Email NVARCHAR(100),
    VaiTro NVARCHAR(20), -- "KhachHang" hoặc "QuanTri"
    Token NVARCHAR(255), -- Token đăng nhập
    TokenExpiry DATETIME -- Thời gian hết hạn token
);

-- Bảng XeKhach: Quản lý thông tin xe khách
CREATE TABLE XeKhach (
    MaXe INT PRIMARY KEY IDENTITY,
    BienSoXe NVARCHAR(20),
    LoaiXe NVARCHAR(50),
    SoChoNgoi INT,
	 SoTang INT,
	  SoDay INT,
	   SoGheMoiDay INT
);

-- Bảng TuyenXe: Quản lý tuyến xe cố định
CREATE TABLE TuyenXe (
    MaTuyenXe INT PRIMARY KEY IDENTITY,
    DiemDi NVARCHAR(100),
    DiemDen NVARCHAR(100),
    TrangThai NVARCHAR(50) -- Hoạt động, Ngừng hoạt động
);

-- Bảng ChuyenXe: Quản lý các chuyến xe theo tuyến
CREATE TABLE ChuyenXe (
    MaChuyenXe INT PRIMARY KEY IDENTITY,
    MaTuyenXe INT,
    ThoiGianKhoiHanh DATETIME,
    ThoiGianDen DATETIME,
    price DECIMAL(10, 0),
    MaTaiXe INT, -- Liên kết với bảng NgườiDung
    MaXe INT, -- Liên kết với bảng XeKhach
    TrangThai NVARCHAR(20), -- "ConVe", "HetVe", "HoanThanh", v.v.
    FOREIGN KEY (MaTuyenXe) REFERENCES TuyenXe(MaTuyenXe),
    FOREIGN KEY (MaTaiXe) REFERENCES NguoiDung(MaNguoiDung),
    FOREIGN KEY (MaXe) REFERENCES XeKhach(MaXe)
);

-- Bảng DiemDonTraKhach: Điểm đón/trả khách theo chuyến xe
CREATE TABLE DiemDonTraKhach (
    IDDiem INT PRIMARY KEY IDENTITY(1,1),
    MaTuyenXe INT,  -- Mã chuyến xe (khóa ngoại)
    TenDiem NVARCHAR(255),  -- Tên điểm đón/trả khách
    DiaChi NVARCHAR(500),  -- Địa chỉ của điểm đón/trả khách
    LoaiDiem NVARCHAR(50),  -- Loại điểm (Đón hoặc Trả)
    FOREIGN KEY (MaTuyenXe) REFERENCES TuyenXe(MaTuyenXe)
);

-- Bảng GheNgoi: Quản lý ghế ngồi trên chuyến xe
CREATE TABLE GheNgoi (
    MaGhe INT PRIMARY KEY IDENTITY,
    MaChuyenXe INT, -- Liên kết với bảng ChuyenXe
    SoGhe INT,
    DaDat BIT, -- 0: Chưa đặt, 1: Đã đặt
    ThoiGianDat DATETIME,
    FOREIGN KEY (MaChuyenXe) REFERENCES ChuyenXe(MaChuyenXe)
);


-- Bảng DatVe: Quản lý thông tin đặt vé của khách hàng
-- Bảng VeXe: Quản lý vé xe
CREATE TABLE VeXe (
    MaVeXe INT PRIMARY KEY IDENTITY,
    MaKhachHang INT NULL,  -- Liên kết với khách hàng nếu có tài khoản
    HoTen NVARCHAR(100) NOT NULL,  -- Họ tên hành khách
    SoDT NVARCHAR(15) NOT NULL,  -- Số điện thoại hành khách
    MaChuyenXe INT NOT NULL,  -- Chuyến xe đã đặt
    MaGhe INT NULL,  -- Ghế ngồi (nếu có)
    DiemDon INT NOT NULL,  -- Điểm đón
    DiemTra INT NOT NULL,  -- Điểm trả
    -- Giá vé tại thời điểm đặt
    NgayDatVe DATETIME DEFAULT GETDATE(),  -- Ngày đặt vé
    TrangThai NVARCHAR(20) NOT NULL,  -- "DaDat", "HuyBo", "DaSuDung"
    FOREIGN KEY (MaKhachHang) REFERENCES NguoiDung(MaNguoiDung),
    FOREIGN KEY (MaChuyenXe) REFERENCES ChuyenXe(MaChuyenXe),
    FOREIGN KEY (MaGhe) REFERENCES GheNgoi(MaGhe),
    FOREIGN KEY (DiemDon) REFERENCES DiemDonTraKhach(IDDiem),
    FOREIGN KEY (DiemTra) REFERENCES DiemDonTraKhach(IDDiem)
);



-- Bảng HoaDon: Quản lý hóa đơn thanh toán
CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY IDENTITY,
    MaKhachHang INT NULL,  -- Liên kết khách hàng nếu có tài khoản
    NgayThanhToan DATETIME DEFAULT GETDATE(),  -- Thời gian thanh toán
    TongTien DECIMAL(18,2) NOT NULL,  -- Tổng tiền thanh toán
    TrangThai NVARCHAR(20) NOT NULL CHECK (TrangThai IN ('DaThanhToan', 'ChuaThanhToan', 'Huy')),  -- Trạng thái hóa đơn
    FOREIGN KEY (MaKhachHang) REFERENCES NguoiDung(MaNguoiDung)
);

-- Bảng ChiTietHoaDon: Liên kết nhiều vé với một hóa đơn
CREATE TABLE ChiTietHoaDon (
    MaChiTiet INT PRIMARY KEY IDENTITY,
    MaHoaDon INT NOT NULL,  -- Mã hóa đơn
    MaVeXe INT NOT NULL,  -- Mã vé xe
    GiaVe DECIMAL(10,2) NOT NULL,  -- Giá vé thực tế khi thanh toán
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaVeXe) REFERENCES VeXe(MaVeXe)
);

-- Bảng ThanhToan: Quản lý giao dịch thanh toán ngân hàng
CREATE TABLE ThanhToan (
    MaThanhToan INT PRIMARY KEY IDENTITY,
    MaHoaDon INT,
    PhuongThucThanhToan NVARCHAR(50),
    
    TrangThai NVARCHAR(20), -- "ThanhCong", "ThatBai"
    ThoiGianThanhToan DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    
);

-- Bảng DanhGia: Đánh giá chuyến xe và tuyến xe
CREATE TABLE DanhGia (
    MaDanhGia INT PRIMARY KEY IDENTITY,
    MaNguoiDung INT,
    MaXe INT NULL, 
    DiemDanhGia INT, -- Thang điểm 1 đến 5
    BinhLuan NVARCHAR(500),
    FOREIGN KEY (MaXe) REFERENCES XeKhach(MaXe),
   
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);
-- Bảng BaoCao: Quản lý thông tin thống kê và báo cáo
CREATE TABLE BaoCao (
    MaBaoCao INT PRIMARY KEY IDENTITY,
    LoaiBaoCao NVARCHAR(50), -- "Ngay", "Thang", "Nam", v.v.
    NgayBatDau DATETIME,
    NgayKetThuc DATETIME,
    TongSoVe INT,
    TongDoanhThu DECIMAL(18, 2)
);
go
INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, SoDienThoai, Email, VaiTro )
VALUES 
    ('nguyenan', 'hashed_password_1', 'Nguyen An', '0912345678', 'nguyenan@email.com', 'KhachHang'),
    ('admin01', 'hashed_password_2', 'Admin Quản Trị', '0909876543', 'admin01@email.com', 'QuanTri'),
    ('lethanh', 'hashed_password_3', 'Le Thanh', '0922334455', 'lethanh@email.com', 'TaiXe');

	use QLChuyenXe
	select * from NguoiDung