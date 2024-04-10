package qlmph.model.QLThongTin;

import java.util.Date;
import java.util.Set;

import javax.persistence.*;

import qlmph.utils.Converter;

@Entity
@Table(name = "PhongHoc")
public class PhongHoc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdPH")
    private int idPH;

    @Column(name = "MaPH")
    private String maPH;

    @Column(name = "SucChua")
    private short sucChua;

    @Column(name = "TinhTrang")
    private String tinhTrang;

    @Column(name = "_ActiveAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _ActiveAt;

    @OneToMany(mappedBy = "phongHoc")
    Set <LichMuonPhong> lichMuonPhongs;

    @Override
    public String toString() {
        return "PhongHoc [idPH=" + idPH + ", maPH=" + maPH + ", sucChua=" + sucChua + ", tinhTrang=" + tinhTrang
                + ", _ActiveAt=" + _ActiveAt + ", lichMuonPhongs=" + lichMuonPhongs + "]";
    }

    public PhongHoc() {
    }

    public PhongHoc(int idPH, String maPH, short sucChua, String tinhTrang) {
        this.idPH = idPH;
        this.maPH = maPH;
        this.sucChua = sucChua;
        this.tinhTrang = tinhTrang;
    }

    public int getIdPH() {
        return idPH;
    }

    public void setIdPH(int idPH) {
        this.idPH = idPH;
    }

    public String getMaPH() {
        return maPH;
    }

    public void setMaPH(String maPH) {
        this.maPH = maPH;
    }

    public short getSucChua() {
        return sucChua;
    }

    public void setSucChua(short sucChua) {
        this.sucChua = sucChua;
    }

    public String getTinhTrang() {
        return tinhTrang;
    }

    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }

    public String get_ActiveAt() {
        return Converter.DateTimeToString(_ActiveAt);
    }

    public void set_ActiveAt(Date _ActiveAt) {
        this._ActiveAt = _ActiveAt;
    }

public Set<LichMuonPhong> getLichMuonPhongs() {
        return lichMuonPhongs;
    }

    public void setLichMuonPhongs(Set<LichMuonPhong> lichMuonPhongs) {
        this.lichMuonPhongs = lichMuonPhongs;
    }

}
