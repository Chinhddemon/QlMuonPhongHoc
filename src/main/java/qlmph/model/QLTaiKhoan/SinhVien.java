package qlmph.model.QLTaiKhoan;

import java.util.UUID;
import java.sql.Date;

public class SinhVien {
    private UUID IdSV;
    private UUID IdTaiKhoan;
    private String MaLopSV;
    private String HoTen;
    private Date NgaySinh;
    private boolean GioiTinh;
    private String Email;
    private String SDT;
    private String MaSV;
    private String ChucVu;
    
    public SinhVien() {
    }

    public SinhVien(UUID idSV, UUID idTaiKhoan, String maLopSV, String hoTen, Date ngaySinh, boolean gioiTinh,
            String email, String sDT, String maSV, String chucVu) {
        IdSV = idSV;
        IdTaiKhoan = idTaiKhoan;
        MaLopSV = maLopSV;
        HoTen = hoTen;
        NgaySinh = ngaySinh;
        GioiTinh = gioiTinh;
        Email = email;
        SDT = sDT;
        MaSV = maSV;
        ChucVu = chucVu;
    }
    public UUID getIdSV() {
        return IdSV;
    }
    public void setIdSV(UUID idSV) {
        IdSV = idSV;
    }
    public UUID getIdTaiKhoan() {
        return IdTaiKhoan;
    }
    public void setIdTaiKhoan(UUID idTaiKhoan) {
        IdTaiKhoan = idTaiKhoan;
    }
    public String getMaLopSV() {
        return MaLopSV;
    }
    public void setMaLopSV(String maLopSV) {
        MaLopSV = maLopSV;
    }
    public String getHoTen() {
        return HoTen;
    }
    public void setHoTen(String hoTen) {
        HoTen = hoTen;
    }
    public Date getNgaySinh() {
        return NgaySinh;
    }
    public void setNgaySinh(Date ngaySinh) {
        NgaySinh = ngaySinh;
    }
    public boolean isGioiTinh() {
        return GioiTinh;
    }
    public void setGioiTinh(boolean gioiTinh) {
        GioiTinh = gioiTinh;
    }
    public String getEmail() {
        return Email;
    }
    public void setEmail(String email) {
        Email = email;
    }
    public String getSDT() {
        return SDT;
    }
    public void setSDT(String sDT) {
        SDT = sDT;
    }
    public String getMaSV() {
        return MaSV;
    }
    public void setMaSV(String maSV) {
        MaSV = maSV;
    }
    public String getChucVu() {
        return ChucVu;
    }
    public void setChucVu(String chucVu) {
        ChucVu = chucVu;
    }

    
}
