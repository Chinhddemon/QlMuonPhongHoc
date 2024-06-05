package qlmph.model.universityBase;

import java.util.List;

import javax.persistence.*;

import qlmph.model.user.SinhVien;

@Entity
public class LopSinhVien {
  @Id
  private String maLopSinhVien;

  private short startYear_NienKhoa;

  private short endYear_NienKhoa;

  private int maNganh;

  private String tenKhoa;

  private String maHeDaoTao;

  private String maChatLuongDaoTao;

  @OneToMany(mappedBy = "lopSinhVien", fetch = FetchType.LAZY)
  private List<SinhVien> sinhViens;

  public LopSinhVien() {
  }

  public String getMaLopSinhVien() {
    return maLopSinhVien;
  }

  public void setMaLopSinhVien(String maLopSinhVien) {
    this.maLopSinhVien = maLopSinhVien;
  }

  public short getStartYear_NienKhoa() {
    return startYear_NienKhoa;
  }

  public void setStartYear_NienKhoa(short startYear_NienKhoa) {
    this.startYear_NienKhoa = startYear_NienKhoa;
  }

  public short getEndYear_NienKhoa() {
    return endYear_NienKhoa;
  }

  public void setEndYear_NienKhoa(short endYear_NienKhoa) {
    this.endYear_NienKhoa = endYear_NienKhoa;
  }

  public int getMaNganh() {
    return maNganh;
  }

  public void setMaNganh(int maNganh) {
    this.maNganh = maNganh;
  }

  public String getTenKhoa() {
    return tenKhoa;
  }

  public void setTenKhoa(String tenKhoa) {
    this.tenKhoa = tenKhoa;
  }

  public String getMaHeDaoTao() {
    return maHeDaoTao;
  }

  public void setMaHeDaoTao(String maHeDaoTao) {
    this.maHeDaoTao = maHeDaoTao;
  }

  public String getMaChatLuongDaoTao() {
    return maChatLuongDaoTao;
  }

  public void setMaChatLuongDaoTao(String maChatLuongDaoTao) {
    this.maChatLuongDaoTao = maChatLuongDaoTao;
  }

  public List<SinhVien> getSinhViens() {
    return sinhViens;
  }

  public void setSinhViens(List<SinhVien> sinhViens) {
    this.sinhViens = sinhViens;
  }
}
