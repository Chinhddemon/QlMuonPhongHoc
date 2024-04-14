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

    @Column(name = "LyDo")
    private String lyDo;

    @Column(name = "_CreateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt = new Date();

    @Column(name = "_UpdateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _UpdateAt = new Date();

    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    @OneToOne(mappedBy = "lichMuonPhong")
    private MuonPhongHoc muonPhongHoc;

    public LichMuonPhong() {
    }

    public LichMuonPhong(int idLMPH, LopHocPhanSection lopHocPhanSection, PhongHoc phongHoc, QuanLy quanLyKhoiTao,
            Date thoiGian_BD, Date thoiGian_KT, String lyDo) {
        this.idLMPH = idLMPH;
        this.lopHocPhanSection = lopHocPhanSection;
        this.phongHoc = phongHoc;
        this.quanLyKhoiTao = quanLyKhoiTao;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.lyDo = lyDo;
    }

    public LichMuonPhong(LopHocPhanSection lopHocPhanSection, PhongHoc phongHoc, QuanLy quanLyKhoiTao, Date thoiGian_BD,
            Date thoiGian_KT) {
        this.lopHocPhanSection = lopHocPhanSection;
        this.phongHoc = phongHoc;
        this.quanLyKhoiTao = quanLyKhoiTao;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
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

    public void setLopHocPhanSection(LopHocPhanSection lopHocPhanSection) {
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

    public Date getThoiGian_BD() {
        return thoiGian_BD;
    }

    public void setThoiGian_BD(Date thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }

    public Date getThoiGian_KT() {
        return thoiGian_KT;
    }

    public void setThoiGian_KT(Date thoiGian_KT) {
        this.thoiGian_KT = thoiGian_KT;
    }

    public String getLyDo() {
        return lyDo;
    }

    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }

    public Date get_CreateAt() {
        return _CreateAt;
    }

    public void set_CreateAt(Date _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public Date get_UpdateAt() {
        return _UpdateAt;
    }

    public void set_UpdateAt(Date _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public Date get_DeleteAt() {
        return _DeleteAt;
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