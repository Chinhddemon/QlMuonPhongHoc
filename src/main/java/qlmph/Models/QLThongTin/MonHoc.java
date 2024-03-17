package qlmph.models.QLThongTin;

import java.sql.Timestamp;

public class MonHoc {
    private String maMH;
    private String tenMH;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;
    
    public MonHoc() {
    }

    public MonHoc(String maMH, String tenMH, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        this.maMH = maMH;
        this.tenMH = tenMH;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }
    
    @Override
    public String toString() {
        return "MonHoc [maMH=" + maMH + ", tenMH=" + tenMH + ", _UpdateAt=" + _UpdateAt + ", _DeleteAt=" + _DeleteAt
                + "]";
    }

    public String getMaMH() {
        return maMH;
    }

    public void setMaMH(String maMH) {
        this.maMH = maMH;
    }

    public String getTenMH() {
        return tenMH;
    }

    public void setTenMH(String tenMH) {
        this.tenMH = tenMH;
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
