package qlmph.models.QLThongTin;

import java.sql.Timestamp;

public class MuonPhongHoc {
    private int idMPH;
    private int idNgMPH;
    private int idQLDuyet;
    private Timestamp thoiGian_MPH;
    private String yeuCau;
    private Timestamp _CreateAt;

    public MuonPhongHoc() {
    }
    public MuonPhongHoc(int idMPH, int idNgMPH, int idQLDuyet, Timestamp thoiGian_MPH, String yeuCau,
            Timestamp _CreateAt) {
        this.idMPH = idMPH;
        this.idNgMPH = idNgMPH;
        this.idQLDuyet = idQLDuyet;
        this.thoiGian_MPH = thoiGian_MPH;
        this.yeuCau = yeuCau;
        this._CreateAt = _CreateAt;
    }
    public int getIdMPH() {
        return idMPH;
    }
    public void setIdMPH(int idMPH) {
        this.idMPH = idMPH;
    }
    public int getIdNgMPH() {
        return idNgMPH;
    }
    public void setIdNgMPH(int idNgMPH) {
        this.idNgMPH = idNgMPH;
    }
    public int getIdQLDuyet() {
        return idQLDuyet;
    }
    public void setIdQLDuyet(int idQLDuyet) {
        this.idQLDuyet = idQLDuyet;
    }
    public Timestamp getThoiGian_MPH() {
        return thoiGian_MPH;
    }
    public void setThoiGian_MPH(Timestamp thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }
    public String getYeuCau() {
        return yeuCau;
    }
    public void setYeuCau(String yeuCau) {
        this.yeuCau = yeuCau;
    }
    public Timestamp get_CreateAt() {
        return _CreateAt;
    }
    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    
}
