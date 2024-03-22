package qlmph.models.QLThongTin;

import java.sql.Timestamp;

public class MonHoc {
    private String maMH;
    private String tenMonHoc;
    private Timestamp _ActiveAt;
    private Timestamp _DeactiveAt;
    
    public MonHoc() {
    }

    public MonHoc(String maMH, String tenMonHoc, Timestamp _ActiveAt, Timestamp _DeactiveAt) {
        this.maMH = maMH;
        this.tenMonHoc = tenMonHoc;
        this._ActiveAt = _ActiveAt;
        this._DeactiveAt = _DeactiveAt;
    }

    public String getMaMH() {
        return maMH;
    }

    public void setMaMH(String maMH) {
        this.maMH = maMH;
    }

    public String getTenMonHoc() {
        return tenMonHoc;
    }

    public void setTenMonHoc(String tenMonHoc) {
        this.tenMonHoc = tenMonHoc;
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
