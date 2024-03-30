package qlmph.model.QLThongTin;

import javax.persistence.*;

@Entity
public class LopSV {
    @Id
    @Column(name = "MaLopSV")
    private String maLopSV;

    @Column(name = "TenLopSV")
    private String tenLopSV;

    @Column(name = "NienKhoa_BD")
    private short nienKhoa_BD;

    @Column(name = "NienKhoa_KT")
    private short nienKhoa_KT;

    public LopSV() {
    }

    public LopSV(String maLopSV, String tenLopSV, short nienKhoa_BD, short nienKhoa_KT) {
        this.maLopSV = maLopSV;
        this.tenLopSV = tenLopSV;
        this.nienKhoa_BD = nienKhoa_BD;
        this.nienKhoa_KT = nienKhoa_KT;
    }

    public String getMaLopSV() {
        return maLopSV;
    }

    public void setMaLopSV(String maLopSV) {
        this.maLopSV = maLopSV;
    }

    public String getTenLopSV() {
        return tenLopSV;
    }

    public void setTenLopSV(String tenLopSV) {
        this.tenLopSV = tenLopSV;
    }

    public short getNienKhoa_BD() {
        return nienKhoa_BD;
    }

    public void setNienKhoa_BD(short nienKhoa_BD) {
        this.nienKhoa_BD = nienKhoa_BD;
    }

    public short getNienKhoa_KT() {
        return nienKhoa_KT;
    }

    public void setNienKhoa_KT(short nienKhoa_KT) {
        this.nienKhoa_KT = nienKhoa_KT;
    }

}
