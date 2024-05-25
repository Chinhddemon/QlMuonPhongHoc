package qlmph.model.universityBase;

import javax.persistence.*;

import qlmph.model.universityBorrowRoom.LichMuonPhong;

import java.util.Date;
import java.util.List;

@Entity
public class PhongHoc {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int idPhongHoc;

  private String maPhongHoc;

  private int sucChua;

  private char _Status = 'A';

  @Temporal(TemporalType.TIMESTAMP)
  private Date _ActiveAt = new Date();

  @OneToMany
  @JoinColumn(name = "idPhongHoc", referencedColumnName = "idPhongHoc")
  private List<LichMuonPhong> lichMuonPhongs;

  public PhongHoc() {
  }

  public int getIdPhongHoc() {
    return idPhongHoc;
  }

  public void setIdPhongHoc(int idPhongHoc) {
    this.idPhongHoc = idPhongHoc;
  }

  public String getMaPhongHoc() {
    return maPhongHoc;
  }

  public void setMaPhongHoc(String maPhongHoc) {
    this.maPhongHoc = maPhongHoc;
  }

  public int getSucChua() {
    return sucChua;
  }

  public void setSucChua(int sucChua) {
    this.sucChua = sucChua;
  }

  public char get_Status() {
    return _Status;
  }

  public void set_Status(char _Status) {
    this._Status = _Status;
  }

  public Date get_ActiveAt() {
    return _ActiveAt;
  }

  public void set_ActiveAt(Date _ActiveAt) {
    this._ActiveAt = _ActiveAt;
  }

  public List<LichMuonPhong> getLichMuonPhongs() {
    return lichMuonPhongs;
  }

  public void setLichMuonPhongs(List<LichMuonPhong> lichMuonPhongs) {
    this.lichMuonPhongs = lichMuonPhongs;
  }
}
