package qlmph.models.QLThongTin;

import java.sql.Timestamp;
import java.sql.Date;
import java.util.UUID;

public class LopHoc {
    private String maLH;
    private UUID idGV_GiangDay;
    private String maMH;
    private String maLopSV;
    private Date ngay_BD;
    private Date ngay_KT;
    private Timestamp _CreateAt;
    private Timestamp _DeleteAt;
    public LopHoc() {
    }
    public LopHoc(String maLH, UUID idGV_GiangDay, String maMH, String maLopSV, Date ngay_BD, Date ngay_KT,
            Timestamp _CreateAt, Timestamp _DeleteAt) {
        this.maLH = maLH;
        this.idGV_GiangDay = idGV_GiangDay;
        this.maMH = maMH;
        this.maLopSV = maLopSV;
        this.ngay_BD = ngay_BD;
        this.ngay_KT = ngay_KT;
        this._CreateAt = _CreateAt;
        this._DeleteAt = _DeleteAt;
    }
    public String getMaLH() {
        return maLH;
    }
    public void setMaLH(String maLH) {
        this.maLH = maLH;
    }
    public UUID getIdGV_GiangDay() {
        return idGV_GiangDay;
    }
    public void setIdGV_GiangDay(UUID idGV_GiangDay) {
        this.idGV_GiangDay = idGV_GiangDay;
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
    public Timestamp get_DeleteAt() {
        return _DeleteAt;
    }
    public void set_DeleteAt(Timestamp _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }
    
}
