package qlmph.Models.QLTaiKhoan;

import java.util.UUID;
import java.sql.Timestamp;

public class TaiKhoan {
    private UUID idTaiKhoan;
    private UUID idVaiTro;
    private String tenDangNhap;
    private String email;
    private String matKhau;
    private Timestamp _CreateAt;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;

    public TaiKhoan() {
    }

    public TaiKhoan(UUID idTaiKhoan, UUID idVaiTro, String tenDangNhap, String email, String matKhau,
            Timestamp _CreateAt, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        this.idTaiKhoan = idTaiKhoan;
        this.idVaiTro = idVaiTro;
        this.tenDangNhap = tenDangNhap;
        this.email = email;
        this.matKhau = matKhau;
        this._CreateAt = _CreateAt;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }

    public UUID getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public UUID getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(UUID idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public Timestamp get_CreateAt() {
        return _CreateAt;
    }

    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public Timestamp get_UpdateAt() {
        return _UpdateAt;
    }

    public void set_UpdateAt(Timestamp _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public Timestamp get_DeleteAt() {
        return _DeleteAt;
    }

    public void set_DeleteAt(Timestamp _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }

}
