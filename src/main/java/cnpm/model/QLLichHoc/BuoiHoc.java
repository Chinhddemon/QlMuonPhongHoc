package cnpm.model.QLLichHoc;

import java.sql.Timestamp;
import java.util.UUID;

public class BuoiHoc {
    private String MaBH;
    private String MaLH;
    private String MaPH;
    private UUID IdMPH;
    private Timestamp ThoiGian_BD;
    private Timestamp ThoiGian_KT;
    private String HinhThuc;
    private Timestamp _CreateAt;
    public BuoiHoc() {
    }
    public BuoiHoc(String maBH, String maLH, String maPH, UUID idMPH, Timestamp thoiGian_BD, Timestamp thoiGian_KT,
            String hinhThuc, Timestamp _CreateAt) {
        MaBH = maBH;
        MaLH = maLH;
        MaPH = maPH;
        IdMPH = idMPH;
        ThoiGian_BD = thoiGian_BD;
        ThoiGian_KT = thoiGian_KT;
        HinhThuc = hinhThuc;
        this._CreateAt = _CreateAt;
    }
    public String getMaBH() {
        return MaBH;
    }
    public void setMaBH(String maBH) {
        MaBH = maBH;
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
    public Timestamp get_CreateAt() {
        return _CreateAt;
    }
    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }
    
}
