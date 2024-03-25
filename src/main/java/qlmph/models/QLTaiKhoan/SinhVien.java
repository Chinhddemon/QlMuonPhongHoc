package qlmph.models.QLTaiKhoan;

import java.sql.Date;
import java.util.UUID;

public class SinhVien {
    private UUID idSV;
    private UUID idTaiKhoan;
    private String maLopSV;
    private String maSV;
    private String hoTen;
    private String email;
    private String sDT;
    private Date ngaySinh;
    private byte gioiTinh;
    private String chucVu;
    
    public SinhVien() {
    }

    public SinhVien(UUID idSV, UUID idTaiKhoan, String maLopSV, String maSV, String hoTen, String email, String sDT,
            Date ngaySinh, byte gioiTinh, String chucVu) {
        this.idSV = idSV;
        this.idTaiKhoan = idTaiKhoan;
        this.maLopSV = maLopSV;
        this.maSV = maSV;
        this.hoTen = hoTen;
        this.email = email;
        this.sDT = sDT;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
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

    public String getMaSV() {
        return maSV;
    }

    public void setMaSV(String maSV) {
        this.maSV = maSV;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
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

    public Date getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public byte getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(byte gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getChucVu() {
        return chucVu;
    }

    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
    }

}
