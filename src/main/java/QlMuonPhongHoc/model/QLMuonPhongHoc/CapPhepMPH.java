package cnpm.model.QLMuonPhongHoc;

import java.sql.Timestamp;
import java.util.UUID;

public class CapPhepMPH {
    private String MaCP;
    private String MaPH;
    private UUID IdMPH;
    private UUID IdQL_Duyet;
    private Timestamp ThoiGian_BD;
    private Timestamp ThoiGian_KT;
    private String LyDo;
    private Timestamp _CreateAt;
    private Timestamp _DeleteAt;
    public CapPhepMPH() {
    }
    public CapPhepMPH(String maCP, String maPH, UUID idMPH, UUID idQL_Duyet, Timestamp thoiGian_BD,
            Timestamp thoiGian_KT, String lyDo, Timestamp _CreateAt, Timestamp _DeleteAt) {
        MaCP = maCP;
        MaPH = maPH;
        IdMPH = idMPH;
        IdQL_Duyet = idQL_Duyet;
        ThoiGian_BD = thoiGian_BD;
        ThoiGian_KT = thoiGian_KT;
        LyDo = lyDo;
        this._CreateAt = _CreateAt;
        this._DeleteAt = _DeleteAt;
    }
    public String getMaCP() {
        return MaCP;
    }
    public void setMaCP(String maCP) {
        MaCP = maCP;
    }
    public String getMaPH() {
        return MaPH;
    }
    public void setMaPH(String maPH) {
        MaPH = maPH;
    }
    public UUID getIdMPH() {
        return IdMPH;
    }
    public void setIdMPH(UUID idMPH) {
        IdMPH = idMPH;
    }
    public UUID getIdQL_Duyet() {
        return IdQL_Duyet;
    }
    public void setIdQL_Duyet(UUID idQL_Duyet) {
        IdQL_Duyet = idQL_Duyet;
    }
    public Timestamp getThoiGian_BD() {
        return ThoiGian_BD;
    }
    public void setThoiGian_BD(Timestamp thoiGian_BD) {
        ThoiGian_BD = thoiGian_BD;
    }
    public Timestamp getThoiGian_KT() {
        return ThoiGian_KT;
    }
    public void setThoiGian_KT(Timestamp thoiGian_KT) {
        ThoiGian_KT = thoiGian_KT;
    }
    public String getLyDo() {
        return LyDo;
    }
    public void setLyDo(String lyDo) {
        LyDo = lyDo;
    }
    public Timestamp get_CreateAt() {
        return _CreateAt;
    }
    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }
    public Timestamp get_DeleteAt() {
        return _DeleteAt;
    }
    public void set_DeleteAt(Timestamp _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }
    
}
