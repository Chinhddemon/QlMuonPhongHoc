package qlmph.model.user;

import java.util.UUID;

import javax.persistence.*;

import org.hibernate.annotations.Type;

import qlmph.model.universityBase.LopSinhVien;

@SuppressWarnings("deprecation")
@Entity
public class SinhVien {
  @Id
  private String maSinhVien;

  @OneToOne
  @JoinColumn(name = "idNguoiDung")
  private NguoiDung nguoiDung;

  @Type(type = "uuid-char")
  private UUID idTaiKhoan; 

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

  public UUID getIdTaiKhoan() {
    return idTaiKhoan;
  }

  public void setIdTaiKhoan(UUID idTaiKhoan) {
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
