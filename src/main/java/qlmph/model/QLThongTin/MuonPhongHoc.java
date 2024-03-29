package qlmph.model.QLThongTin;

import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name = "MuonPhongHoc")
public class MuonPhongHoc {
    @Id
    @Column(name = "IdLMPH")
    private int idLMPH;

    @OneToOne
    @JoinColumn(name = "IdLMPH", referencedColumnName = "IdLMPH")
    private LichMuonPhong lichMuonPhong;

    @Column(name = "MaNgMPH")
    private String maNgMPH;

    @Column(name = "MaQLDuyet")
    private String maQLDuyet;

    @Column(name = "ThoiGian_MPH")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_MPH;

    @Column(name = "ThoiGian_TPH")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_TPH;

    @Column(name = "YeuCau")
    private String yeuCau;

    public MuonPhongHoc() {
    }

    public MuonPhongHoc(int idLMPH, String maNgMPH, String maQLDuyet, Date thoiGian_MPH, Date thoiGian_TPH,
            String yeuCau) {
        this.idLMPH = idLMPH;
        this.maNgMPH = maNgMPH;
        this.maQLDuyet = maQLDuyet;
        this.thoiGian_MPH = thoiGian_MPH;
        this.thoiGian_TPH = thoiGian_TPH;
        this.yeuCau = yeuCau;
    }

    public int getIdLMPH() {
        return idLMPH;
    }

    public void setIdLMPH(int idLMPH) {
        this.idLMPH = idLMPH;
    }

    public String getMaNgMPH() {
        return maNgMPH;
    }

    public void setMaNgMPH(String maNgMPH) {
        this.maNgMPH = maNgMPH;
    }

    public String getMaQLDuyet() {
        return maQLDuyet;
    }

    public void setMaQLDuyet(String maQLDuyet) {
        this.maQLDuyet = maQLDuyet;
    }

    public Date getThoiGian_MPH() {
        return thoiGian_MPH;
    }

    public void setThoiGian_MPH(Date thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }

    public Date getThoiGian_TPH() {
        return thoiGian_TPH;
    }

    public void setThoiGian_TPH(Date thoiGian_TPH) {
        this.thoiGian_TPH = thoiGian_TPH;
    }

    public String getYeuCau() {
        return yeuCau;
    }

    public void setYeuCau(String yeuCau) {
        this.yeuCau = yeuCau;
    }

}
