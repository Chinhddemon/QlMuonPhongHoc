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

    public VaiTro() {
    }

    public VaiTro(short idVaiTro, String tenVaiTro) {
        this.idVaiTro = idVaiTro;
        this.tenVaiTro = tenVaiTro;
    }

    public short getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(short idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getTenVaiTro() {
        return tenVaiTro;
    }

    public void setTenVaiTro(String tenVaiTro) {
        this.tenVaiTro = tenVaiTro;
    }

}
