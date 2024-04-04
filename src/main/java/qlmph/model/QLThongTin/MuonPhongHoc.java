package qlmph.model.QLThongTin;

import java.util.Date;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.utils.Converter;

@Entity
@Table(name = "MuonPhongHoc")
public class MuonPhongHoc {
    @Id
    @Column(name = "IdLMPH")
    private int idLMPH;

    @Column(name = "MaNgMPH")
    private String maNgMPH;

    @ManyToOne
    @JoinColumn(name = "MaQLDuyet", referencedColumnName = "MaQL")
    private QuanLy quanLyDuyet;

    @Column(name = "ThoiGian_MPH")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_MPH;

    @Column(name = "ThoiGian_TPH")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_TPH;

    @Column(name = "YeuCau")
    private String yeuCau;
    
    @OneToOne
    @JoinColumn(name = "IdLMPH", referencedColumnName = "IdLMPH")
    private LichMuonPhong lichMuonPhong;

    @Override
    public String toString() {
        return "MuonPhongHoc [idLMPH=" + idLMPH + ", maNgMPH=" + maNgMPH + ", quanLyDuyet=" + quanLyDuyet
                + ", thoiGian_MPH=" + thoiGian_MPH + ", thoiGian_TPH=" + thoiGian_TPH + ", yeuCau=" + yeuCau
                + ", lichMuonPhong=" + lichMuonPhong + "]";
    }

    public MuonPhongHoc(int idLMPH, String maNgMPH, QuanLy quanLyDuyet, Date thoiGian_MPH, Date thoiGian_TPH,
            String yeuCau, LichMuonPhong lichMuonPhong) {
        this.idLMPH = idLMPH;
        this.maNgMPH = maNgMPH;
        this.quanLyDuyet = quanLyDuyet;
        this.thoiGian_MPH = thoiGian_MPH;
        this.thoiGian_TPH = thoiGian_TPH;
        this.yeuCau = yeuCau;
        this.lichMuonPhong = lichMuonPhong;
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

    public QuanLy getQuanLyDuyet() {
        return quanLyDuyet;
    }

    public void setQuanLyDuyet(QuanLy quanLyDuyet) {
        this.quanLyDuyet = quanLyDuyet;
    }

    public String getThoiGian_MPH() {
        return Converter.DateTimeToString(thoiGian_MPH);
    }

    public void setThoiGian_MPH(Date thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }

    public String getThoiGian_TPH() {
        return Converter.DateTimeToString(thoiGian_TPH);
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

    public LichMuonPhong getLichMuonPhong() {
        return lichMuonPhong;
    }

    public void setLichMuonPhong(LichMuonPhong lichMuonPhong) {
        this.lichMuonPhong = lichMuonPhong;
    }

}