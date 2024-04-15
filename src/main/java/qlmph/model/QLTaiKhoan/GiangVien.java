package qlmph.model.QLTaiKhoan;

import java.util.Set;

import javax.persistence.*;

import qlmph.model.QLThongTin.LopHocPhanSection;

@Entity
@Table(name = "GiangVien")
public class GiangVien {
    @Id
    @Column(name = "MaGV")
    private String maGV;

    @Column(name = "MaChucDanh")
    private String maChucDanh;

    @OneToOne
    @JoinColumn(name = "MaGV", referencedColumnName = "MaNgMPH")
    private NguoiMuonPhong ttNgMPH;

    @OneToMany(mappedBy = "giangVien", fetch = FetchType.LAZY)
    private Set<LopHocPhanSection> lopHocPhanSections;

    @Override
    public String toString() {
        return "GiangVien [maGV=" + maGV + ", maChucDanh=" + maChucDanh + ", ttNgMPH=" + ttNgMPH + ", lopHocPhans="
                + lopHocPhanSections + "]";
    }

    public GiangVien() {
    }

    public GiangVien(String maGV, String maChucDanh) {
        this.maGV = maGV;
        this.maChucDanh = maChucDanh;
    }

    public String getMaGV() {
        return maGV;
    }

    public void setMaGV(String maGV) {
        this.maGV = maGV;
    }

    public String getMaChucDanh() {
        return maChucDanh;
    }

    public void setMaChucDanh(String maChucDanh) {
        this.maChucDanh = maChucDanh;
    }

    public NguoiMuonPhong getTtNgMPH() {
        return ttNgMPH;
    }

    public void setTtNgMPH(NguoiMuonPhong ttNgMPH) {
        this.ttNgMPH = ttNgMPH;
    }

    public Set<LopHocPhanSection> getLopHocPhans() {
        return lopHocPhanSections;
    }

    public void setLopHocPhans(Set<LopHocPhanSection> lopHocPhanSections) {
        this.lopHocPhanSections = lopHocPhanSections;
    }

}
