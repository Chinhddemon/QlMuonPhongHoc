package qlmph.model.user;

import java.util.Date;

import javax.persistence.*;

@Entity
public class NguoiDung {
  @Id //khóa chính
  @GeneratedValue(strategy = GenerationType.IDENTITY)//khóa tự tăng
  private int idNguoiDung;

  private String hoTen;

  @Temporal(TemporalType.DATE)//chỉ lưu dd/mm/yyy bỏ pua h,phút,s
  private Date ngaySinh;

  private String gioiTinh;
  
  private String diaChi;

  @OneToOne(mappedBy = "nguoiDung")
  private SinhVien sinhVien;

  @OneToOne(mappedBy = "nguoiDung")
  private GiangVien giangVien;

  @OneToOne(mappedBy = "nguoiDung")
  private QuanLy quanLy;

  public NguoiDung() {
  }

  public int getIdNguoiDung() {
    return idNguoiDung;
  }

  public void setIdNguoiDung(int idNguoiDung) {
    this.idNguoiDung = idNguoiDung;
  }

  public String getHoTen() {
    return hoTen;
  }

  public void setHoTen(String hoTen) {
    this.hoTen = hoTen;
  }

  public Date getNgaySinh() {
    return ngaySinh;
  }

  public void setNgaySinh(Date ngaySinh) {
    this.ngaySinh = ngaySinh;
  }

  public String getGioiTinh() {
    return gioiTinh;
  }

  public void setGioiTinh(String gioiTinh) {
    this.gioiTinh = gioiTinh;
  }

  public String getDiaChi() {
    return diaChi;
  }

  public void setDiaChi(String diaChi) {
    this.diaChi = diaChi;
  }

  public SinhVien getSinhVien() {
    return sinhVien;
  }

  public void setSinhVien(SinhVien sinhVien) {
    this.sinhVien = sinhVien;
  }

  public GiangVien getGiangVien() {
    return giangVien;
  }

  public void setGiangVien(GiangVien giangVien) {
    this.giangVien = giangVien;
  }

  public QuanLy getQuanLy() {
    return quanLy;
  }

  public void setQuanLy(QuanLy quanLy) {
    this.quanLy = quanLy;
  }
}
