package qlmph.model.QLTaiKhoan;

import java.util.UUID;
import java.sql.Timestamp;

public class UserOneTime {
    private UUID IdUserOneTime;
    private UUID IdTaiKhoan;
    private UUID IdQL_Duyet;
    private String MinhChung;
    private String LyDo;
    private Timestamp _CreateAt;
    private Timestamp _UsedAt;
    private Timestamp _ExpireAt;

    public UserOneTime() {
    }

    public UserOneTime(UUID idUserOneTime, UUID idTaiKhoan, UUID idQL_Duyet, String minhChung, String lyDo,
            Timestamp _CreateAt, Timestamp _UsedAt, Timestamp _ExpireAt) {
        IdUserOneTime = idUserOneTime;
        IdTaiKhoan = idTaiKhoan;
        IdQL_Duyet = idQL_Duyet;
        MinhChung = minhChung;
        LyDo = lyDo;
        this._CreateAt = _CreateAt;
        this._UsedAt = _UsedAt;
        this._ExpireAt = _ExpireAt;
    }

    public UUID getIdUserOneTime() {
        return IdUserOneTime;
    }

    public void setIdUserOneTime(UUID idUserOneTime) {
        IdUserOneTime = idUserOneTime;
    }

    public UUID getIdTaiKhoan() {
        return IdTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        IdTaiKhoan = idTaiKhoan;
    }

    public UUID getIdQL_Duyet() {
        return IdQL_Duyet;
    }

    public void setIdQL_Duyet(UUID idQL_Duyet) {
        IdQL_Duyet = idQL_Duyet;
    }

    public String getMinhChung() {
        return MinhChung;
    }

    public void setMinhChung(String minhChung) {
        MinhChung = minhChung;
    }

    public String getLyDo() {
        return LyDo;
    }

    public void setLyDo(String lyDo) {
        LyDo = lyDo;
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
