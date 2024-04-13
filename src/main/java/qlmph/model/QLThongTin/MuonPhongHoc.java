package qlmph.model.QLThongTin;

import java.util.Date;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLTaiKhoan.QuanLy;

@Entity
@Table(name = "MuonPhongHoc")
public class MuonPhongHoc {
    @Id
    @Column(name = "IdLMPH")
    private int idLMPH;

    @ManyToOne
    @JoinColumn(name = "MaNgMPH", referencedColumnName = "MaNgMPH")
    private NguoiMuonPhong nguoiMuonPhong;

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

    public MuonPhongHoc() {
    }

    public MuonPhongHoc(int idLMPH, NguoiMuonPhong nguoiMuonPhong, QuanLy quanLyDuyet, Date thoiGian_MPH,
            Date thoiGian_TPH, String yeuCau) {
        this.idLMPH = idLMPH;
        this.nguoiMuonPhong = nguoiMuonPhong;
        this.quanLyDuyet = quanLyDuyet;
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

    public NguoiMuonPhong getNguoiMuonPhong() {
        return nguoiMuonPhong;
    }

    public void setNguoiMuonPhong(NguoiMuonPhong nguoiMuonPhong) {
        this.nguoiMuonPhong = nguoiMuonPhong;
    }

    public QuanLy getQuanLyDuyet() {
        return quanLyDuyet;
    }

    public void setQuanLyDuyet(QuanLy quanLyDuyet) {
        this.quanLyDuyet = quanLyDuyet;
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

public LichMuonPhong getLichMuonPhong() {
        return lichMuonPhong;
    }

    public void setLichMuonPhong(LichMuonPhong lichMuonPhong) {
        this.lichMuonPhong = lichMuonPhong;
    }

}