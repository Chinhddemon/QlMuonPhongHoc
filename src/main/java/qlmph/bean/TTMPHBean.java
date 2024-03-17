/*  
Xử lý nhận đầu vào từ Model:
    LichMuonPhong
    LopHoc
    PhongHoc
    TaiKhoan
Định nghĩa dữ liệu:
    maLH            -   Mã lớp học
    maPH            -   Mã phòng học    
    idNgMPH         -   Id người mượn phòng học
    idQL_Duyet      -   Id quản lý duyệt
    thoiGian_BD     -   Thời gian mượn
    thoiGian_KT     -   Thời gian trả
    mucDich         -   Mục đích mượn phòng học
    lydo            -   Lý do tạo lịch mượn phòng học
    thoiGian_MPH    -   Thời gian mượn phòng học
    yeuCauHocCu     -   Yêu cầu học cụ
*/
package qlmph.bean;

import java.sql.Timestamp;
import java.util.UUID;

import qlmph.utils.Converter;

public class TTMPHBean {
    private String maLH;
    private String maPH;
    private UUID idTaiKhoan_MPH;
    private UUID idQL_Duyet;
    private Timestamp thoiGian_BD;
    private Timestamp thoiGian_KT;
    private String mucDich;
    private String lyDo;
    private Timestamp thoiGian_MPH;
    private String yeuCauHocCu;

    public TTMPHBean() {
    }

    // chỉ sử dụng để test
    public TTMPHBean(String maLH, String maPH, String idTaiKhoan_MPH, String idQL_Duyet, String thoiGian_BD,
    String thoiGian_KT, String mucDich, String lyDo, String thoiGian_MPH, String yeuCauHocCu) {
        this.maLH = maLH;
        this.maPH = maPH;
        this.idTaiKhoan_MPH = UUID.fromString(idTaiKhoan_MPH);
        this.idQL_Duyet = UUID.fromString(idQL_Duyet);
        this.thoiGian_BD = Converter.stringToTimestamp(thoiGian_BD, "HH:mm dd/MM/yyyy");
        this.thoiGian_KT = Converter.stringToTimestamp(thoiGian_KT, "HH:mm dd/MM/yyyy");
        this.mucDich = mucDich;
        this.lyDo = lyDo;
        this.thoiGian_MPH = Converter.stringToTimestamp(thoiGian_MPH, "HH:mm dd/MM/yyyy");
        this.yeuCauHocCu = yeuCauHocCu;
    }

    // chỉ sử dụng để test
    public TTMPHBean(String maLH, String maPH, UUID idTaiKhoan_MPH, UUID idQL_Duyet, Timestamp thoiGian_BD,
            Timestamp thoiGian_KT, String mucDich, String lyDo, Timestamp thoiGian_MPH, String yeuCauHocCu) {
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

    public UUID getIdTaiKhoan_MPH() {
        return idTaiKhoan_MPH;
    }

    public void setIdTaiKhoan_MPH(UUID idTaiKhoan_MPH) {
        this.idTaiKhoan_MPH = idTaiKhoan_MPH;
    }

    public UUID getIdQL_Duyet() {
        return idQL_Duyet;
    }

    public void setIdQL_Duyet(UUID idQL_Duyet) {
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

}
