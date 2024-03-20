package qlmph.models.QLTaiKhoan;

import java.sql.Timestamp;

public class UserOneTime {
    private int idUserOneTime;
    private int idQLDuyet;
    private String minhChung;
    private String lyDo;
    private Timestamp _CreateAt;
    private Timestamp _UsedAt;
    private Timestamp _ExpireAt;

    public UserOneTime() {
    }

    public UserOneTime(int idUserOneTime, int idQLDuyet, String minhChung, String lyDo,
            Timestamp _CreateAt, Timestamp _UsedAt, Timestamp _ExpireAt) {
        this.idUserOneTime = idUserOneTime;
        this.idQLDuyet = idQLDuyet;
        this.minhChung = minhChung;
        this.lyDo = lyDo;
        this._CreateAt = _CreateAt;
        this._UsedAt = _UsedAt;
        this._ExpireAt = _ExpireAt;
    }

    public int getIdUserOneTime() {
        return idUserOneTime;
    }

    public void setIdUserOneTime(int idUserOneTime) {
        this.idUserOneTime = idUserOneTime;
    }

    public int getIdQLDuyet() {
        return idQLDuyet;
    }

    public void setIdQL_Duyet(int idQLDuyet) {
        this.idQLDuyet = idQLDuyet;
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
