package QlMuonPhongHoc.model.QLLichHoc;

import java.sql.Timestamp;
import java.sql.Date;
import java.util.UUID;

public class LopHoc {
    private String MaLH;
    private UUID IdGV_GiangDay;
    private String MaMH;
    private String MaLopSV;
    private Date Ngay_BD;
    private Date Ngay_KT;
    private Timestamp _CreateAt;
    private Timestamp _DeleteAt;
    public LopHoc() {
    }
    public LopHoc(String maLH, UUID idGV_GiangDay, String maMH, String maLopSV, Date ngay_BD, Date ngay_KT,
            Timestamp _CreateAt, Timestamp _DeleteAt) {
        MaLH = maLH;
        IdGV_GiangDay = idGV_GiangDay;
        MaMH = maMH;
        MaLopSV = maLopSV;
        Ngay_BD = ngay_BD;
        Ngay_KT = ngay_KT;
        this._CreateAt = _CreateAt;
        this._DeleteAt = _DeleteAt;
    }
    public String getMaLH() {
        return MaLH;
    }
    public void setMaLH(String maLH) {
        MaLH = maLH;
    }
    public UUID getIdGV_GiangDay() {
        return IdGV_GiangDay;
    }
    public void setIdGV_GiangDay(UUID idGV_GiangDay) {
        IdGV_GiangDay = idGV_GiangDay;
    }
    public String getMaMH() {
        return MaMH;
    }
    public void setMaMH(String maMH) {
        MaMH = maMH;
    }
    public String getMaLopSV() {
        return MaLopSV;
    }
    public void setMaLopSV(String maLopSV) {
        MaLopSV = maLopSV;
    }
    public Date getNgay_BD() {
        return Ngay_BD;
    }
    public void setNgay_BD(Date ngay_BD) {
        Ngay_BD = ngay_BD;
    }
    public Date getNgay_KT() {
        return Ngay_KT;
    }
    public void setNgay_KT(Date ngay_KT) {
        Ngay_KT = ngay_KT;
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
