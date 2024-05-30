package qlmph.model.user;

import java.util.UUID;

import javax.persistence.*;

import org.hibernate.annotations.Type;

@SuppressWarnings("deprecation")
@Entity
public class GiangVien {
  @Id
  private String maGiangVien;

  @OneToOne
  @JoinColumn(name = "idNguoiDung", referencedColumnName = "idNguoiDung")
  private NguoiDung nguoiDung;

  @Type(type = "uuid-char")// thuộc tính này kiểu uuid lưu dưới dạng chuổi trong csdl,Sử dụng chú thích này giúp Hibernate biết cách ánh xạ kiểu dữ liệu UUID trong Java tới một chuỗi ký tự trong cơ sở dữ liệu,
  private UUID idTaiKhoan;

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

  public UUID getIdTaiKhoan() {
    return idTaiKhoan;
  }

  public void setIdTaiKhoan(UUID idTaiKhoan) {
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
