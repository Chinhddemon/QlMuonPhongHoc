package qlmph.Models.QLTaiKhoan;

import java.util.UUID;
import java.sql.Date;

public class SinhVien {
    private UUID idSV;
    private UUID idTaiKhoan;
    private String maLopSV;
    private String hoTen;
    private Date ngaySinh;
    private Boolean gioiTinh;
    private String email;
    private String sDT;
    private String maSV;
    private String chucVu;
    
    public SinhVien() {
    }

    public SinhVien(UUID idSV, UUID idTaiKhoan, String maLopSV, String hoTen, Date ngaySinh, boolean gioiTinh,
            String email, String sDT, String maSV, String chucVu) {
        this.idSV = idSV;
        this.idTaiKhoan = idTaiKhoan;
        this.maLopSV = maLopSV;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.email = email;
        this.sDT = sDT;
        this.maSV = maSV;
        this.chucVu = chucVu;
    }

    public UUID getIdSV() {
        return idSV;
    }

    public void setIdSV(UUID idSV) {
        this.idSV = idSV;
    }

    public UUID getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public String getMaLopSV() {
        return maLopSV;
    }

    public void setMaLopSV(String maLopSV) {
        this.maLopSV = maLopSV;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public Date getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public boolean isGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(boolean gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getsDT() {
        return sDT;
    }

    public void setsDT(String sDT) {
        this.sDT = sDT;
    }

    public String getMaSV() {
        return maSV;
    }

    public void setMaSV(String maSV) {
        this.maSV = maSV;
    }

    public String getChucVu() {
        return chucVu;
    }

    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
    }

}
