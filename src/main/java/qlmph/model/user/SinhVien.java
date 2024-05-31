package qlmph.model.user;

import javax.persistence.*;

import qlmph.model.universityBase.LopSinhVien;

@Entity
public class SinhVien {
  @Id
  private String maSinhVien;

  @OneToOne
  @JoinColumn(name = "idNguoiDung")
  private NguoiDung nguoiDung;

  private String idTaiKhoan; 

  @ManyToOne
  @JoinColumn(name = "maLopSinhVien")
  private LopSinhVien lopSinhVien;

  private String emailSinhVien;

  private String sdt;

  private String maChucVu_LopSinhVien;

  public SinhVien() {
  }

  public String getMaSinhVien() {
    return maSinhVien;
  }

  public void setMaSinhVien(String maSinhVien) {
    this.maSinhVien = maSinhVien;
  }

  public NguoiDung getNguoiDung() {
    return nguoiDung;
  }

  public void setNguoiDung(NguoiDung nguoiDung) {
    this.nguoiDung = nguoiDung;
  }

  public String getIdTaiKhoan() {
    return idTaiKhoan;
  }

  public void setIdTaiKhoan(String idTaiKhoan) {
    this.idTaiKhoan = idTaiKhoan;
  }

  public LopSinhVien getLopSinhVien() {
    return lopSinhVien;
  }

  public void setLopSinhVien(LopSinhVien lopSinhVien) {
    this.lopSinhVien = lopSinhVien;
  }

  public String getEmailSinhVien() {
    return emailSinhVien;
  }

  public void setEmailSinhVien(String emailSinhVien) {
    this.emailSinhVien = emailSinhVien;
  }

  public String getSdt() {
    return sdt;
  }

  public void setSdt(String sdt) {
    this.sdt = sdt;
  }

  public String getMaChucVu_LopSinhVien() {
    return maChucVu_LopSinhVien;
  }

  public void setMaChucVu_LopSinhVien(String maChucVu_LopSinhVien) {
    this.maChucVu_LopSinhVien = maChucVu_LopSinhVien;
  }
}
