package qlmph.models.QLThongTin;

import java.sql.Timestamp;

public class PhongHoc {
    private String maPH;
    private String tinhTrang;
    private Timestamp _ActiveAt;
    private Timestamp _DeactiveAt;
    public PhongHoc() {
    }
    public PhongHoc(String maPH, String tinhTrang, Timestamp _ActiveAt, Timestamp _DeactiveAt) {
        this.maPH = maPH;
        this.tinhTrang = tinhTrang;
        this._ActiveAt = _ActiveAt;
        this._DeactiveAt = _DeactiveAt;
    }
    public String getMaPH() {
        return maPH;
    }
    public void setMaPH(String maPH) {
        this.maPH = maPH;
    }
    public String getTinhTrang() {
        return tinhTrang;
    }
    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }
    public Timestamp get_ActiveAt() {
        return _ActiveAt;
    }
    public void set_ActiveAt(Timestamp _ActiveAt) {
        this._ActiveAt = _ActiveAt;
    }
    public Timestamp get_DeactiveAt() {
        return _DeactiveAt;
    }
    public void set_DeactiveAt(Timestamp _DeactiveAt) {
        this._DeactiveAt = _DeactiveAt;
    }
}