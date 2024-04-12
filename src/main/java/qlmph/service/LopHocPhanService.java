package qlmph.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LopHocPhan;
import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.repository.QLThongTin.LopHocPhanRepository;

@Service
public class LopHocPhanService {
    
    @Autowired
    LopHocPhanRepository lopHocPhanRepository;

    /*
     * Lấy danh sách lớp học phần:
     * - Lấy danh sách lớp học phần từ repository
     * - Tách dữ liệu lớp học phần ra thành từng cặp
     * - Trả về danh sách lớp học phần
     */

    public Map<LopHocPhan, LopHocPhanSection> layDanhSach() {
        return xuLyDanhSach(lopHocPhanRepository.getAll());
    }

    private Map<LopHocPhan, LopHocPhanSection> xuLyDanhSach(List<LopHocPhan> DsLopHocPhan) {
        /*
         * Xử lý ngoại lệ:
         * 1. Nếu danh sách lớp học phần rỗng, trả về danh sách rỗng
         * 2. Mỗi học phần chỉ chứa 1 hoặc 2 section
         * Ví dụ:  - LHP1: Section1, Section2, Section3,...
         *         - LHP2: Section3
         * 3. Section đầu tiên không có nhóm tổ, section thứ 2 có thể có hoặc không có nhóm tổ
         * Ví dụ:  - LHP1: Section1 không có nhóm tổ, Section2 nhóm tổ 1, Section3 nhóm tổ 2,...
         *         - LHP2: Section4 không có nhóm tổ, Section5 không có nhóm tổ, không tồn tại các section khác
         */
        // System.out.println("Service record:     " + DsLopHocPhan.size());
        // for (LopHocPhan lopHocPhan : DsLopHocPhan) {
        //     System.out.println("lophocphan-id:      " + lopHocPhan.getIdLHP());
        //     System.out.println("lophocPhan-size:    " + lopHocPhan.getLopHocPhanSections().size());
        //     System.out.println("lophocphan-nhom:    " + lopHocPhan.getNhom());
        //     for (LopHocPhanSection section : lopHocPhan.getLopHocPhanSections()) {
        //         System.out.println("section-id:     " + section.getIdLHPSection());
        //         System.out.println("section-nhomto: " + section.getNhomTo());
        //     }
        // }
        if(DsLopHocPhan == null || DsLopHocPhan.size() == 0) {
            return new HashMap<LopHocPhan, LopHocPhanSection>();
        }
        Map<LopHocPhan, LopHocPhanSection> result = new HashMap<LopHocPhan, LopHocPhanSection>();
        for (LopHocPhan lopHocPhan : DsLopHocPhan) {
            if(lopHocPhan.getLopHocPhanSections() == null || lopHocPhan.getLopHocPhanSections().size() == 0) {
                continue;
            }
            if(lopHocPhan.getLopHocPhanSections().size() == 1) { System.out.println(lopHocPhan.getIdLHP());
                result.put(lopHocPhan, null);
                continue;
            }
            // Tìm section không có nhóm tổ
            LopHocPhanSection lopHocPhanSectionPlaceHolder = null;
            {
                boolean hasSectionWithNhomTo = false;
                LopHocPhanSection lopHocPhanSecondSection = null;
                for (LopHocPhanSection lopHocPhanSection : lopHocPhan.getLopHocPhanSections()) {
                    if(lopHocPhanSection.getNhomTo().equals("")) {
                        if(lopHocPhanSecondSection != null) {
                            new Exception("Không được phép tồn tại nhiều hơn 2 section không có nhóm tổ").printStackTrace();
                            return null;
                        } else {
                            if(lopHocPhanSectionPlaceHolder == null) {
                                lopHocPhanSectionPlaceHolder = lopHocPhanSection;
                            } else {
                                if(hasSectionWithNhomTo) {
                                    new Exception("Không được phép tồn tại section có nhóm tổ khi tồn tại 2 section không có nhóm tổ").printStackTrace();
                                    return null;
                                } else {
                                    lopHocPhanSecondSection = lopHocPhanSection;
                                }
                            }
                        }
                    } else {
                        if(lopHocPhanSecondSection != null) {
                            new Exception("Không được phép tồn tại section có nhóm tổ khi tồn tại 2 section không có nhóm tổ").printStackTrace();
                            return null;
                        } else {
                            hasSectionWithNhomTo = true;
                        }
                    }
                }
                
                if(lopHocPhanSecondSection != null) {
                    lopHocPhan.setLopHocPhanSections(List.of(lopHocPhanSectionPlaceHolder));
                    result.put(lopHocPhan, lopHocPhanSecondSection);
                    continue;
                }
            }
            
            // Tìm section có nhóm tổ
            for (LopHocPhanSection lopHocPhanSection : lopHocPhan.getLopHocPhanSections()) {
                if(!lopHocPhanSection.getNhomTo().equals("")) { 
                    lopHocPhan.setLopHocPhanSections(List.of(lopHocPhanSectionPlaceHolder));
                    result.put(lopHocPhan, lopHocPhanSection);
                }
            }
        }
        // System.out.println("Size map:" + result.size());
        // for (Map.Entry<LopHocPhan, LopHocPhanSection> iter : result.entrySet()) {
        //     LopHocPhan key = iter.getKey();
        //     LopHocPhanSection value = iter.getValue();
        //     System.out.println("IdLHP:          " + key.getIdLHP());
        //     System.out.println("Nhom:           " + key.getLopHocPhanSections().size());
        //     if(value != null)  {
        //         System.out.println("IdLHPSection:   " + value.getIdLHPSection());
        //         System.out.println("NhomTo          " + value.getNhomTo());
        //     }
        // }
        return result;
    }

