package qlmph.model.QLTaiKhoan;

import qlmph.model.QLThongTin.LopSV;

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

    public String toString() {
        return "SinhVien [maSV=" + maSV + ", lopSV=" + lopSV + ", chucVu=" + chucVu + ", ttNgMPH=" + ttNgMPH
                + "]";
    }

    public SinhVien() {
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

}