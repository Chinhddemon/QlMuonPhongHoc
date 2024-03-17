package qlmph.models.QLTaiKhoan;

import java.util.UUID;
import java.sql.Date;

public class QuanLy {
    private UUID idQL;
    private UUID idTaiKhoan;
    private String hoTen;
    private Date ngaySinh;
    private Boolean gioiTinh;
    private String email;
    private String sDT;

    public QuanLy() {
    }

    public QuanLy(UUID idQL, UUID idTaiKhoan, String hoTen, Date ngaySinh, boolean gioiTinh, String email, String sDT) {
        this.idQL = idQL;
        this.idTaiKhoan = idTaiKhoan;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.email = email;
        this.sDT = sDT;
    }

    public UUID getIdQL() {
        return idQL;
    }

    public void setIdQL(UUID idQL) {
        this.idQL = idQL;
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

}