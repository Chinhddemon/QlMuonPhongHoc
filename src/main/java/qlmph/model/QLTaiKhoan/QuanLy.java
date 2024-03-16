package qlmph.model.QLTaiKhoan;

import java.util.UUID;
import java.sql.Date;

public class QuanLy {
    private UUID IdQL;
    private UUID IdTaiKhoan;
    private String HoTen;
    private Date NgaySinh;
    private boolean GioiTinh;
    private String Email;
    private String SDT;

    public QuanLy() {
    }

    public QuanLy(UUID idQL, UUID idTaiKhoan, String hoTen, Date ngaySinh, boolean gioiTinh, String email, String sDT) {
        IdQL = idQL;
        IdTaiKhoan = idTaiKhoan;
        HoTen = hoTen;
        NgaySinh = ngaySinh;
        GioiTinh = gioiTinh;
        Email = email;
        SDT = sDT;
    }

    public UUID getIdQL() {
        return IdQL;
    }

    public void setIdQL(UUID idQL) {
        IdQL = idQL;
    }

    public UUID getIdTaiKhoan() {
        return IdTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        IdTaiKhoan = idTaiKhoan;
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
    
}