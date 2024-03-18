package qlmph.models.QLThongTin;

import java.security.Timestamp;

public class PhongHoc {
    private String maPH;
    private String tinhTrang;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;
    public PhongHoc() {
    }
    public PhongHoc(String maPH, String tinhTrang, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        this.maPH = maPH;
        this.tinhTrang = tinhTrang;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
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