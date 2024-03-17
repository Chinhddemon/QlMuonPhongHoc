package qlmph.models.QLThongTin;

import java.sql.Timestamp;

public class LichMuonPhong {
    private String maLMPH;
    private String maLH;
    private String maPH;
    private String idTaiKhoan_MPH;
    private String idQL_Duyet;
    private Timestamp thoiGian_BD;
    private Timestamp thoiGian_KT;
    private String mucDich;
    private String lyDo;
    private Timestamp thoiGian_MPH;
    private String yeuCauHocCu;
    private Timestamp _CreateAt;
    private Timestamp _DeleteAt;
    public LichMuonPhong() {
    }
    public LichMuonPhong(String maLMPH, String maLH, String maPH, String idTaiKhoan_MPH, String idQL_Duyet,
            Timestamp thoiGian_BD, Timestamp thoiGian_KT, String mucDich, String lyDo, Timestamp thoiGian_MPH,
            String yeuCauHocCu, Timestamp _CreateAt, Timestamp _DeleteAt) {
        this.maLMPH = maLMPH;
        this.maLH = maLH;
        this.maPH = maPH;
        this.idTaiKhoan_MPH = idTaiKhoan_MPH;
        this.idQL_Duyet = idQL_Duyet;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.mucDich = mucDich;
        this.lyDo = lyDo;
        this.thoiGian_MPH = thoiGian_MPH;
        this.yeuCauHocCu = yeuCauHocCu;
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
    public String getIdTaiKhoan_MPH() {
        return idTaiKhoan_MPH;
    }
    public void setIdTaiKhoan_MPH(String idTaiKhoan_MPH) {
        this.idTaiKhoan_MPH = idTaiKhoan_MPH;
    }
    public String getIdQL_Duyet() {
        return idQL_Duyet;
    }
    public void setIdQL_Duyet(String idQL_Duyet) {
        this.idQL_Duyet = idQL_Duyet;
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
    public Timestamp getThoiGian_MPH() {
        return thoiGian_MPH;
    }
    public void setThoiGian_MPH(Timestamp thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }
    public String getYeuCauHocCu() {
        return yeuCauHocCu;
    }
    public void setYeuCauHocCu(String yeuCauHocCu) {
        this.yeuCauHocCu = yeuCauHocCu;
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
