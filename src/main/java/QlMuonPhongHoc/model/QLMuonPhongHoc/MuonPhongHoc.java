package cnpm.model.QLMuonPhongHoc;

import java.sql.Timestamp;
import java.util.UUID;

public class MuonPhongHoc {
    private UUID IdMPH;
    private UUID IdTaiKhoan_MPH;
    private UUID IdQL_Duyet;
    private String YeuCau;
    private Timestamp _CreateAt;
    public MuonPhongHoc() {
    }
    public MuonPhongHoc(UUID idMPH, UUID idTaiKhoan_MPH, UUID idQL_Duyet, String yeuCau, Timestamp _CreateAt) {
        IdMPH = idMPH;
        IdTaiKhoan_MPH = idTaiKhoan_MPH;
        IdQL_Duyet = idQL_Duyet;
        YeuCau = yeuCau;
        this._CreateAt = _CreateAt;
    }
    public UUID getIdMPH() {
        return IdMPH;
    }
    public void setIdMPH(UUID idMPH) {
        IdMPH = idMPH;
    }
    public UUID getIdTaiKhoan_MPH() {
        return IdTaiKhoan_MPH;
    }
    public void setIdTaiKhoan_MPH(UUID idTaiKhoan_MPH) {
        IdTaiKhoan_MPH = idTaiKhoan_MPH;
    }
    public UUID getIdQL_Duyet() {
        return IdQL_Duyet;
    }
    public void setIdQL_Duyet(UUID idQL_Duyet) {
        IdQL_Duyet = idQL_Duyet;
    }
    public String getYeuCau() {
        return YeuCau;
    }
    public void setYeuCau(String yeuCau) {
        YeuCau = yeuCau;
    }
    public Timestamp get_CreateAt() {
        return _CreateAt;
    }
    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }
    
}
