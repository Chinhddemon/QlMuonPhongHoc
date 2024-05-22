package qlmph.model.user;

import javax.persistence.*;

@Entity
public class QuanLy {
  @Id
  @Column(name = "maQuanLy")
  private String maQuanLy;

  @OneToOne
  @JoinColumn(name = "idNguoiDung", referencedColumnName = "idNguoiDung")
  private NguoiDung nguoiDung;

  private String idTaiKhoan;

  private String emailQuanLy;

  private String sdt;

  private String maChucDanh_NgheNghiep;

  public QuanLy() {
  }

  public String getMaQuanLy() {
    return maQuanLy;
  }

  public void setMaQuanLy(String maQuanLy) {
    this.maQuanLy = maQuanLy;
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

  public String getEmailQuanLy() {
    return emailQuanLy;
  }

  public void setEmailQuanLy(String emailQuanLy) {
    this.emailQuanLy = emailQuanLy;
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
