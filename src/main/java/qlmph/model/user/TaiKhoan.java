package qlmph.model.user;

import javax.persistence.*;

import org.hibernate.annotations.Type;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@SuppressWarnings("deprecation")
@Entity
public class TaiKhoan {

    @Id
    @Type(type = "uuid-char")
    private UUID idTaiKhoan;

    private String tenDangNhap;

    private String matKhau;

    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt = new Date();

    @Temporal(TemporalType.TIMESTAMP)
    private Date _LastUpdateAt = new Date();

    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    private boolean _IsInactive = false;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "NhomVaiTro_TaiKhoan", joinColumns = @JoinColumn(name = "idTaiKhoan"), inverseJoinColumns = @JoinColumn(name = "idVaiTro"))
    private List<VaiTro> vaiTros;

    public TaiKhoan() {
    }

    public UUID getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
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

    public Date get_CreateAt() {
        return _CreateAt;
    }

    public void set_CreateAt(Date _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public Date get_LastUpdateAt() {
        return _LastUpdateAt;
    }

    public void set_LastUpdateAt(Date _LastUpdateAt) {
        this._LastUpdateAt = _LastUpdateAt;
    }

    public Date get_DeleteAt() {
        return _DeleteAt;
    }

    public void set_DeleteAt(Date _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }

    public boolean is_IsInactive() {
        return _IsInactive;
    }

    public void set_IsInactive(boolean _IsInactive) {
        this._IsInactive = _IsInactive;
    }

    public List<VaiTro> getVaiTros() {
        return vaiTros;
    }

    public void setVaiTros(List<VaiTro> vaiTros) {
        this.vaiTros = vaiTros;
    }
}