package qlmph.models.QLThongTin;

import java.security.Timestamp;

public class PhongHoc {
    private String maPH;
    private String tinhTrang;
    private Timestamp _CreateAt;
    private Timestamp _DeactiveAt;
    public PhongHoc() {
    }
    public PhongHoc(String maPH, String tinhTrang, Timestamp _CreateAt, Timestamp _DeactiveAt) {
        this.maPH = maPH;
        this.tinhTrang = tinhTrang;
        this._CreateAt = _CreateAt;
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
    public Timestamp get_CreateAt() {
        return _CreateAt;
    }
    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }
    public Timestamp get_DeactiveAt() {
        return _DeactiveAt;
    }
    public void set_DeactiveAt(Timestamp _DeactiveAt) {
        this._DeactiveAt = _DeactiveAt;
    }
}