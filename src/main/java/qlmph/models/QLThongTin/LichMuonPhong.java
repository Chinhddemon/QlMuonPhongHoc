package qlmph.models.QLThongTin;

import java.sql.Timestamp;

public class LichMuonPhong {
    private String maLMPH;
    private String maLH;
    private String maPH;
    private int idMPH;
    private Timestamp thoiGian_BD;
    private Timestamp thoiGian_KT;
    private String mucDich;
    private String lyDo;
    private Timestamp _CreateAt;
    private Timestamp _DeleteAt;

    public LichMuonPhong() {
    }

    public LichMuonPhong(String maLMPH, String maLH, String maPH, int idMPH, Timestamp thoiGian_BD,
            Timestamp thoiGian_KT, String mucDich, String lyDo, Timestamp _CreateAt, Timestamp _DeleteAt) {
        this.maLMPH = maLMPH;
        this.maLH = maLH;
        this.maPH = maPH;
        this.idMPH = idMPH;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.mucDich = mucDich;
        this.lyDo = lyDo;
        this._CreateAt = _CreateAt;
        this._DeleteAt = _DeleteAt;
    }

    public String getMaLMPH() {
        return maLMPH;
    }

    public void setMaLMPH(String maLMPH) {
        this.maLMPH = maLMPH;
    }

    public String getMaLH() {
        return maLH;
    }

    public void setMaLH(String maLH) {
        this.maLH = maLH;
    }

    public String getMaPH() {
        return maPH;
    }

    public void setMaPH(String maPH) {
        this.maPH = maPH;
    }

    public int getIdMPH() {
        return idMPH;
    }

    public void setIdMPH(int idMPH) {
        this.idMPH = idMPH;
    }

    public Timestamp getThoiGian_BD() {
        return thoiGian_BD;
    }

    public void setThoiGian_BD(Timestamp thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }

    public Timestamp getThoiGian_KT() {
        return thoiGian_KT;
    }

    public void setThoiGian_KT(Timestamp thoiGian_KT) {
        this.thoiGian_KT = thoiGian_KT;
    }

    public String getMucDich() {
        return mucDich;
    }

    public void setMucDich(String mucDich) {
        this.mucDich = mucDich;
    }

    public String getLyDo() {
        return lyDo;
    }

    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
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
