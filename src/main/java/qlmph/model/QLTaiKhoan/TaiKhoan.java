package qlmph.model.QLTaiKhoan;

import javax.persistence.*;

import java.sql.Timestamp;
import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "TaiKhoan")
public class TaiKhoan {
    
    @Id
    @Column(name = "IdTaiKhoan")
    private UUID idTaiKhoan;
    
    @ManyToOne
    @JoinColumn(name = "IdVaiTro", referencedColumnName = "IdVaiTro")
    private VaiTro vaiTro;
    
    @Column(name = "TenDangNhap")
    private String tenDangNhap;
    
    @Column(name = "MatKhau")
    private String matKhau;
    
    @Column(name = "_CreateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _createAt;
    
    @Column(name = "_UpdateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _updateAt;
    
    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _deleteAt;

    @Override
    public String toString() {
        return "TaiKhoan [idTaiKhoan=" + idTaiKhoan + ", vaiTro=" + vaiTro + ", tenDangNhap=" + tenDangNhap
                + ", matKhau=" + matKhau + ", _createAt=" + _createAt + ", _updateAt=" + _updateAt + ", _deleteAt="
                + _deleteAt + "]";
    }

    public TaiKhoan() {
    }

    public UUID getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public VaiTro getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(VaiTro vaiTro) {
        this.vaiTro = vaiTro;
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

    public Date get_createAt() {
        return _createAt;
    }

    public void set_createAt(Date _createAt) {
        this._createAt = _createAt;
    }

    public Date get_updateAt() {
        return _updateAt;
    }

    public void set_updateAt(Date _updateAt) {
        this._updateAt = _updateAt;
    }

    public Date get_deleteAt() {
        return _deleteAt;
    }

    public void set_deleteAt(Date _deleteAt) {
        this._deleteAt = _deleteAt;
    }

    public TaiKhoan(UUID idTaiKhoan, VaiTro vaiTro, String tenDangNhap, String matKhau, Timestamp _createAt, Timestamp _updateAt,
        Timestamp _deleteAt) {
        this.idTaiKhoan = idTaiKhoan;
        this.vaiTro = vaiTro;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this._createAt = _createAt;
        this._updateAt = _updateAt;
        this._deleteAt = _deleteAt;
    }

}