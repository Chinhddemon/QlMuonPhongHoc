package qlmph.models.QLTaiKhoan;

import java.sql.Timestamp;
import java.util.UUID;

public class TaiKhoan {
    private UUID idTaiKhoan;
    private short idVaiTro;
    private String tenDangNhap;
    private String matKhau;
    private Timestamp _CreateAt;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;

    public TaiKhoan() {
    }

    public TaiKhoan(UUID idTaiKhoan, short idVaiTro, String tenDangNhap, String matKhau,
            Timestamp _CreateAt, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        this.idTaiKhoan = idTaiKhoan;
        this.idVaiTro = idVaiTro;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this._CreateAt = _CreateAt;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }

    public TaiKhoan(int idTaiKhoan, short idVaiTro, String tenDangNhap, String matKhau,
            Timestamp _CreateAt, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        this.idVaiTro = idVaiTro;
        this.tenDangNhap = tenDangNhap;
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

    public short getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(short idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
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
