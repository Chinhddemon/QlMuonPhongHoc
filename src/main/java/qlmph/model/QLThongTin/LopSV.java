package qlmph.model.QLThongTin;

import java.util.Set;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.SinhVien;

@Entity
public class LopSV {
    @Id
    @Column(name = "MaLopSV")
    private String maLopSV;

    @Column(name = "NienKhoa_BD")
    private short nienKhoa_BD;

    @Column(name = "NienKhoa_KT")
    private short nienKhoa_KT;

    @Column(name = "MaNganh")
    private int maNganh;

    @Column(name = "Khoa")
    private String khoa;

    @Column(name = "HeDaoTao")
    private String heDaoTao;

    @OneToMany(mappedBy = "lopSV", fetch = FetchType.LAZY)
    private Set<SinhVien> sinhViens;

    @OneToMany(mappedBy = "lopSV", fetch = FetchType.LAZY)
    private Set<NhomHocPhan> nhomHocPhans;

    public LopSV() {
    }

    public LopSV(String maLopSV, short nienKhoa_BD, short nienKhoa_KT, int maNganh, String khoa, String heDaoTao) {
        this.maLopSV = maLopSV;
        this.nienKhoa_BD = nienKhoa_BD;
        this.nienKhoa_KT = nienKhoa_KT;
        this.maNganh = maNganh;
        this.khoa = khoa;
        this.heDaoTao = heDaoTao;
    }

    public String getMaLopSV() {
        return maLopSV;
    }

    public void setMaLopSV(String maLopSV) {
        this.maLopSV = maLopSV;
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

    public int getMaNganh() {
        return maNganh;
    }

    public void setMaNganh(int maNganh) {
        this.maNganh = maNganh;
    }

    public String getKhoa() {
        return khoa;
    }

    public void setKhoa(String khoa) {
        this.khoa = khoa;
    }

    public String getHeDaoTao() {
        return heDaoTao;
    }

    public void setHeDaoTao(String heDaoTao) {
        this.heDaoTao = heDaoTao;
    }

    public Set<SinhVien> getSinhViens() {
        return sinhViens;
    }

    public void setSinhViens(Set<SinhVien> sinhViens) {
        this.sinhViens = sinhViens;
    }

    public Set<NhomHocPhan> getNhomHocPhans() {
        return nhomHocPhans;
    }

    public void setNhomHocPhans(Set<NhomHocPhan> nhomHocPhans) {
        this.nhomHocPhans = nhomHocPhans;
    }
}