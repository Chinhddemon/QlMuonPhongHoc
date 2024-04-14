package qlmph.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.NhomHocPhan;
import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.repository.QLThongTin.NhomHocPhanRepository;

@Service
public class NhomHocPhanService {
    
    @Autowired
    NhomHocPhanRepository nhomHocPhanRepository;

    /*
     * Lấy danh sách lớp học phần:
     * - Lấy danh sách lớp học phần từ repository
     * - Tách dữ liệu lớp học phần ra thành từng cặp
     * - Trả về danh sách lớp học phần
     */

    public List<NhomHocPhan> layDanhSach() {
        return xuLyDanhSach(nhomHocPhanRepository.getAll());
    }

    private List<NhomHocPhan> xuLyDanhSach(List<NhomHocPhan> DsLopHocPhan) {
        /*
         * Xử lý ngoại lệ:
         * 1. Nếu danh sách lớp học phần rỗng, bỏ qua xử lý và báo lỗi
         * 2. Mỗi học phần chứa 1 section thuộc nhóm, có thể có 1 section không thuộc nhóm tổ hoặc thuộc nhóm tổ
         * Ví dụ:  - LHP1: SectionMain
         *         - LHP2: SectionMain, Section1, Section3,...
         *         - LHP3: SectionMain, Section0
         * 3. Nếu có 1 section không phân nhóm tổ thì không tồn tại section nào khác
         * 4. Nếu section có phân nhóm tổ có thể tồn tại nhiều section có nhóm tổ riêng biệt 
         *      nhưng không có section không phân nhóm tổ
         * Ví dụ:  - LHP1: SectionMain, Section0 và không tồn tại nhóm tổ nào khác
         *         - LHP2: SectionMain, Section1, Section2, Section3 và không tồn tại section0
         */
        if(DsLopHocPhan == null || DsLopHocPhan.size() == 0) {
            new Exception("Danh sách lớp học phần rỗng").printStackTrace();
            return null;
        }
        for (NhomHocPhan nhomHocPhan : DsLopHocPhan) {
            if(nhomHocPhan.getLopHocPhanSections() == null || nhomHocPhan.getLopHocPhanSections().size() == 0) {
                new Exception("Lớp học phần không có thông tin học phần, id: " + nhomHocPhan.getIdNHP()).printStackTrace();
                DsLopHocPhan.remove(DsLopHocPhan.indexOf(nhomHocPhan));
                continue;
            }
            if(nhomHocPhan.getLopHocPhanSections().size() == 1) {
                if(!nhomHocPhan.getLopHocPhanSections().get(0).getNhomTo().equals("")) {
                    new Exception("Lỗi lớp học phần không có section thuộc nhóm, id: " + nhomHocPhan.getIdNHP()).printStackTrace();
                    DsLopHocPhan.remove(DsLopHocPhan.indexOf(nhomHocPhan));
                }
                continue;
            }

            // Kiểm tra lớp học phần section
            if(!kiemTraLopHocPhanSection(nhomHocPhan)) {
                new Exception("Lớp học phần với section không hợp lệ, id: " + nhomHocPhan.getIdNHP()).printStackTrace();
                DsLopHocPhan.remove(DsLopHocPhan.indexOf(nhomHocPhan));
                continue;
            }
        }

        return DsLopHocPhan;
    }
    private boolean kiemTraLopHocPhanSection(NhomHocPhan lopHocPhan) {
        boolean hasSectionWithNhom = false;
        boolean hasSectionWithNhomTo = false;
        boolean hasSectionWithoutNhomTo = false;
        for (LopHocPhanSection lopHocPhanSection : lopHocPhan.getLopHocPhanSections()) {
            if(lopHocPhanSection.getNhomTo().equals("")) {
                if(hasSectionWithNhom != false) { 
                    new Exception("Không được phép tồn tại nhiều hơn 2 section thuộc nhóm, id: " + lopHocPhan.getIdNHP() + lopHocPhanSection.getIdLHPSection()).printStackTrace();
                    return false;
                } else {
                    hasSectionWithNhom = true;
                }
            } else if(lopHocPhanSection.getNhomTo().equals("00")) {
                if(hasSectionWithoutNhomTo) {
                    new Exception("Không được phép tồn tại nhiều hơn 2 section không có nhóm tổ").printStackTrace();
                    return false;
                } else if(hasSectionWithNhomTo) {
                    new Exception("Không được phép tồn tại section phân nhóm tổ khi tồn tại section không phân nhóm tổ").printStackTrace();
                    return false;
                } else {
                    hasSectionWithoutNhomTo = true;
                }
            } else {
                if(hasSectionWithoutNhomTo) {
                    new Exception("Không được phép tồn tại section phân nhóm tổ khi tồn tại section không phân nhóm tổ").printStackTrace();
                    return false;
                } else { 
                    hasSectionWithNhomTo = true;
                }
            }
        }

        return true;
    }

    public NhomHocPhan layThongTin(int IdLHP) {
        return nhomHocPhanRepository.getByIdLHP(IdLHP);
    }
    
    // public NhomHocPhan layThongTin(String MaGV, String MaLopSV, String MaMH) {
    //     return nhomHocPhanRepository.getByMaGVAndMaLopSVAndMaMH(MaGV, MaLopSV, MaMH);
    // }

    public static void main (String[] args) {
        NhomHocPhanService lopHocPhanService = new NhomHocPhanService();

        // Call the method under test
        lopHocPhanService.xuLyDanhSach(testData());

        // Assert the expected results
        // Add more assertions based on your expected behavior
        
    }
    private static List<NhomHocPhan> testData() {
        List<NhomHocPhan> DsLopHocPhan = new ArrayList<>();
        NhomHocPhan lopHocPhan = new NhomHocPhan();
        lopHocPhan.setIdNHP(123123);
        DsLopHocPhan.add(lopHocPhan);
        LopHocPhanSection lopHocPhanSection = new LopHocPhanSection();
        lopHocPhanSection.setIdLHPSection(1231);
        lopHocPhanSection.setNhomTo((byte) 1);
        LopHocPhanSection lopHocPhanSection1 = new LopHocPhanSection();
        lopHocPhanSection1.setIdLHPSection(4543515);
        lopHocPhanSection1.setNhomTo((byte) 2);
        LopHocPhanSection lopHocPhanSection2 = new LopHocPhanSection();
        lopHocPhanSection2.setIdLHPSection(15164256);
        lopHocPhanSection2.setNhomTo((byte) 255);
        LopHocPhanSection lopHocPhanSection3 = new LopHocPhanSection();
        lopHocPhanSection3.setIdLHPSection(151141);
        lopHocPhanSection3.setNhomTo((byte) 3);
        // Add some LopHocPhan objects to the list
        DsLopHocPhan.get(0).setLopHocPhanSections(List.of(lopHocPhanSection3, lopHocPhanSection1, lopHocPhanSection2, lopHocPhanSection));
        return DsLopHocPhan;
    }
}
