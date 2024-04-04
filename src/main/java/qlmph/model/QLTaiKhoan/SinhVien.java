package qlmph.model.QLTaiKhoan;
import qlmph.model.QLThongTin.LopHocPhan;
import qlmph.model.QLThongTin.LopSV;

import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "SinhVien")
public class SinhVien {
    
    @Id
    @Column(name = "MaSV")
    private String maSV;
    
    @ManyToOne
    @JoinColumn(name = "MaLopSV", referencedColumnName = "MaLopSV")
    private LopSV lopSV;
    
    @Column(name = "ChucVu")
    private String chucVu;

    @OneToOne
    @JoinColumn(name = "MaSV", referencedColumnName = "MaNgMPH")
    private NguoiMuonPhong ttNgMPH;

    @ManyToMany(mappedBy = "sinhViens", fetch = FetchType.LAZY)
    @JoinTable(name = "DsMPH_LopHoc",
        joinColumns = @JoinColumn(name = "MaSV"), 
        inverseJoinColumns = @JoinColumn(name = "IdLHP"))
    private Set<LopHocPhan> lopHocPhans;

    @Override
    public String toString() {
        return "SinhVien [maSV=" + maSV + ", lopSV=" + lopSV + ", chucVu=" + chucVu + ", ttNgMPH=" + ttNgMPH
                + ", lopHocPhans=" + lopHocPhans + "]";
    }

    public SinhVien(String maSV, LopSV lopSV, String chucVu) {
        this.maSV = maSV;
        this.lopSV = lopSV;
        this.chucVu = chucVu;
    }

    public String getMaSV() {
        return maSV;
    }

    public void setMaSV(String maSV) {
        this.maSV = maSV;
    }

    public LopSV getLopSV() {
        return lopSV;
    }

    public void setLopSV(LopSV lopSV) {
        this.lopSV = lopSV;
    }

    public String getChucVu() {
        return chucVu;
    }

    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
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