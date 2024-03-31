package qlmph.model.QLTaiKhoan;

import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "VaiTro")
public class VaiTro {

    @Id
    @Column(name = "IdVaiTro")
    private short idVaiTro;

    @OneToMany(mappedBy = "vaiTro")
    private Set<TaiKhoan> taiKhoans;

    @Column(name = "TenVaiTro")
    private String tenVaiTro;

    @Override
    public String toString() {
        return "VaiTro [idVaiTro=" + idVaiTro + ", taiKhoans=" + taiKhoans + ", tenVaiTro=" + tenVaiTro + "]";
    }

    public VaiTro() {
    }

    public VaiTro(short idVaiTro, Set<TaiKhoan> taiKhoans, String tenVaiTro) {
        this.idVaiTro = idVaiTro;
        this.taiKhoans = taiKhoans;
        this.tenVaiTro = tenVaiTro;
    }

    public short getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(short idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public Set<TaiKhoan> getTaiKhoans() {
        return taiKhoans;
    }

    public void setTaiKhoans(Set<TaiKhoan> taiKhoans) {
        this.taiKhoans = taiKhoans;
    }

    public String getTenVaiTro() {
        return tenVaiTro;
    }

    public void setTenVaiTro(String tenVaiTro) {
        this.tenVaiTro = tenVaiTro;
    }

}
