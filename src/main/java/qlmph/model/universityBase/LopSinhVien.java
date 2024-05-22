package qlmph.model.universityBase;

import java.util.List;

import javax.persistence.*;

import qlmph.model.user.SinhVien;

@Entity
public class LopSinhVien {
  @Id
  private String maLopSinhVien;

  private short startAt_nienKhoa;

  private short endAt_nienKhoa;

  private int maNganh;

  private String khoa;

  private String maHeDaoTao;

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

  public short getStartAt_nienKhoa() {
    return startAt_nienKhoa;
  }

  public void setStartAt_nienKhoa(short startAt_nienKhoa) {
    this.startAt_nienKhoa = startAt_nienKhoa;
  }

  public short getEndAt_nienKhoa() {
    return endAt_nienKhoa;
  }

  public void setEndAt_nienKhoa(short endAt_nienKhoa) {
    this.endAt_nienKhoa = endAt_nienKhoa;
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

  public String getMaHeDaoTao() {
    return maHeDaoTao;
  }

  public void setMaHeDaoTao(String maHeDaoTao) {
    this.maHeDaoTao = maHeDaoTao;
  }

  public List<SinhVien> getSinhViens() {
    return sinhViens;
  }

  public void setSinhViens(List<SinhVien> sinhViens) {
    this.sinhViens = sinhViens;
  }
}
