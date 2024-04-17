package qlmph.model;

import java.util.Set;

import javax.persistence.*;

@Entity
public class DoiTuongNgMPH {
    @Id
    @Column(name = "IdDoiTuongNgMPH")
    private short idDoiTuongNgMPH;

    @Column(name = "MaDoiTuongNgMPH")
    private String maDoiTuongNgMPH;

    @OneToMany(mappedBy = "doiTuongNgMPH")
    private Set<NguoiMuonPhong> nguoiMuonPhongs;

    @Override
    public String toString() {
        return "DoiTuongNgMPH [idDoiTuongNgMPH=" + idDoiTuongNgMPH + ", maDoiTuongNgMPH=" + maDoiTuongNgMPH
                + ", nguoiMuonPhongs=" + nguoiMuonPhongs + "]";
    }

    public DoiTuongNgMPH() {
    }

    public DoiTuongNgMPH(short idDoiTuongNgMPH, String maDoiTuongNgMPH) {
        this.idDoiTuongNgMPH = idDoiTuongNgMPH;
        this.maDoiTuongNgMPH = maDoiTuongNgMPH;
    }

    public short getIdDoiTuongNgMPH() {
        return idDoiTuongNgMPH;
    }

    public void setIdDoiTuongNgMPH(short idDoiTuongNgMPH) {
        this.idDoiTuongNgMPH = idDoiTuongNgMPH;
    }

    public String getMaDoiTuongNgMPH() {
        return maDoiTuongNgMPH;
    }

    public void setMaDoiTuongNgMPH(String maDoiTuongNgMPH) {
        this.maDoiTuongNgMPH = maDoiTuongNgMPH;
    }

    public Set<NguoiMuonPhong> getNguoiMuonPhongs() {
        return nguoiMuonPhongs;
    }

    public void setNguoiMuonPhongs(Set<NguoiMuonPhong> nguoiMuonPhongs) {
        this.nguoiMuonPhongs = nguoiMuonPhongs;
    }

}
