package qlmph.model.QLTaiKhoan;

import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "VaiTro")
public class VaiTro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdVaiTro")
    private short idVaiTro;

    @Column(name = "MaVaiTro")
    private String maVaiTro;

    @OneToMany(mappedBy = "vaiTro")
    private Set<TaiKhoan> taiKhoans;

    @Override
    public String toString() {
        return "VaiTro [idVaiTro=" + idVaiTro + ", maVaiTro=" + maVaiTro + ", taiKhoans=" + taiKhoans + "]";
    }

    public VaiTro() {
    }

    public VaiTro(short idVaiTro, String maVaiTro) {
        this.idVaiTro = idVaiTro;
        this.maVaiTro = maVaiTro;
    }

    public short getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(short idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getMaVaiTro() {
        return maVaiTro;
    }

    public void setMaVaiTro(String maVaiTro) {
        this.maVaiTro = maVaiTro;
    }

    public Set<TaiKhoan> getTaiKhoans() {
        return taiKhoans;
    }

    public void setTaiKhoans(Set<TaiKhoan> taiKhoans) {
        this.taiKhoans = taiKhoans;
    }

}