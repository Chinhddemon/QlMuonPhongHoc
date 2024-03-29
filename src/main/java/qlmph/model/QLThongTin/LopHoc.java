package qlmph.model.QLThongTin;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.GiangVien;

import java.util.Date;

@Entity
@Table(name = "LopHoc")
public class LopHoc {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "IdLH")
    private int idLH;

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

    public LopHoc() {
    }
    

    @Override
    public String toString() {
        return "LopHoc [idLH=" + idLH + ", giangVien=" + giangVien + ", monHoc=" + monHoc + ", lopSV=" + lopSV
                + ", ngay_BD=" + ngay_BD + ", ngay_KT=" + ngay_KT + ", _CreateAt=" + _CreateAt + ", _UpdateAt="
                + _UpdateAt + ", _DeleteAt=" + _DeleteAt + "]";
    }


    public LopHoc(int idLH, GiangVien giangVien, MonHoc monHoc, LopSV lopSV, Date ngay_BD, Date ngay_KT, Date _CreateAt,
            Date _UpdateAt, Date _DeleteAt) {
        this.idLH = idLH;
        this.giangVien = giangVien;
        this.monHoc = monHoc;
        this.lopSV = lopSV;
        this.ngay_BD = ngay_BD;
        this.ngay_KT = ngay_KT;
        this._CreateAt = _CreateAt;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }

    public int getIdLH() {
        return idLH;
    }

    public void setIdLH(int idLH) {
        this.idLH = idLH;
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

    public Date getNgay_BD() {
        return ngay_BD;
    }

    public void setNgay_BD(Date ngay_BD) {
        this.ngay_BD = ngay_BD;
    }

    public Date getNgay_KT() {
        return ngay_KT;
    }

    public void setNgay_KT(Date ngay_KT) {
        this.ngay_KT = ngay_KT;
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

}
