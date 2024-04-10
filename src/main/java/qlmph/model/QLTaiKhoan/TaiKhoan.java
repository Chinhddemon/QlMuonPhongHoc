package qlmph.model.QLTaiKhoan;

import javax.persistence.*;

import org.hibernate.annotations.Type;

import java.util.Date;
import java.util.UUID;

import qlmph.utils.Converter;

@Entity
@Table(name = "TaiKhoan")
public class TaiKhoan {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdTaiKhoan")
    @Type(type = "uuid-char")
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

    public TaiKhoan(UUID idTaiKhoan, VaiTro vaiTro, String tenDangNhap, String matKhau, Date _deleteAt) {
        this.idTaiKhoan = idTaiKhoan;
        this.vaiTro = vaiTro;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this._deleteAt = _deleteAt;
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

    public String get_createAt() {
        return Converter.DateTimeToString(_createAt);
    }

    public void set_createAt(Date _createAt) {
        this._createAt = _createAt;
    }

    public String get_updateAt() {
        return Converter.DateTimeToString(_updateAt);
    }

    public void set_updateAt(Date _updateAt) {
        this._updateAt = _updateAt;
    }

    public String get_deleteAt() {
        return Converter.DateTimeToString(_deleteAt);
    }

    public void set_deleteAt(Date _deleteAt) {
        this._deleteAt = _deleteAt;
    }

}