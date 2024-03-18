package qlmph.models.QLTaiKhoan;

import java.sql.Date;

public class SinhVien {
    private String idSV;
    private String idTaiKhoan;
    private String maLopSV;
    private String hoTen;
    private Date ngaySinh;
    private byte gioiTinh;
    private String email;
    private String sDT;
    private String maSV;
    private String chucVu;
    
    public SinhVien() {
    }

    public SinhVien(String idSV, String idTaiKhoan, String maLopSV, String hoTen, Date ngaySinh, byte gioiTinh,
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

    public String getIdSV() {
        return idSV;
    }

    public void setIdSV(String idSV) {
        this.idSV = idSV;
    }

    public String getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(String idTaiKhoan) {
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

    public byte isGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(byte gioiTinh) {
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
