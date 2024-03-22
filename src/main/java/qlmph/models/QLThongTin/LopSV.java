package qlmph.models.QLThongTin;

public class LopSV {
    private String maLopSV;
    private String tenLopSV;
    
    public LopSV() {
    }

    public LopSV(String maLopSV, String tenLopSV) {
        this.maLopSV = maLopSV;
        this.tenLopSV = tenLopSV;
    }

    public String getMaLopSV() {
        return maLopSV;
    }

    public void setMaLopSV(String maLopSV) {
        this.maLopSV = maLopSV;
    }

    public String getTenLopSV() {
        return tenLopSV;
    }

    public void setTenLopSV(String tenLopSV) {
        this.tenLopSV = tenLopSV;
    }

}
