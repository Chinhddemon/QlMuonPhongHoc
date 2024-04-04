package qlmph.model.QLThongTin;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.model.QLTaiKhoan.SinhVien;

import java.util.Date;
import java.util.Set;

import qlmph.utils.Converter;

@Entity
@Table(name = "LopHocPhan")
public class LopHocPhan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdLHP")
    private int idLHP;

    @OneToOne
    @JoinColumn(name = "MaGVGiangDay", referencedColumnName = "MaGV")
    private GiangVien giangVien;

    @ManyToOne
    @JoinColumn(name = "MaMH", referencedColumnName = "MaMH")
    private MonHoc monHoc;

    @ManyToOne
    @JoinColumn(name = "MaLopSV", referencedColumnName = "MaLopSV")
    private LopSV lopSV;

    @Column(name = "Ngay_BD")
    @Temporal(TemporalType.DATE)
    private Date ngay_BD;

    @Column(name = "Ngay_KT")
    @Temporal(TemporalType.DATE)
    private Date ngay_KT;

    @Column(name = "_CreateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt;

    @Column(name = "_UpdateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _UpdateAt;

    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    @OneToMany(mappedBy = "lopHocPhan", fetch = FetchType.LAZY)
    private Set<LichMuonPhong> lichMuonPhongs;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name = "DsMPH_LopHoc",
        joinColumns = @JoinColumn(name = "IdLHP"), 
        inverseJoinColumns = @JoinColumn(name = "MaSV"))
    Set<SinhVien> sinhViens;

    @Override
    public String toString() {
        return "LopHocPhan [idLHP=" + idLHP + ", giangVien=" + giangVien + ", monHoc=" + monHoc + ", lopSV=" + lopSV
                + ", ngay_BD=" + ngay_BD + ", ngay_KT=" + ngay_KT + ", _CreateAt=" + _CreateAt + ", _UpdateAt="
                + _UpdateAt + ", _DeleteAt=" + _DeleteAt + ", lichMuonPhongs=" + lichMuonPhongs + ", sinhViens="
                + sinhViens + "]";
    }

    public LopHocPhan(GiangVien giangVien, MonHoc monHoc, LopSV lopSV, Date ngay_BD, Date ngay_KT, Date _DeleteAt) {
        this.giangVien = giangVien;
        this.monHoc = monHoc;
        this.lopSV = lopSV;
        this.ngay_BD = ngay_BD;
        this.ngay_KT = ngay_KT;
        this._DeleteAt = _DeleteAt;
    }

    public int getIdLHP() {
        return idLHP;
    }

    public void setIdLHP(int idLHP) {
        this.idLHP = idLHP;
    }

    public GiangVien getGiangVien() {
        return giangVien;
    }

    public void setGiangVien(GiangVien giangVien) {
        this.giangVien = giangVien;
    }

    public MonHoc getMonHoc() {
        return monHoc;
    }

    public void setMonHoc(MonHoc monHoc) {
        this.monHoc = monHoc;
    }

    public LopSV getLopSV() {
        return lopSV;
    }

    public void setLopSV(LopSV lopSV) {
        this.lopSV = lopSV;
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

    public Set<LichMuonPhong> getLichMuonPhongs() {
        return lichMuonPhongs;
    }

    public void setLichMuonPhongs(Set<LichMuonPhong> lichMuonPhongs) {
        this.lichMuonPhongs = lichMuonPhongs;
    }

    public Set<SinhVien> getSinhViens() {
        return sinhViens;
    }

    public void setSinhViens(Set<SinhVien> sinhViens) {
        this.sinhViens = sinhViens;
    }

}