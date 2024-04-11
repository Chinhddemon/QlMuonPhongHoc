package qlmph.model.QLThongTin;

import java.util.Date;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.utils.Converter;

@Entity
@Table(name = "LichMuonPhong")
public class LichMuonPhong {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdLMPH")
    private int idLMPH;
    
    @ManyToOne
    @JoinColumn(name = "IdLHPSection", referencedColumnName = "IdLHPSection")
    LopHocPhanSection lopHocPhanSection;

    @ManyToOne
    @JoinColumn(name = "IdPH", referencedColumnName = "IdPH")
    private PhongHoc phongHoc;

    @ManyToOne
    @JoinColumn(name = "MaQLKhoiTao", referencedColumnName = "MaQL")
    private QuanLy quanLyKhoiTao;

    @Column(name = "ThoiGian_BD")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_BD;

    @Column(name = "ThoiGian_KT")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_KT;

    @Column(name = "MucDich")
    private String mucDich;

    @Column(name = "LyDo")
    private String lyDo;

    @Column(name = "_CreateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt;

    @Column(name = "_UpdateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _UpdateAt;

    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    @OneToOne(mappedBy = "lichMuonPhong")
    private MuonPhongHoc muonPhongHoc;

    public LichMuonPhong() {
    }

    public LichMuonPhong(LopHocPhanSection lopHocPhanSection, PhongHoc phongHoc, QuanLy quanLyKhoiTao, Date thoiGian_BD,
            Date thoiGian_KT, String mucDich, String lyDo) {
        this.lopHocPhanSection = lopHocPhanSection;
        this.phongHoc = phongHoc;
        this.quanLyKhoiTao = quanLyKhoiTao;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.mucDich = mucDich;
        this.lyDo = lyDo;
    }

    public String getIdLMPH() {
        return Converter.intToStringNchar(idLMPH, 8);
    }

    public void setIdLMPH(int idLMPH) {
        this.idLMPH = idLMPH;
    }

    public LopHocPhanSection getLopHocPhanSection() {
        return lopHocPhanSection;
    }

    public void setLopHocPhanSections(LopHocPhanSection lopHocPhanSection) {
        this.lopHocPhanSection = lopHocPhanSection;
    }

    public PhongHoc getPhongHoc() {
        return phongHoc;
    }

    public void setPhongHoc(PhongHoc phongHoc) {
        this.phongHoc = phongHoc;
    }

    public QuanLy getQuanLyKhoiTao() {
        return quanLyKhoiTao;
    }

    public void setQuanLyKhoiTao(QuanLy quanLyKhoiTao) {
        this.quanLyKhoiTao = quanLyKhoiTao;
    }

    public String getThoiGian_BD() {
        return Converter.DateTimeToString(thoiGian_BD);
    }

    public void setThoiGian_BD(Date thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }

    public String getThoiGian_KT() {
        return Converter.DateTimeToString(thoiGian_KT);
    }

    public void setThoiGian_KT(Date thoiGian_KT) {
        this.thoiGian_KT = thoiGian_KT;
    }

    public String getMucDich() {
        return mucDich;
    }

    public void setMucDich(String mucDich) {
        this.mucDich = mucDich;
    }

    public String getLyDo() {
        return lyDo;
    }

    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }

    public String get_CreateAt() {
        return Converter.DateTimeToString(_CreateAt);
    }

    public void set_CreateAt(Date _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public String get_UpdateAt() {
        return Converter.DateTimeToString(_UpdateAt);
    }

    public void set_UpdateAt(Date _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public String get_DeleteAt() {
        return Converter.DateTimeToString(_DeleteAt);
    }

    public void set_DeleteAt(Date _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }

    public MuonPhongHoc getMuonPhongHoc() {
        return muonPhongHoc;
    }

    public void setMuonPhongHoc(MuonPhongHoc muonPhongHoc) {
        this.muonPhongHoc = muonPhongHoc;
    }
}