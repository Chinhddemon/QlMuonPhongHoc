package qlmph.model.user;

import java.util.List;

import javax.persistence.*;

@Entity
public class VaiTro {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idVaiTro;

    private String maVaiTro;

    private String tenVaiTro;

    private String moTaVaiTro;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "NhomVaiTro_TaiKhoan", joinColumns = @JoinColumn(name = "idVaiTro"), inverseJoinColumns = @JoinColumn(name = "idTaiKhoan"))
    private List<TaiKhoan> taiKhoans;

    public VaiTro() {
    }

    public int getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(int idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getMaVaiTro() {
        return maVaiTro;
    }

    public void setMaVaiTro(String maVaiTro) {
        this.maVaiTro = maVaiTro;
    }

    public String getTenVaiTro() {
        return tenVaiTro;
    }

    public void setTenVaiTro(String tenVaiTro) {
        this.tenVaiTro = tenVaiTro;
    }

    public String getMoTaVaiTro() {
        return moTaVaiTro;
    }

    public void setMoTaVaiTro(String moTaVaiTro) {
        this.moTaVaiTro = moTaVaiTro;
    }

    public List<TaiKhoan> getTaiKhoans() {
        return taiKhoans;
    }

    public void setTaiKhoans(List<TaiKhoan> taiKhoans) {
        this.taiKhoans = taiKhoans;
    }
}
