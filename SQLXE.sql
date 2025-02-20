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
    SoChoNgoi INT
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
    GiaVe DECIMAL(10,2) NOT NULL,  -- Giá vé tại thời điểm đặt
    NgayDatVe DATETIME DEFAULT GETDATE(),  -- Ngày đặt vé
    TrangThai NVARCHAR(20) NOT NULL,  -- "DaDat", "HuyBo", "DaSuDung"
    SoTienKhiDatVe DECIMAL(18,2) NOT NULL,  -- 
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
    MaPhuongThuc INT NOT NULL,  -- Phương thức thanh toán
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
CREATE TABLE KhuyenMai (
    MaKhuyenMai INT PRIMARY KEY IDENTITY,
    Code NVARCHAR(50) UNIQUE NOT NULL,  -- Mã giảm giá
    LoaiKhuyenMai NVARCHAR(20) NOT NULL CHECK (LoaiKhuyenMai IN ('PhanTram', 'TienMat')), 
    MucGiamGia DECIMAL(10,2) NOT NULL,  -- Mức giảm giá (nếu là % thì tính trên tổng hóa đơn)
    SoLuong INT NOT NULL,  -- Tổng số lần sử dụng có thể
    SoLuongDaDung INT DEFAULT 0,  -- Số lần đã sử dụng
    NgayBatDau DATETIME NOT NULL, 
    NgayKetThuc DATETIME NOT NULL
);


-- Bảng ThanhToan: Quản lý giao dịch thanh toán ngân hàng
CREATE TABLE ThanhToan (
    MaThanhToan INT PRIMARY KEY IDENTITY,
    MaHoaDon INT,
    PhuongThucThanhToan NVARCHAR(50),
    TaiKhoanNguoiDung NVARCHAR(100),
    TrangThai NVARCHAR(20), -- "ThanhCong", "ThatBai"
    ThoiGianThanhToan DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    
);

-- Bảng DanhGia: Đánh giá chuyến xe và tuyến xe
CREATE TABLE DanhGia (
    MaDanhGia INT PRIMARY KEY IDENTITY,
    MaNguoiDung INT,
    MaXe INT NULL, -- Liên kết với bảng ChuyenXe (nếu đánh giá chuyến cụ thể)
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
INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, SoDienThoai, Email, VaiTro, Token, TokenExpiry)
VALUES 
    ('nguyenan', 'hashed_password_1', 'Nguyen An', '0912345678', 'nguyenan@email.com', 'KhachHang', 'token_1', '2025-02-20 12:00'),
    ('admin01', 'hashed_password_2', 'Admin Quản Trị', '0909876543', 'admin01@email.com', 'QuanTri', 'token_2', '2025-02-20 12:00'),
    ('lethanh', 'hashed_password_3', 'Le Thanh', '0922334455', 'lethanh@email.com', 'TaiXe', 'token_3', '2025-02-20 12:00');

INSERT INTO XeKhach (BienSoXe, LoaiXe, SoChoNgoi)
VALUES 
    ('29B-12345', 'Xe khách giường nằm', 40),
    ('30A-67890', 'Xe khách ghế ngồi', 45),
    ('29C-11223', 'Xe khách giường nằm', 50),
    ('31D-44556', 'Xe khách ghế ngồi', 30),
    ('32E-78901', 'Xe khách giường nằm', 42);

	INSERT INTO TuyenXe (DiemDi, DiemDen, TrangThai)
VALUES (N'Hà Nội', N'Hải Phòng', N'Hoạt động');
INSERT INTO DiemDonTraKhach (MaTuyenXe, TenDiem, DiaChi, LoaiDiem)
VALUES (2, N'Bến xe Mỹ Đình', N'Mỹ Đình, Hà Nội', 'Don'),
       (2, N'Bến xe lll', N'Gia Lâm, Hà Nội', 'Tra');
INSERT INTO ChuyenXe (MaTuyenXe, ThoiGianKhoiHanh, ThoiGianDen, price, MaTaiXe, MaXe, TrangThai)
VALUES
    (2, '2025-02-20 08:00', '2025-02-20 12:00', 500000, 3, 1, 'ConVe'),
    (2, '2025-02-21 10:00', '2025-02-21 14:00', 600000, 3, 2, 'ConVe'),
    (2, '2025-02-22 07:30', '2025-02-22 11:30', 550000, 3, 3, 'ConVe'),
    (2, '2025-02-23 09:00', '2025-02-23 13:00', 650000, 3, 4, 'ConVe'),
    (2, '2025-02-24 11:00', '2025-02-24 15:00', 700000, 3, 5, 'ConVe');
	SELECT DiemDi, DiemDen FROM TuyenXe WHERE MaTuyenXe = 3
	select *from XeKhach	
	Select *from DiemDonTraKhach where MaTuyenXe = 2 and LoaiDiem='Tra'
	delete from TuyenXe Where MaTuyenXe=1
	