package qlmph.models.QLThongTin;

import java.sql.Timestamp;
import java.util.UUID;
import java.sql.Date;

public class LopHoc {
    private int idLH;
    private UUID idGVGiangDay;
    private String maMH;
    private String maLopSV;
    private Date ngay_BD;
    private Date ngay_KT;
    private Timestamp _CreateAt;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;

    public LopHoc() {
    }

    public LopHoc(int idLH, UUID idGVGiangDay, String maMH, String maLopSV, Date ngay_BD, Date ngay_KT,
            Timestamp _CreateAt, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        this.idLH = idLH;
        this.idGVGiangDay = idGVGiangDay;
        this.maMH = maMH;
        this.maLopSV = maLopSV;
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

    public UUID getIdGVGiangDay() {
        return idGVGiangDay;
    }

    public void setIdGVGiangDay(UUID idGVGiangDay) {
        this.idGVGiangDay = idGVGiangDay;
    }

    public String getMaMH() {
        return maMH;
    }

    public void setMaMH(String maMH) {
        this.maMH = maMH;
    }

    public String getMaLopSV() {
        return maLopSV;
    }

    public void setMaLopSV(String maLopSV) {
        this.maLopSV = maLopSV;
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

    public Timestamp get_CreateAt() {
        return _CreateAt;
    }

    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public Timestamp get_UpdateAt() {
        return _UpdateAt;
    }

    public void set_UpdateAt(Timestamp _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public Timestamp get_DeleteAt() {
        return _DeleteAt;
    }

    public void set_DeleteAt(Timestamp _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }

}
