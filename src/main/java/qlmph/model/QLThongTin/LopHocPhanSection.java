package qlmph.model.QLThongTin;

import java.util.Date;
import java.util.List;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.utils.Converter;

@Entity
@Table(name = "LopHocPhanSection")
public class LopHocPhanSection {
    
    @Id
    @Column(name = "IdLHPSection")
    private int idLHPSection;
    
    @ManyToOne
    @JoinColumn(name = "IdLHP", referencedColumnName = "IdLHP")
    LopHocPhan lopHocPhan;

    @OneToOne
    @JoinColumn(name = "MaGVGiangDay", referencedColumnName = "MaGV")
    private GiangVien giangVien;
    
    @Column(name = "NhomTo")
    private byte nhomTo;

    @Column(name = "Ngay_BD")
    @Temporal(TemporalType.DATE)
    private Date ngay_BD;

    @Column(name = "Ngay_KT")
    @Temporal(TemporalType.DATE)
    private Date ngay_KT;

    @Column(name = "_UpdateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _UpdateAt;

    @OneToMany(mappedBy = "lopHocPhanSection")
    List<LichMuonPhong> lichMuonPhongs;

    public LopHocPhanSection() {
    }

    public LopHocPhanSection(int idLHPSection, GiangVien giangVien, byte nhomTo, Date ngay_BD, Date ngay_KT) {
        this.idLHPSection = idLHPSection;
        this.giangVien = giangVien;
        this.nhomTo = nhomTo;
        this.ngay_BD = ngay_BD;
        this.ngay_KT = ngay_KT;
    }

    public String getIdLHPSection() {
        return Converter.intToStringNchar(idLHPSection, 6);
    }

    public void setIdLHPSection(int idLHPSection) {
        this.idLHPSection = idLHPSection;
    }

    public GiangVien getGiangVien() {
        return giangVien;
    }

    public void setGiangVien(GiangVien giangVien) {
        this.giangVien = giangVien;
    }

    public String getNhomTo() {
        if(nhomTo == 0) return "";
        return Converter.byteToString2char(nhomTo);
    }

    public void setNhomTo(byte nhomTo) {
        this.nhomTo = nhomTo;
    }

    public String getNgay_BD() {
        return Converter.DateToString(ngay_BD);
    }

    public void setNgay_BD(Date ngay_BD) {
        this.ngay_BD = ngay_BD;
    }

    public String getNgay_KT() {
        return Converter.DateToString(ngay_KT);
    }

    public void setNgay_KT(Date ngay_KT) {
        this.ngay_KT = ngay_KT;
    }

    public String get_UpdateAt() {
        return Converter.DateTimeToString(_UpdateAt);
    }

    public void set_UpdateAt(Date _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public List<LichMuonPhong> getLichMuonPhongs() {
        return lichMuonPhongs;
    }

    public void setLichMuonPhongs(List<LichMuonPhong> lichMuonPhongs) {
        this.lichMuonPhongs = lichMuonPhongs;
    }

    public LopHocPhan getLopHocPhan() {
        return lopHocPhan;
    }

    public void setLopHocPhan(LopHocPhan lopHocPhan) {
        this.lopHocPhan = lopHocPhan;
    }
}
