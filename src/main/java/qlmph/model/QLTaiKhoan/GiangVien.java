package qlmph.model.QLTaiKhoan;

import java.util.Set;

import javax.persistence.*;

import qlmph.model.QLThongTin.LopHocPhan;

@Entity
@Table(name = "GiangVien")
public class GiangVien {
    @Id
    @Column(name = "MaGV")
    private String maGV;

    @Column(name = "ChucDanh")
    private String chucDanh;
    
    @OneToOne
    @JoinColumn(name = "MaGV", referencedColumnName = "MaNgMPH")
    private NguoiMuonPhong ttNgMPH;

    @OneToMany(mappedBy = "giangVien", fetch = FetchType.LAZY)
    private Set<LopHocPhan> lopHocPhans;

    @Override
    public String toString() {
        return "GiangVien [maGV=" + maGV + ", chucDanh=" + chucDanh + ", ttNgMPH=" + ttNgMPH + ", lopHocPhans="
                + lopHocPhans + "]";
    }

    public GiangVien(String maGV, String chucDanh) {
        this.maGV = maGV;
        this.chucDanh = chucDanh;
    }

    public String getMaGV() {
        return maGV;
    }

    public void setMaGV(String maGV) {
        this.maGV = maGV;
    }

    public String getChucDanh() {
        return chucDanh;
    }

    public void setChucDanh(String chucDanh) {
        this.chucDanh = chucDanh;
    }

    public NguoiMuonPhong getTtNgMPH() {
        return ttNgMPH;
    }

    public void setTtNgMPH(NguoiMuonPhong ttNgMPH) {
        this.ttNgMPH = ttNgMPH;
    }

    public Set<LopHocPhan> getLopHocPhans() {
        return lopHocPhans;
    }

    public void setLopHocPhans(Set<LopHocPhan> lopHocPhans) {
        this.lopHocPhans = lopHocPhans;
    }    

}
