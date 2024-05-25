package qlmph.model.universityCourse;

import javax.persistence.*;

import qlmph.model.universityBase.LopSinhVien;

import java.util.Date;
import java.util.List;

@Entity
public class HocKy_LopSinhVien {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int idHocKy_LopSinhVien;

  @ManyToOne
  @JoinColumn(name = "maLopSinhVien", referencedColumnName = "maLopSinhVien")
  private LopSinhVien lopSinhVien;

  private String maHocKy;

  @Temporal(TemporalType.DATE)
  private Date startDate;

  @Temporal(TemporalType.DATE)
  private Date endDate;

  @OneToMany(mappedBy = "hocKy_LopSinhVien")
  private List<NhomHocPhan> nhomHocPhans;

  public HocKy_LopSinhVien() {
  }

  public int getIdHocKy_LopSinhVien() {
    return idHocKy_LopSinhVien;
  }

  public void setIdHocKy_LopSinhVien(int idHocKy_LopSinhVien) {
    this.idHocKy_LopSinhVien = idHocKy_LopSinhVien;
  }

  public LopSinhVien getLopSinhVien() {
    return lopSinhVien;
  }

  public void setLopSinhVien(LopSinhVien lopSinhVien) {
    this.lopSinhVien = lopSinhVien;
  }

  public String getMaHocKy() {
    return maHocKy;
  }

  public void setMaHocKy(String maHocKy) {
    this.maHocKy = maHocKy;
  }

  public Date getStartDate() {
    return startDate;
  }

  public void setStartDate(Date startDate) {
    this.startDate = startDate;
  }

  public Date getEndDate() {
    return endDate;
  }

  public void setEndDate(Date endDate) {
    this.endDate = endDate;
  }

  public List<NhomHocPhan> getNhomHocPhans() {
    return nhomHocPhans;
  }

  public void setNhomHocPhans(List<NhomHocPhan> nhomHocPhans) {
    this.nhomHocPhans = nhomHocPhans;
  }
}
