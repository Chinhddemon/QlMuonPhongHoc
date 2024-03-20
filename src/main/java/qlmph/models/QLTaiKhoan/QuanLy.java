package qlmph.models.QLTaiKhoan;

import java.sql.Date;

public class QuanLy {
    private int idQL;
    private String maQL;
    private String hoTen;
    private String email;
    private String sDT;
    private Date ngaySinh;
    private byte gioiTinh;

    public QuanLy() {
    }

    public QuanLy(int idQL, String maQL, String hoTen, String email, String sDT, Date ngaySinh, byte gioiTinh) {
        this.idQL = idQL;
        this.maQL = maQL;
        this.hoTen = hoTen;
        this.email = email;
        this.sDT = sDT;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
    }

    public int getIdQL() {
        return idQL;
    }

    public void setIdQL(int idQL) {
        this.idQL = idQL;
    }

    public String getMaQL() {
        return maQL;
    }

    public void setMaQL(String maQL) {
        this.maQL = maQL;
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

}