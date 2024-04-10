USE [QLMPH123]
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (3, N'Admin')
INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (2, N'Manager')
INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (1, N'User')
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'2cb6915f-d041-4714-aa6d-102da2a39fdf', 3, N'thanhadmin', N'12345                                                       ', CAST(N'2024-04-09T21:42:48.967' AS DateTime), CAST(N'2024-04-09T21:42:48.970' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'd19370ae-e8ae-4e75-a16d-156ddda7093f', 3, N'vinhadmin', N'12345                                                       ', CAST(N'2024-04-09T21:43:06.933' AS DateTime), CAST(N'2024-04-09T21:43:06.937' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', 2, N'hymanager', N'1234                                                        ', CAST(N'2024-04-09T21:41:37.697' AS DateTime), CAST(N'2024-04-10T08:27:47.093' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', 1, N'hyuser123', N'123                                                         ', CAST(N'2024-04-09T21:40:25.173' AS DateTime), CAST(N'2024-04-10T08:17:21.910' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', 1, N'huynhtrungtru', N'123                                                         ', CAST(N'2024-04-10T07:29:36.183' AS DateTime), CAST(N'2024-04-10T08:15:29.710' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'65d509ee-934e-419c-bd1f-65d7df3349fc', 2, N'vinhmanager', N'1234                                                        ', CAST(N'2024-04-09T21:42:16.800' AS DateTime), CAST(N'2024-04-10T08:30:45.170' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', 1, N'phanthanhhy', N'123                                                         ', CAST(N'2024-04-10T07:29:50.487' AS DateTime), CAST(N'2024-04-10T08:15:38.373' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', 1, N'tranconghung', N'123                                                         ', CAST(N'2024-04-10T07:29:24.840' AS DateTime), CAST(N'2024-04-10T08:15:19.910' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'2cd1b2c1-ebb9-455c-88f8-9c5601732aff', 3, N'chinhadmin', N'12345                                                       ', CAST(N'2024-04-09T21:42:36.547' AS DateTime), CAST(N'2024-04-09T21:42:36.550' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'83de2683-d635-4b82-b007-a17cf9c9440b', 2, N'thanhmanager', N'1234                                                        ', CAST(N'2024-04-09T21:42:04.833' AS DateTime), CAST(N'2024-04-10T08:32:41.407' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', 1, N'thanhuser123', N'123                                                         ', CAST(N'2024-04-09T21:40:56.270' AS DateTime), CAST(N'2024-04-10T08:18:11.370' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'95df343c-aed7-4f7e-8d33-c50b95fc38d0', 1, N'chinhuser123', N'123                                                         ', CAST(N'2024-04-09T21:40:43.350' AS DateTime), CAST(N'2024-04-10T08:17:46.990' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'03be9fc9-00ff-4ad6-81c9-cc8f09b890b2', 3, N'caohyadmin', N'12345                                                       ', CAST(N'2024-04-09T21:43:36.733' AS DateTime), CAST(N'2024-04-09T21:43:36.737' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', 2, N'chinhmanager', N'1234                                                        ', CAST(N'2024-04-09T21:41:53.823' AS DateTime), CAST(N'2024-04-10T08:34:00.700' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'1cf67def-6367-4b80-a066-ef57ce83996b', 1, N'luunguyenkythu', N'123                                                         ', CAST(N'2024-04-10T07:28:48.910' AS DateTime), CAST(N'2024-04-10T08:15:45.250' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', 1, N'vinhuser123', N'123                                                         ', CAST(N'2024-04-09T21:41:09.473' AS DateTime), CAST(N'2024-04-10T08:18:30.260' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'757c4419-14c1-49ef-821c-ff0bb63b8b60', 1, N'bichnguyenuser', N'123                                                         ', CAST(N'2024-04-10T07:28:26.127' AS DateTime), CAST(N'2024-04-10T08:16:06.460' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[DoiTuongNgMPH] ON 

INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [MaDoiTuongNgMPH]) VALUES (3, N'GV')
INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [MaDoiTuongNgMPH]) VALUES (4, N'SV')
SET IDENTITY_INSERT [dbo].[DoiTuongNgMPH] OFF
GO
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV01', N'e8fb1a9e-9b75-4d59-a931-7776758b0d7a', 3, N'Trần Công Hùng', N'tranhung@gmail.com', N'0917274529      ', CAST(N'1996-03-03' AS Date), 0, N'Hồ Chí Minh, Man Thiện')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV02', N'4bc66769-4ba4-4d16-b8b0-5bb250364a7c', 3, N'Huỳnh Trung Trụ', N'trungtru@gmail.com', N'0987475677      ', CAST(N'1997-09-02' AS Date), 0, N'Hồ Chí Minh, Man Thiện')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV03', N'284f4c88-0dc2-41e0-9704-675ffff4d9dc', 3, N'Phan Thanh Hy', N'thanhhy@gmail.com', N'0904858378      ', CAST(N'1990-09-06' AS Date), 0, N'\Hồ Chí Minh, Man Thiện')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV04', N'1cf67def-6367-4b80-a066-ef57ce83996b', 3, N'Lưu Nguyễn Kỳ thư', N'kythu@gmail.com', N'0792890550      ', CAST(N'1990-09-07' AS Date), 1, N'Hồ Chí Minh, Man Thiện')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV05', N'757c4419-14c1-49ef-821c-ff0bb63b8b60', 3, N'Nguyễn Thị Bích Nguyên', N'bichnguyen@gmail.com', N'0908465996      ', CAST(N'1990-07-07' AS Date), 0, N'Hồ Chí Minh, Man Thiện')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN011', N'95df343c-aed7-4f7e-8d33-c50b95fc38d0', 4, N'Thái Văn Anh Chính', N'n21dccn011@student.ptithcm.edu.vn', N'0904863784      ', CAST(N'2003-07-07' AS Date), 1, N'Hồ Chí Minh, Việt Nam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN040', N'1da9e1ea-a40c-4ead-8fd7-33ef116a6251', 4, N'Ngô Cao Hy', N'n21dccn040@student.ptithcm.edu.vn', N'0794895090      ', CAST(N'2003-06-06' AS Date), 1, N'Hồ Chí Minh, Phạm Thế Hiển')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN077', N'89ebb2e4-49f3-4480-848a-bc572ce1f39f', 4, N'Lưu Văn Thành', N'n21dccn077@student.ptithcm.edu.vn', N'0907658389      ', CAST(N'2003-07-09' AS Date), 1, N'Hồ Chí Minh, Việt Nam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'N21DCCN094', N'a9900d7c-be56-48e9-a11b-f3c108aff7a9', 4, N'Nguyễn Hữu Vinh', N'n21dccn094@student.ptithcm.edu.vn', N'0936473884      ', CAST(N'2003-09-08' AS Date), 1, N'Hồ Chí Minh, Việt Nam')
GO
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D20CQCN01-N', 2020, 2025, 1, N'Công Nghệ Thông Tin', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D20CQDTDT01-N', 2020, 2024, 5, N'Công Nghệ Kỹ Thuật Điện', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21CQAT01-N', 2021, 2026, 7, N'An toàn Thông Tin', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21CQCN01-N', 2021, 2026, 1, N'Công Nghệ Thông Tin 2', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21CQCN02-N', 2021, 2026, 1, N'Công Nghệ Thông Tin ', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D21TXVTMD01-N', 2021, 2026, 4, N'Kỹ Thuật Điện Tử Viễn Thông', N'TX')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D22CQQT01-N', 2022, 2026, 6, N'Quản Trị Kinh Doanh', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D23CQKT01-N', 2023, 2027, 2, N'Kế Toán', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'D23CQPT02-N', 2023, 2027, 3, N'Công Nghệ Đa Phương Tiện', N'CQ')
GO
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN011', N'D21CQCN01-N', N'LT')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN040', N'D21CQCN01-N', N'TV')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN077', N'D21CQCN01-N', N'LP')
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'N21DCCN094', N'D21CQCN01-N', N'TV')
GO
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'BAS1153', N'Lịch Sử Đảng Cộng Sản Việt Nam', CAST(N'2024-04-09T20:36:44.300' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'BAS1160', N'Tiếng Anh Course 3', CAST(N'2024-04-09T20:45:37.820' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT 1359-3', N'Toán Rời Rạc 2', CAST(N'2024-04-09T20:52:37.833' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1306', N'Cấu Trúc Dữ Liệu Giai Thuật', CAST(N'2024-04-09T20:52:05.327' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1313', N'Cơ Sở Dữ Liệu', CAST(N'2024-04-09T20:47:06.750' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT13145', N'Kiến Trúc Máy Tính', CAST(N'2024-04-09T20:53:09.613' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT13147', N'Thực Tập Cở Sở', CAST(N'2024-04-09T20:38:20.850' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT13162', N'Lập Trình Python', CAST(N'2024-04-09T20:46:13.613' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1319', N'Hệ Điều Hành', CAST(N'2024-04-09T20:36:02.040' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1332', N'Lập Trình Hướng Đối Tượng', CAST(N'2024-04-09T20:50:45.800' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1336', N'Mạng Máy Tính', CAST(N'2024-04-09T20:50:07.240' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1340', N'Nhập Môn Công Nghệ Phần Mềm', CAST(N'2024-04-09T20:37:45.010' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1341', N'Nhập Môn Trí Tuệ nhân tạo', CAST(N'2024-04-09T20:34:38.540' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'INT1434-3', N'Lập Trình Web', CAST(N'2024-04-09T20:38:50.883' AS DateTime))
GO
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'GV01', N'Tiến Sĩ')
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'GV02', N'Tiến Sĩ')
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'GV03', N'Tiến Sĩ')
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'GV04', N'Tiến Sĩ')
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'GV05', N'Thạc Sĩ')
GO
SET IDENTITY_INSERT [dbo].[LopHocPhan] ON 

INSERT [dbo].[LopHocPhan] ([IdLHP], [MaGVGiangDay], [MaMH], [MaLopSV], [Ngay_BD], [Ngay_KT], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (1, N'GV01', N'INT13145', N'D20CQDTDT01-N', CAST(N'2024-04-10' AS Date), CAST(N'2024-04-11' AS Date), CAST(N'2024-04-10T09:03:08.373' AS DateTime), CAST(N'2024-04-10T14:12:38.790' AS DateTime), NULL)
INSERT [dbo].[LopHocPhan] ([IdLHP], [MaGVGiangDay], [MaMH], [MaLopSV], [Ngay_BD], [Ngay_KT], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (3, N'GV02', N'INT13147', N'D21CQCN01-N', CAST(N'2024-04-11' AS Date), CAST(N'2024-04-12' AS Date), CAST(N'2024-04-10T09:04:47.640' AS DateTime), CAST(N'2024-04-10T14:12:35.477' AS DateTime), NULL)
INSERT [dbo].[LopHocPhan] ([IdLHP], [MaGVGiangDay], [MaMH], [MaLopSV], [Ngay_BD], [Ngay_KT], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (5, N'GV03', N'INT1306', N'D21CQAT01-N', CAST(N'2024-04-13' AS Date), CAST(N'2024-04-14' AS Date), CAST(N'2024-04-10T09:06:11.783' AS DateTime), CAST(N'2024-04-10T14:12:31.650' AS DateTime), NULL)
INSERT [dbo].[LopHocPhan] ([IdLHP], [MaGVGiangDay], [MaMH], [MaLopSV], [Ngay_BD], [Ngay_KT], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (6, N'GV04', N'INT1340', N'D20CQCN01-N', CAST(N'2024-04-15' AS Date), CAST(N'2024-04-16' AS Date), CAST(N'2024-04-10T09:07:14.600' AS DateTime), CAST(N'2024-04-10T14:12:26.690' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LopHocPhan] OFF
GO
SET IDENTITY_INSERT [dbo].[PhongHoc] ON 

INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (1, N'2A23', 60, N'A', CAST(N'2024-04-09T21:23:28.587' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (3, N'2A26', 60, N'U', CAST(N'2024-04-09T21:26:08.447' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (4, N'2A27', 60, N'M', CAST(N'2024-04-09T21:26:31.210' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (5, N'2E16', 40, N'A', CAST(N'2024-04-09T21:28:42.453' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (6, N'2E17', 40, N'U', CAST(N'2024-04-09T21:29:04.043' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (7, N'2E15', 40, N'M', CAST(N'2024-04-09T21:29:22.310' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (8, N'2A08', 150, N'A', CAST(N'2024-04-09T21:29:56.130' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (9, N'2A16', 150, N'U', CAST(N'2024-04-09T21:30:09.420' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (10, N'2A35', 60, N'M', CAST(N'2024-04-09T21:30:53.510' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (11, N'2B24', 80, N'A', CAST(N'2024-04-09T21:32:20.880' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (12, N'2B25', 80, N'U', CAST(N'2024-04-09T21:32:37.880' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (13, N'2B27', 80, N'M', CAST(N'2024-04-09T21:32:50.230' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (14, N'2A2425', 100, N'A', CAST(N'2024-04-09T21:33:48.567' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (15, N'SAN-B1', 200, N'A', CAST(N'2024-04-09T21:34:20.560' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (16, N'2D05', 10, N'A', CAST(N'2024-04-09T21:36:41.147' AS DateTime))
SET IDENTITY_INSERT [dbo].[PhongHoc] OFF
GO
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL01', N'2ba7ff44-23b8-43e8-a6f2-2bda93a416f7', N'Hy Manager', N'hymanager@gmail.com', N'0794058390      ', CAST(N'1991-10-15' AS Date), 1, N'Hồ Chí Minh, Thủ Đức')
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL02', N'65d509ee-934e-419c-bd1f-65d7df3349fc', N'Vinh Manager', N'vinhmanager@gmail.com', N'0783849559      ', CAST(N'1990-04-09' AS Date), 1, N'Hồ Chí Minh, Man Thiện')
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL03', N'83de2683-d635-4b82-b007-a17cf9c9440b', N'Thành Manager', N'thanhmanager@gmail.com', N'0906968495      ', CAST(N'1992-08-08' AS Date), 1, N'Hồ Chí Minh, Thủ Đức')
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL04', N'c5c37d60-6c8c-4c54-8be2-ecb9c604a090', N'Chính Manager', N'chinhmanager@gmail.com', N'0984757686      ', CAST(N'1990-09-09' AS Date), 1, N'Hồ Chí Minh, Thử Đức')
GO
SET IDENTITY_INSERT [dbo].[LichMuonPhong] ON 

INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (155, 1, 3, N'QL01', CAST(N'2024-04-11T07:03:08.400' AS DateTime), CAST(N'2024-04-11T11:03:09.373' AS DateTime), N'LT', N'Giang day', CAST(N'2024-04-10T09:57:32.073' AS DateTime), CAST(N'2024-04-10T14:05:35.950' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (156, 5, 1, N'QL02', CAST(N'2024-04-10T13:00:00.000' AS DateTime), CAST(N'2024-04-10T16:00:00.000' AS DateTime), N'TH', N'Thực Hành', CAST(N'2024-04-10T13:40:51.240' AS DateTime), CAST(N'2024-04-10T14:05:41.433' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (158, 8, 5, N'QL03', CAST(N'2024-04-13T07:00:00.000' AS DateTime), CAST(N'2024-04-13T11:00:00.000' AS DateTime), N'U ', N'Họp', CAST(N'2024-04-10T13:42:51.100' AS DateTime), CAST(N'2024-04-10T14:06:55.397' AS DateTime), NULL)
INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (159, 11, 6, N'QL04', CAST(N'2024-04-15T13:00:00.000' AS DateTime), CAST(N'2024-04-15T16:00:00.000' AS DateTime), N'LT', N'Giang Day', CAST(N'2024-04-10T13:44:15.427' AS DateTime), CAST(N'2024-04-10T14:08:12.757' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LichMuonPhong] OFF
GO
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau]) VALUES (155, N'N21DCCN040', N'QL01', CAST(N'2024-04-11T07:15:08.400' AS DateTime), CAST(N'2024-04-11T10:00:09.373' AS DateTime), N'chìa khóa, micro')
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau]) VALUES (156, N'GV01', N'QL02', CAST(N'2024-04-10T13:10:00.000' AS DateTime), CAST(N'2024-04-10T16:00:00.000' AS DateTime), N'chìa khóa')
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau]) VALUES (158, N'N21DCCN011', N'QL03', CAST(N'2024-04-13T10:00:00.000' AS DateTime), CAST(N'2024-04-13T12:00:00.000' AS DateTime), N'chìa khóa, micro')
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau]) VALUES (159, N'GV03', N'QL04', CAST(N'2024-04-15T13:00:00.000' AS DateTime), CAST(N'2024-04-15T16:00:00.000' AS DateTime), N'chìa khóa , micro')
GO
INSERT [dbo].[DsMPH_LopHoc] ([IdLHP], [MaNgMPH], [_UpdateAt]) VALUES (1, N'GV01', CAST(N'2024-04-10T14:12:38.790' AS DateTime))
INSERT [dbo].[DsMPH_LopHoc] ([IdLHP], [MaNgMPH], [_UpdateAt]) VALUES (3, N'GV02', CAST(N'2024-04-10T14:12:35.477' AS DateTime))
INSERT [dbo].[DsMPH_LopHoc] ([IdLHP], [MaNgMPH], [_UpdateAt]) VALUES (5, N'GV03', CAST(N'2024-04-10T14:12:31.650' AS DateTime))
INSERT [dbo].[DsMPH_LopHoc] ([IdLHP], [MaNgMPH], [_UpdateAt]) VALUES (6, N'GV04', CAST(N'2024-04-10T14:12:26.690' AS DateTime))
GO
