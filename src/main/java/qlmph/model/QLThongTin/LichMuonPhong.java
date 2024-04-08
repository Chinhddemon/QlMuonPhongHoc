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
    @JoinColumn(name = "IdPH", referencedColumnName = "IdPH")
    private PhongHoc phongHoc;

    @ManyToOne
    @JoinColumn(name = "IdLHP", referencedColumnName = "IdLHP")
    private LopHocPhan lopHocPhan;

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

    @Override
    public String toString() {
        return "LichMuonPhong [idLMPH=" + idLMPH + ", phongHoc=" + phongHoc + ", lopHocPhan=" + lopHocPhan
                + ", quanLyKhoiTao=" + quanLyKhoiTao + ", thoiGian_BD=" + thoiGian_BD + ", thoiGian_KT=" + thoiGian_KT
                + ", mucDich=" + mucDich + ", lyDo=" + lyDo + ", _CreateAt=" + _CreateAt + ", _UpdateAt=" + _UpdateAt
                + ", _DeleteAt=" + _DeleteAt + ", muonPhongHoc=" + muonPhongHoc + "]";
    }

    public LichMuonPhong() {
    }

    public LichMuonPhong(int idLMPH, PhongHoc phongHoc, LopHocPhan lopHocPhan, QuanLy quanLyKhoiTao, Date thoiGian_BD,
            Date thoiGian_KT, String mucDich, String lyDo, Date _DeleteAt, MuonPhongHoc muonPhongHoc) {
        this.idLMPH = idLMPH;
        this.phongHoc = phongHoc;
        this.lopHocPhan = lopHocPhan;
        this.quanLyKhoiTao = quanLyKhoiTao;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.mucDich = mucDich;
        this.lyDo = lyDo;
        this._DeleteAt = _DeleteAt;
        this.muonPhongHoc = muonPhongHoc;
    }

    public LichMuonPhong(PhongHoc phongHoc, LopHocPhan lopHocPhan, QuanLy quanLyKhoiTao, String thoiGian_BD,
            String thoiGian_KT, String mucDich, String lyDo) {
        this.phongHoc = phongHoc;
        this.lopHocPhan = lopHocPhan;
        this.quanLyKhoiTao = quanLyKhoiTao;
        this.thoiGian_BD = Converter.StringToDateTime(thoiGian_BD);
        this.thoiGian_KT = Converter.StringToDateTime(thoiGian_KT);
        this.mucDich = mucDich;
        this.lyDo = lyDo;
    }

    public String getIdLMPH() {
        return Converter.intToString8char(idLMPH);
    }

    public void setIdLMPH(int idLMPH) {
        this.idLMPH = idLMPH;
    }

    public PhongHoc getPhongHoc() {
        return phongHoc;
    }

    public void setPhongHoc(PhongHoc phongHoc) {
        this.phongHoc = phongHoc;
    }

    public LopHocPhan getLopHocPhan() {
        return lopHocPhan;
    }

    public void setLopHocPhan(LopHocPhan lopHocPhan) {
        this.lopHocPhan = lopHocPhan;
    }

    public QuanLy getQuanLyKhoiTao() {
        return quanLyKhoiTao;
    }

    public void setQuanLyKhoiTao(QuanLy quanLyKhoiTao) {
        this.quanLyKhoiTao = quanLyKhoiTao;
    }

    public String getThoiGian_BD() {
        if(thoiGian_BD == null) return null;
        return Converter.DateTimeToString(thoiGian_BD);
    }

    public void setThoiGian_BD(Date thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }

    public String getThoiGian_KT() {
        if(thoiGian_KT == null) return null;
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
        if(_CreateAt == null) return null;
        return Converter.DateTimeToString(_CreateAt);
    }

    public void set_CreateAt(Date _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public String get_UpdateAt() {
        if(_UpdateAt == null) return null;
        return Converter.DateTimeToString(_UpdateAt);
    }

    public void set_UpdateAt(Date _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public String get_DeleteAt() {
        if(_DeleteAt == null) return null;
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