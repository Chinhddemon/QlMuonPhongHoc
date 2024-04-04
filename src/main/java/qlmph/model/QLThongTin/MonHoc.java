package qlmph.model.QLThongTin;

import java.util.Date;
import java.util.Set;

import javax.persistence.*;

import qlmph.utils.Converter;

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

    @OneToMany(mappedBy = "monHoc")
    private Set<LopHocPhan> lopHocPhans;
    
    @Override
    public String toString() {
        return "MonHoc [maMH=" + maMH + ", tenMH=" + tenMH + ", _ActiveAt=" + _ActiveAt + ", lopHocPhans=" + lopHocPhans
                + "]";
    }

    public MonHoc() {
    }

    public MonHoc(String maMH, String tenMH, Date _ActiveAt, Set<LopHocPhan> lopHocPhans) {
        this.maMH = maMH;
        this.tenMH = tenMH;
        this._ActiveAt = _ActiveAt;
        this.lopHocPhans = lopHocPhans;
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

    public String get_ActiveAt() {
        return Converter.DateTimeToString(_ActiveAt);
    }

    public void set_ActiveAt(Date _ActiveAt) {
        this._ActiveAt = _ActiveAt;
    }

public Set<LopHocPhan> getLopHocPhans() {
        return lopHocPhans;
    }

    public void setLopHocPhans(Set<LopHocPhan> lopHocPhans) {
        this.lopHocPhans = lopHocPhans;
    }

}