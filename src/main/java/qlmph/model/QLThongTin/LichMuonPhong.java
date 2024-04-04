package qlmph.model.QLThongTin;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name = "LichMuonPhong")
public class LichMuonPhong {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    
    @Column(name = "MaQLKhoiTao", length = 15, nullable = false)
    private String maQLKhoiTao;
    
    @Column(name = "ThoiGian_BD", nullable = false, columnDefinition = "(ThoiGian_BD > GETDATE())")
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_BD;

    @Column(name = "ThoiGian_KT", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date thoiGian_KT;
    
    @Column(name = "MucDich", length = 2, nullable = false)
    private String mucDich;

    @Column(name = "LyDo", length = 31)
    private String lyDo;

    @Column(name = "_CreateAt", nullable = false, columnDefinition = "datetime DEFAULT GETDATE()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt;
    
    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    @Override
    public String toString() {
        return "LichMuonPhong [idLMPH=" + idLMPH + ", muonPhongHoc=" + muonPhongHoc + ", phongHoc=" + phongHoc
                + ", lopHocPhan=" + lopHocPhan + ", thoiGian_BD=" + thoiGian_BD + ", thoiGian_KT=" + thoiGian_KT
                + ", mucDich=" + mucDich + ", lyDo=" + lyDo + ", _CreateAt=" + _CreateAt + ", _DeleteAt=" + _DeleteAt
                + "]";
    }
    
    public LichMuonPhong() {
    }
    
    public LichMuonPhong(int idLMPH, MuonPhongHoc muonPhongHoc, PhongHoc phongHoc, LopHocPhan lopHocPhan,
            String maQLKhoiTao, Date thoiGian_BD, Date thoiGian_KT, String mucDich, String lyDo, Date _CreateAt,
            Date _DeleteAt) {
        this.idLMPH = idLMPH;
        this.muonPhongHoc = muonPhongHoc;
        this.phongHoc = phongHoc;
        this.lopHocPhan = lopHocPhan;
        this.maQLKhoiTao = maQLKhoiTao;
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
    
    public String getMaQLKhoiTao() {
        return maQLKhoiTao;
    }
    
    public void setMaQLKhoiTao(String maQLKhoiTao) {
        this.maQLKhoiTao = maQLKhoiTao;
    }
    
    public String getThoiGian_BD() {
        if(thoiGian_BD == null) return "";
        return new SimpleDateFormat("HH:mm dd/MM/yyyy").format(thoiGian_BD);
    }
    
    public void setThoiGian_BD(Date thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }
    
    public String getThoiGian_KT() {
        if(thoiGian_KT == null) return "";
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
    
    @PrePersist
    public void validateThoiGian() {
        if (thoiGian_BD != null && thoiGian_KT != null && thoiGian_BD.after(thoiGian_KT)) {
            throw new IllegalArgumentException("ThoiGian_BD must be before ThoiGian_KT");
        }
    }
}