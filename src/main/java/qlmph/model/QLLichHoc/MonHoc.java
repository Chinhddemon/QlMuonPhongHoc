package QlMuonPhongHoc.model.QLLichHoc;

import java.sql.Timestamp;

public class MonHoc {
    private String MaMH;
    private String TenMH;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;
    
    public MonHoc() {
    }
    public MonHoc(String maMH, String tenMH, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        MaMH = maMH;
        TenMH = tenMH;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }
    public String getMaMH() {
        return MaMH;
    }
    public void setMaMH(String maMH) {
        MaMH = maMH;
    }
    public String getTenMH() {
        return TenMH;
    }
    public void setTenMH(String tenMH) {
        TenMH = tenMH;
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
