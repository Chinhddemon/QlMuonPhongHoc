package QlMuonPhongHoc.model.QLMuonPhongHoc;

import java.sql.Timestamp;
import java.util.UUID;

public class LichMuonPhong {
    private String MaLMPH;
    private String MaLH;
    private UUID IdMPH;
    private Timestamp ThoiGian_BD;
    private Timestamp ThoiGian_KT;
    private String HinhThuc;
    private String LyDo;
    private Timestamp _CreateAt;
    private Timestamp _DeleteAt;
    public LichMuonPhong() {
    }
    public LichMuonPhong(String maLMPH, String maLH, UUID idMPH, Timestamp thoiGian_BD, Timestamp thoiGian_KT,
            String hinhThuc, String lyDo, Timestamp _CreateAt, Timestamp _DeleteAt) {
        MaLMPH = maLMPH;
        MaLH = maLH;
        IdMPH = idMPH;
        ThoiGian_BD = thoiGian_BD;
        ThoiGian_KT = thoiGian_KT;
        HinhThuc = hinhThuc;
        LyDo = lyDo;
        this._CreateAt = _CreateAt;
        this._DeleteAt = _DeleteAt;
    }
    public String getMaLMPH() {
        return MaLMPH;
    }
    public void setMaLMPH(String maLMPH) {
        MaLMPH = maLMPH;
    }
    public String getMaLH() {
        return MaLH;
    }
    public void setMaLH(String maLH) {
        MaLH = maLH;
    }
    public UUID getIdMPH() {
        return IdMPH;
    }
    public void setIdMPH(UUID idMPH) {
        IdMPH = idMPH;
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
    public String getHinhThuc() {
        return HinhThuc;
    }
    public void setHinhThuc(String hinhThuc) {
        HinhThuc = hinhThuc;
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
