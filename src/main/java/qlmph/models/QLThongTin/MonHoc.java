package qlmph.models.QLThongTin;

import java.sql.Timestamp;

public class MonHoc {
    private String maMH;
    private String monHoc;
    private Timestamp _CreateAt;
    private Timestamp _DeactiveAt;
    
    public MonHoc() {
    }

    public MonHoc(String maMH, String monHoc, Timestamp _CreateAt, Timestamp _DeactiveAt) {
        this.maMH = maMH;
        this.monHoc = monHoc;
        this._CreateAt = _CreateAt;
        this._DeactiveAt = _DeactiveAt;
    }

    public String getMaMH() {
        return maMH;
    }

    public void setMaMH(String maMH) {
        this.maMH = maMH;
    }

    public String getMonHoc() {
        return monHoc;
    }

    public void setMonHoc(String monHoc) {
        this.monHoc = monHoc;
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
