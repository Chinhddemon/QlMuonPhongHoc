package qlmph.model.QLTaiKhoan;
import qlmph.model.QLThongTin.LopSV;

import javax.persistence.*;

@Entity
@Table(name = "SinhVien")
public class SinhVien {
    
    @Id
    @Column(name = "MaSV")
    private String maSV;
    
    @OneToOne
    @JoinColumn(name = "MaSV", referencedColumnName = "MaNgMPH")
    private NguoiMuonPhong ttNgMPH;
    
    @ManyToOne
    @JoinColumn(name = "MaLopSV", referencedColumnName = "MaLopSV")
    private LopSV lopSV;
    
    @Column(name = "ChucVu")
    private String chucVu;

    @Override
    public String toString() {
        return "SinhVien [maSV=" + maSV + ", ttNgMPH=" + ttNgMPH + ", lopSV=" + lopSV + ", chucVu=" + chucVu + "]";
    }

    public SinhVien() {
    }

    public SinhVien(String maSV, NguoiMuonPhong ttNgMPH, LopSV lopSV, String chucVu) {
        this.maSV = maSV;
        this.ttNgMPH = ttNgMPH;
        this.lopSV = lopSV;
        this.chucVu = chucVu;
    }

    public String getMaSV() {
        return maSV;
    }

    public void setMaSV(String maSV) {
        this.maSV = maSV;
    }

    public NguoiMuonPhong getTtNgMPH() {
        return ttNgMPH;
    }

    public void setTtNgMPH(NguoiMuonPhong ttNgMPH) {
        this.ttNgMPH = ttNgMPH;
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

}