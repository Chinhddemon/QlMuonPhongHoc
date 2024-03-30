package qlmph.model.QLThongTin;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name = "LichMuonPhong")
public class LichMuonPhong {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "IdLMPH")
    private int idLMPH;

    @OneToOne(mappedBy = "lichMuonPhong")
    private MuonPhongHoc muonPhongHoc;

    @ManyToOne
    @JoinColumn(name = "IdPH", referencedColumnName = "IdPH")
    private PhongHoc phongHoc;

    @ManyToOne
    @JoinColumn(name = "IdLHP", referencedColumnName = "IdLHP")
    private LopHocPhan lopHocPhan;

    @Column(name = "ThoiGian_BD")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_BD;

    @Column(name = "ThoiGian_KT")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_KT;

    @Column(name = "MucDich")
    private String mucDich;

    @Column(name = "LyDo")
    private String lyDo;

    @Column(name = "_CreateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt;

    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    public LichMuonPhong() {
    }

    public LichMuonPhong(int idLMPH, MuonPhongHoc muonPhongHoc, PhongHoc phongHoc, LopHocPhan lopHocPhan,
            Date thoiGian_BD, Date thoiGian_KT, String mucDich, String lyDo, Date _CreateAt, Date _DeleteAt) {
        this.idLMPH = idLMPH;
        this.muonPhongHoc = muonPhongHoc;
        this.phongHoc = phongHoc;
        this.lopHocPhan = lopHocPhan;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.mucDich = mucDich;
        this.lyDo = lyDo;
        this._CreateAt = _CreateAt;
        this._DeleteAt = _DeleteAt;
    }

    public int getIdLMPH() {
        return idLMPH;
    }

    public void setIdLMPH(int idLMPH) {
        this.idLMPH = idLMPH;
    }

    public MuonPhongHoc getMuonPhongHoc() {
        return muonPhongHoc;
    }

    public void setMuonPhongHoc(MuonPhongHoc muonPhongHoc) {
        this.muonPhongHoc = muonPhongHoc;
    }

    public PhongHoc getPhongHoc() {
        return phongHoc;
    }

    public void setPhongHoc(PhongHoc phongHoc) {
        this.phongHoc = phongHoc;
    }

    public LopHocPhan getLopHocPhan() {
        return lopHocPhan;
    }

    public void setLopHocPhan(LopHocPhan lopHocPhan) {
        this.lopHocPhan = lopHocPhan;
    }

    public String getThoiGian_BD() {
        return new SimpleDateFormat("HH:mm dd/MM/yyyy").format(thoiGian_BD);
    }

    public void setThoiGian_BD(Date thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }

    public String getThoiGian_KT() {
        return new SimpleDateFormat("HH:mm dd/MM/yyyy").format(thoiGian_KT);
    }

    public void setThoiGian_KT(Date thoiGian_KT) {
        this.thoiGian_KT = thoiGian_KT;
    }

    public String getMucDich() {
        return mucDich;
    }

    public void setMucDich(String mucDich) {
        this.mucDich = mucDich;
    }

    public String getLyDo() {
        return lyDo;
    }

    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }

    public Date get_CreateAt() {
        return _CreateAt;
    }

    public void set_CreateAt(Date _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public Date get_DeleteAt() {
        return _DeleteAt;
    }

    public void set_DeleteAt(Date _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }

}
