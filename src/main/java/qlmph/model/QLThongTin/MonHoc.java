package qlmph.model.QLThongTin;

import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name = "MonHoc")
public class MonHoc {
    
    @Id
    @Column(name = "MaMH")
    private String maMH;

    @Column(name = "TenMH")
    private String tenMH;

    @Column(name = "_ActiveAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _ActiveAt;
    
    public MonHoc() {
    }

    public MonHoc(String maMH, String tenMH, Date _ActiveAt) {
        this.maMH = maMH;
        this.tenMH = tenMH;
        this._ActiveAt = _ActiveAt;
    }

    public String getMaMH() {
        return maMH;
    }

    public void setMaMH(String maMH) {
        this.maMH = maMH;
    }

    public String getTenMH() {
        return tenMH;
    }

    public void setTenMH(String tenMH) {
        this.tenMH = tenMH;
    }

    public Date get_ActiveAt() {
        return _ActiveAt;
    }

    public void set_ActiveAt(Date _ActiveAt) {
        this._ActiveAt = _ActiveAt;
    }

}