    public LopHocPhan layThongTin(int IdLHP) {
        return lopHocPhanRepository.getByIdLHP(IdLHP);
    }
    
    public LopHocPhan layThongTin(String MaGV, String MaLopSV, String MaMH) {
        return lopHocPhanRepository.getByMaGVAndMaLopSVAndMaMH(MaGV, MaLopSV, MaMH);
    }

    public static void main (String[] args) {
        LopHocPhanService lopHocPhanService = new LopHocPhanService();

        // Call the method under test
        lopHocPhanService.xuLyDanhSach(testData2());

    }
    private static List<LopHocPhan> testData() {
        List<LopHocPhan> DsLopHocPhan = new ArrayList<>();
        DsLopHocPhan.add(new LopHocPhan());
        LopHocPhanSection lopHocPhanSection = new LopHocPhanSection();
        lopHocPhanSection.setIdLHPSection(0);
        lopHocPhanSection.setNhomTo((byte) 3);
        LopHocPhanSection lopHocPhanSection1 = new LopHocPhanSection();
        lopHocPhanSection1.setIdLHPSection(1);
        lopHocPhanSection1.setNhomTo((byte) 2);
        LopHocPhanSection lopHocPhanSection2 = new LopHocPhanSection();
        lopHocPhanSection2.setIdLHPSection(2);
        lopHocPhanSection2.setNhomTo((byte) 0);
        LopHocPhanSection lopHocPhanSection3 = new LopHocPhanSection();
        lopHocPhanSection3.setIdLHPSection(3);
        lopHocPhanSection3.setNhomTo((byte) 1);
        // Add some LopHocPhan objects to the list
        DsLopHocPhan.get(0).setLopHocPhanSections(List.of(lopHocPhanSection3, lopHocPhanSection1, lopHocPhanSection2, lopHocPhanSection));
        return DsLopHocPhan;
    }
    private static List<LopHocPhan> testData2() {
        List<LopHocPhan> DsLopHocPhan = new ArrayList<>();
        DsLopHocPhan.add(new LopHocPhan());
        LopHocPhanSection lopHocPhanSection = new LopHocPhanSection();
        lopHocPhanSection.setNhomTo((byte) 0);
        LopHocPhanSection lopHocPhanSection1 = new LopHocPhanSection();
        lopHocPhanSection1.setNhomTo((byte) 0);
        LopHocPhanSection lopHocPhanSection2 = new LopHocPhanSection();
        lopHocPhanSection2.setNhomTo((byte) 2);
        LopHocPhanSection lopHocPhanSection3 = new LopHocPhanSection();
        lopHocPhanSection3.setNhomTo((byte) 1);
        // Add some LopHocPhan objects to the list
        DsLopHocPhan.get(0).setLopHocPhanSections(List.of(lopHocPhanSection3, lopHocPhanSection1, lopHocPhanSection2, lopHocPhanSection));
        return DsLopHocPhan;
    }
}
