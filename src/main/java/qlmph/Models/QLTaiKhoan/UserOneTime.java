package qlmph.models.QLTaiKhoan;

import java.sql.Timestamp;

public class UserOneTime {
    private String idUserOneTime;
    private String idTaiKhoan;
    private String idQL_Duyet;
    private String minhChung;
    private String lyDo;
    private Timestamp _CreateAt;
    private Timestamp _UsedAt;
    private Timestamp _ExpireAt;

    public UserOneTime() {
    }

    public UserOneTime(String idUserOneTime, String idTaiKhoan, String idQL_Duyet, String minhChung, String lyDo,
            Timestamp _CreateAt, Timestamp _UsedAt, Timestamp _ExpireAt) {
        this.idUserOneTime = idUserOneTime;
        this.idTaiKhoan = idTaiKhoan;
        this.idQL_Duyet = idQL_Duyet;
        this.minhChung = minhChung;
        this.lyDo = lyDo;
        this._CreateAt = _CreateAt;
        this._UsedAt = _UsedAt;
        this._ExpireAt = _ExpireAt;
    }

    public String getIdUserOneTime() {
        return idUserOneTime;
    }

    public void setIdUserOneTime(String idUserOneTime) {
        this.idUserOneTime = idUserOneTime;
    }

    public String getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(String idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public String getIdQL_Duyet() {
        return idQL_Duyet;
    }

    public void setIdQL_Duyet(String idQL_Duyet) {
        this.idQL_Duyet = idQL_Duyet;
    }

    public String getMinhChung() {
        return minhChung;
    }

    public void setMinhChung(String minhChung) {
        this.minhChung = minhChung;
    }

    public String getLyDo() {
        return lyDo;
    }

    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }

    public Timestamp get_CreateAt() {
        return _CreateAt;
    }

    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public Timestamp get_UsedAt() {
        return _UsedAt;
    }

    public void set_UsedAt(Timestamp _UsedAt) {
        this._UsedAt = _UsedAt;
    }

    public Timestamp get_ExpireAt() {
        return _ExpireAt;
    }

    public void set_ExpireAt(Timestamp _ExpireAt) {
        this._ExpireAt = _ExpireAt;
    }

}
