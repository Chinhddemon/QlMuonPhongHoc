package qlmph.Models.QLTaiKhoan;

import java.util.UUID;
import java.sql.Date;

public class GiangVien {
    private UUID idGV;
    private UUID idTaiKhoan;
    private String hoTen;
    private Date ngaySinh;
    private Boolean gioiTinh;
    private String email;
    private String sDT;
    private String maGV;
    private String chucDanh;
    
    public GiangVien() {
    }

    public GiangVien(UUID idGV, UUID idTaiKhoan, String hoTen, Date ngaySinh, boolean gioiTinh, String email,
            String sDT, String maGV, String chucDanh) {
        this.idGV = idGV;
        this.idTaiKhoan = idTaiKhoan;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.email = email;
        this.sDT = sDT;
        this.maGV = maGV;
        this.chucDanh = chucDanh;
    }

    public UUID getIdGV() {
        return idGV;
    }

    public void setIdGV(UUID idGV) {
        this.idGV = idGV;
    }

    public UUID getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
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

    public String getMaGV() {
        return maGV;
    }

    public void setMaGV(String maGV) {
        this.maGV = maGV;
    }

    public String getChucDanh() {
        return chucDanh;
    }

    public void setChucDanh(String chucDanh) {
        this.chucDanh = chucDanh;
    }
    
}
