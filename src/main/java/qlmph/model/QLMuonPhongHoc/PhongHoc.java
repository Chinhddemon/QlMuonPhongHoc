package QlMuonPhongHoc.model.QLMuonPhongHoc;

import java.security.Timestamp;

public class PhongHoc {
    private String MaPH;
    private String TinhTrang;
    private Timestamp _UpdateAt;
    private Timestamp _DeleteAt;
    public PhongHoc() {
    }
    public PhongHoc(String maPH, String tinhTrang, Timestamp _UpdateAt, Timestamp _DeleteAt) {
        MaPH = maPH;
        TinhTrang = tinhTrang;
        this._UpdateAt = _UpdateAt;
        this._DeleteAt = _DeleteAt;
    }
    public String getMaPH() {
        return MaPH;
    }
    public void setMaPH(String maPH) {
        MaPH = maPH;
    }
    public String getTinhTrang() {
        return TinhTrang;
    }
    public void setTinhTrang(String tinhTrang) {
        TinhTrang = tinhTrang;
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