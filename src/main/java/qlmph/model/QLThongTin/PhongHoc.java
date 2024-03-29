package qlmph.model.QLThongTin;

import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name = "PhongHoc")
public class PhongHoc {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "IdPH")
    private int idPH;

    @Column(name = "MaPH")
    private String maPH;

    @Column(name = "TinhTrang")
    private String tinhTrang;

    @Column(name = "_ActiveAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _ActiveAt;

    public PhongHoc() {
    }

    public PhongHoc(int idPH, String maPH, String tinhTrang, Date _ActiveAt) {
        this.idPH = idPH;
        this.maPH = maPH;
        this.tinhTrang = tinhTrang;
        this._ActiveAt = _ActiveAt;
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

    public String getTinhTrang() {
        return tinhTrang;
    }

    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }

    public Date get_ActiveAt() {
        return _ActiveAt;
    }

    public void set_ActiveAt(Date _ActiveAt) {
        this._ActiveAt = _ActiveAt;
    }

}