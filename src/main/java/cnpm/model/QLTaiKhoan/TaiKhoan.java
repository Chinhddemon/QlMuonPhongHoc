package cnpm.model.QLTaiKhoan;

import java.sql.Timestamp;

public class TaiKhoan {
    private int IdTaiKhoan;
    private int IdVaiTro;
    private String TenDangNhap;
    private String Email;
    private String MatKhau;
    private Timestamp _CreateAt;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;
    
    public TaiKhoan() {
    }

    public TaiKhoan(int idTaiKhoan, int idVaiTro, String tenDangNhap, String email, String matKhau) {
        IdTaiKhoan = idTaiKhoan;
        IdVaiTro = idVaiTro;
        TenDangNhap = tenDangNhap;
        Email = email;
        MatKhau = matKhau;
    }

    public TaiKhoan(int idTaiKhoan, int idVaiTro, String tenDangNhap, String email, String matKhau, Timestamp _CreateAt,
            Timestamp _UpdateAt, Timestamp _DeleteAt) {
        IdTaiKhoan = idTaiKhoan;
        IdVaiTro = idVaiTro;
        TenDangNhap = tenDangNhap;
        Email = email;
        MatKhau = matKhau;
        this._CreateAt = _CreateAt;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }

    public int getIdTaiKhoan() {
        return IdTaiKhoan;
    }

    public void setIdTaiKhoan(int idTaiKhoan) {
        IdTaiKhoan = idTaiKhoan;
    }

    public int getIdVaiTro() {
        return IdVaiTro;
    }

    public void setIdVaiTro(int idVaiTro) {
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
