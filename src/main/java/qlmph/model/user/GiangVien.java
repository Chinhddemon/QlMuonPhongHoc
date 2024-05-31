package qlmph.model.user;

import javax.persistence.*;

@Entity
public class GiangVien {
  @Id
  private String maGiangVien;

  @OneToOne
  @JoinColumn(name = "idNguoiDung", referencedColumnName = "idNguoiDung")
  private NguoiDung nguoiDung;

  private String idTaiKhoan;

  private String emailGiangVien;

  private String sdt;

  private String maChucDanh_NgheNghiep;

  public GiangVien() {
  }

  public String getMaGiangVien() {
    return maGiangVien;
  }

  public void setMaGiangVien(String maGiangVien) {
    this.maGiangVien = maGiangVien;
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

  public String getEmailGiangVien() {
    return emailGiangVien;
  }

  public void setEmailGiangVien(String emailGiangVien) {
    this.emailGiangVien = emailGiangVien;
  }

  public String getSdt() {
    return sdt;
  }

  public void setSdt(String sdt) {
    this.sdt = sdt;
  }

  public String getMaChucDanh_NgheNghiep() {
    return maChucDanh_NgheNghiep;
  }

  public void setMaChucDanh_NgheNghiep(String maChucDanh_NgheNghiep) {
    this.maChucDanh_NgheNghiep = maChucDanh_NgheNghiep;
  }
}
