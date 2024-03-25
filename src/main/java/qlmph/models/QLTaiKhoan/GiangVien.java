package qlmph.models.QLTaiKhoan;

import java.sql.Date;
import java.util.UUID;

public class GiangVien {
    private UUID idGV;
    private UUID idTaiKhoan;
    private String maGV;
    private String hoTen;
    private String email;
    private String sDT;
    private Date ngaySinh;
    private byte gioiTinh;
    private String chucDanh;

    public GiangVien() {
    }

    public GiangVien(UUID idGV, UUID idTaiKhoan, String maGV, String hoTen, String email, String sDT, Date ngaySinh,
            byte gioiTinh, String chucDanh) {
        this.idGV = idGV;
        this.idTaiKhoan = idTaiKhoan;
        this.maGV = maGV;
        this.hoTen = hoTen;
        this.email = email;
        this.sDT = sDT;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
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

    public String getMaGV() {
        return maGV;
    }

    public void setMaGV(String maGV) {
        this.maGV = maGV;
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

    public String getChucDanh() {
        return chucDanh;
    }

    public void setChucDanh(String chucDanh) {
        this.chucDanh = chucDanh;
    }

}
