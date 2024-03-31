package qlmph.model.QLTaiKhoan;

import javax.persistence.*;

@Entity
@Table(name = "GiangVien")
public class GiangVien {
    @Id
    @Column(name = "MaGV")
    private String maGV;
    
    @OneToOne
    @JoinColumn(name = "MaGV", referencedColumnName = "MaNgMPH")
    private NguoiMuonPhong ttNgMPH;

    @Column(name = "ChucDanh")
    private String chucDanh;
    

    @Override
    public String toString() {
        return "GiangVien [maGV=" + maGV + ", ttNgMPH=" + ttNgMPH + ", chucDanh=" + chucDanh + "]";
    }

    public GiangVien() {
    }

    public GiangVien(String maGV, NguoiMuonPhong ttNgMPH, String chucDanh) {
        this.maGV = maGV;
        this.ttNgMPH = ttNgMPH;
        this.chucDanh = chucDanh;
    }

    public String getMaGV() {
        return maGV;
    }

    public void setMaGV(String maGV) {
        this.maGV = maGV;
    }

    public NguoiMuonPhong getTtNgMPH() {
        return ttNgMPH;
    }

    public void setTtNgMPH(NguoiMuonPhong ttNgMPH) {
        this.ttNgMPH = ttNgMPH;
    }

    public String getChucDanh() {
        return chucDanh;
    }

    public void setChucDanh(String chucDanh) {
        this.chucDanh = chucDanh;
    }

}
