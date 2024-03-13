package cnpm.model.QLMuonPhongHoc;

import java.sql.Timestamp;
import java.util.UUID;

public class Doi_BuoiHoc {
    private String MaDBH;
    private String MaLH;
    private String MaPH;
    private UUID IdTaiKHoan_MPH;
    private UUID IdQL_Duyet;
    private Timestamp ThoiGian_BD;
    private Timestamp ThoiGian_KT;
    private String HinhThuc;
    private String YeuCau;
    private String LyDo;
    private Timestamp _CreateAt;
    public Doi_BuoiHoc() {
    }
    public Doi_BuoiHoc(String maDBH, String maLH, String maPH, UUID idTaiKHoan_MPH, UUID idQL_Duyet,
            Timestamp thoiGian_BD, Timestamp thoiGian_KT, String hinhThuc, String yeuCau, String lyDo,
            Timestamp _CreateAt) {
        MaDBH = maDBH;
        MaLH = maLH;
        MaPH = maPH;
        IdTaiKHoan_MPH = idTaiKHoan_MPH;
        IdQL_Duyet = idQL_Duyet;
        ThoiGian_BD = thoiGian_BD;
        ThoiGian_KT = thoiGian_KT;
        HinhThuc = hinhThuc;
        YeuCau = yeuCau;
        LyDo = lyDo;
        this._CreateAt = _CreateAt;
    }
    public String getMaDBH() {
        return MaDBH;
    }
    public void setMaDBH(String maDBH) {
        MaDBH = maDBH;
    }
    public String getMaLH() {
        return MaLH;
    }
    public void setMaLH(String maLH) {
        MaLH = maLH;
    }
    public String getMaPH() {
        return MaPH;
    }
    public void setMaPH(String maPH) {
        MaPH = maPH;
    }
    public UUID getIdTaiKHoan_MPH() {
        return IdTaiKHoan_MPH;
    }
    public void setIdTaiKHoan_MPH(UUID idTaiKHoan_MPH) {
        IdTaiKHoan_MPH = idTaiKHoan_MPH;
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
    public String getHinhThuc() {
        return HinhThuc;
    }
    public void setHinhThuc(String hinhThuc) {
        HinhThuc = hinhThuc;
    }
    public String getYeuCau() {
        return YeuCau;
    }
    public void setYeuCau(String yeuCau) {
        YeuCau = yeuCau;
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

}
