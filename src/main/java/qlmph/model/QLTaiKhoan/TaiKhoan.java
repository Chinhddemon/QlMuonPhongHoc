package QlMuonPhongHoc.model.QLTaiKhoan;

import java.util.UUID;
import java.sql.Timestamp;

public class TaiKhoan {
    private UUID IdTaiKhoan;
    private UUID IdVaiTro;
    private String TenDangNhap;
    private String Email;
    private String MatKhau;
    private Timestamp _CreateAt;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;

    public TaiKhoan() {
    }

    public TaiKhoan(UUID idVaiTro, String tenDangNhap, String matKhau) {
        IdVaiTro = idVaiTro;
        TenDangNhap = tenDangNhap;
        MatKhau = matKhau;
    }

    public TaiKhoan(UUID idTaiKhoan, UUID idVaiTro, String tenDangNhap, String email, String matKhau,
            Timestamp _CreateAt, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        IdTaiKhoan = idTaiKhoan;
        IdVaiTro = idVaiTro;
        TenDangNhap = tenDangNhap;
        Email = email;
        MatKhau = matKhau;
        this._CreateAt = _CreateAt;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }

    public UUID getIdTaiKhoan() {
        return IdTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        IdTaiKhoan = idTaiKhoan;
    }

    public UUID getIdVaiTro() {
        return IdVaiTro;
    }

    public void setIdVaiTro(UUID idVaiTro) {
        IdVaiTro = idVaiTro;
    }

    public String getTenDangNhap() {
        return TenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        TenDangNhap = tenDangNhap;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getMatKhau() {
        return MatKhau;
    }

    public void setMatKhau(String matKhau) {
        MatKhau = matKhau;
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
