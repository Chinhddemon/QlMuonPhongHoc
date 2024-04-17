package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.LopHocPhanSection;
import qlmph.model.NhomHocPhan;
import qlmph.model.QuanLy;
import qlmph.repository.QLThongTin.NhomHocPhanRepository;

@Service
public class NhomHocPhanService {

    @Autowired
    NhomHocPhanRepository nhomHocPhanRepository;

    @Autowired
    LopHocPhanSectionService lopHocPhanSectionService;

    @Autowired
    MonHocService monHocService;

    @Autowired
    GiangVienService giangVienService;

    public List<NhomHocPhan> layDanhSach() {
        List<NhomHocPhan> nhomHocPhans = nhomHocPhanRepository.getAll();
        if (validateList(nhomHocPhans, Method.GET)) {
            return nhomHocPhans;
        }
        return null;
    }

    public NhomHocPhan layThongTin(int IdLHP) {
        return nhomHocPhanRepository.getByIdLHP(IdLHP);
    }

    public boolean taoThongTinLopHocPhan(String MaMH, String MaLopSV, QuanLy QuanLyKhoiTao, String Nhom, String To,
            String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot,
            String MaGVSection, String MucDichSection, String Ngay_BDSection, String Ngay_KTSection) {

        // // Lần lượt cập nhật từng phần thông tin của lớp học phần
        // if (!capNhatThongTin( MaMH, Short.parseShort(Nhom), QuanLyKhoiTao)) {
        //     new Exception("Không thể cập nhật thông tin chính của lớp học phần.").printStackTrace();
        //     return false;
        // }
        // if (!lopHocPhanSectionService.capNhatThongTin(
        //         MaGVRoot, MucDichRoot, Ngay_BDRoot, Ngay_KTRoot)) {
        //     new Exception("Không thể cập nhật thông tin phần thứ nhất lớp học phần.").printStackTrace();
        //     if (!capNhatThongTin(backUpNhomHocPhan)) {
        //         new Exception("Lỗi hệ thống! Không thể hoàn tác thông tin chính của lớp học phần.").printStackTrace();
        //         return false;
        //     }
        //     return false;
        // }
        // if (secondSection != null && !lopHocPhanSectionService.capNhatThongTin(secondSection,
        //         MaGVSection, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
        //     new Exception("Không thể cập nhật thông tin phần thứ hai lớp học phần.").printStackTrace();
        //     if (!capNhatThongTin(backUpNhomHocPhan)) {
        //         new Exception("Lỗi hệ thống! Không thể hoàn tác thông tin chính của lớp học phần.").printStackTrace();
        //         return false;
        //     }
        //     if (!lopHocPhanSectionService.capNhatThongTin(backUpFirstSection)) {
        //         new Exception("Lỗi hệ thống! Không thể hoàn tác thông tin phần thứ nhất lớp học phần.")
        //                 .printStackTrace();
        //         return false;
        //     }
        //     return false;
        // }
        return false;
    }

    public boolean capNhatThongTinLopHocPhan(NhomHocPhan nhomHocPhan, String IdSection,
            String MaMH, String MaLopSV, QuanLy QuanLyKhoiTao, String Nhom, String To,
            String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot,
            String MaGVSection, String MucDichSection, String Ngay_BDSection, String Ngay_KTSection) {

        // Kiểm tra và chỉnh sửa thông tin chính của lớp học phần
        if (nhomHocPhan == null) {
            new Exception("Không tìm thấy thông tin lớp học phần chính.").printStackTrace();
            return false;
        }
        nhomHocPhan = chinhsuaThongTin(nhomHocPhan, MaMH, Short.parseShort(Nhom), QuanLyKhoiTao);

        // Lấy, kiểm tra và chỉnh sửa thông tin phần thứ nhất của lớp học phần
        LopHocPhanSection firstSection = timLopHocPhanSection(nhomHocPhan, "000000");
        if (firstSection == null) {
            new Exception("Không tìm thấy thông tin phần thứ nhất lớp học phần.").printStackTrace();
            return false;
        }
        firstSection = lopHocPhanSectionService.chinhSuaThongTin(firstSection, MaGVRoot, null, MucDichRoot, Ngay_BDRoot, Ngay_KTRoot);


        // Lấy, kiểm tra và chỉnh sửa thông tin phần thứ hai của lớp học phần
        LopHocPhanSection secondSection = null;
        if (!IdSection.equals("000000")) {
            secondSection = timLopHocPhanSection(nhomHocPhan, IdSection);
            if (secondSection == null) {
                new Exception("Không tìm thấy thông tin phần thứ hai lớp học phần.").printStackTrace();
                return false;
            }
            secondSection = lopHocPhanSectionService.chinhSuaThongTin(secondSection, MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection);
        }
        // if(!validate(nhomHocPhan, Method.PUT) && !nhomHocPhanRepository.updateLopHocPhan(nhomHocPhan)) {
        //     new Exception("Không thể cập nhật thông tin nhóm học phần.").printStackTrace();
        //     return false;
        // }
        return true;
    }

    public NhomHocPhan chinhsuaThongTin(NhomHocPhan nhomHocPhan,
            String MaMH, short Nhom, QuanLy QuanLyKhoiTao) {
        nhomHocPhan.setMonHoc(monHocService.layThongTin(MaMH));
        nhomHocPhan.setNhom(Nhom);
        nhomHocPhan.setQuanLyKhoiTao(QuanLyKhoiTao);
        return nhomHocPhan;
    }

    public boolean capNhatThongTin(NhomHocPhan nhomHocPhan) {
        if (!validate(nhomHocPhan, Method.PUT) && !nhomHocPhanRepository.update(nhomHocPhan)) {
            new Exception("Không thể cập nhật thông tin nhóm học phần.").printStackTrace();
            return false;
        }
        return true;
    }

    private LopHocPhanSection timLopHocPhanSection(NhomHocPhan nhomHocPhan, String IdSection) {
        // Lấy và kiểm tra thông tin phần thứ nhất của lớp học phần
        LopHocPhanSection Section = null;
        for (LopHocPhanSection section : nhomHocPhan.getLopHocPhanSections()) {
            if (section.getNhomTo() == 255 && IdSection.equals("000000")
                    || section.getIdLHPSection().equals(IdSection)) {
                Section = lopHocPhanSectionService.layThongTin(Integer.parseInt(section.getIdLHPSection()));
                if (Section == null) {
                    new Exception("Không tìm thấy thông tin các phần của lớp học phần.").printStackTrace();
                    return null;
                }
                break;
            }
        }
        return Section;
    }

    private boolean validateList(List<NhomHocPhan> nhomHocPhans, Method method) {
        /*
         * Xử lý ngoại lệ:
         * 1. Nếu danh sách lớp học phần rỗng, bỏ qua xử lý và báo lỗi
         * 2. Mỗi học phần chứa 1 section thuộc nhóm, có thể có 1 section không thuộc
         * nhóm tổ hoặc nhiều section thuộc nhóm tổ
         * Ví dụ:
         * - LHP1: SectionMain
         * - LHP2: SectionMain, Section0
         * - LHP3: SectionMain, Section1, Section2,...
         * 3. Nếu có 1 section không phân nhóm tổ thì không tồn tại section nào khác
         * 4. Nếu section có phân nhóm tổ có thể tồn tại nhiều section có nhóm tổ riêng
         * biệt nhưng không có section không phân nhóm tổ
         * Ví dụ:
         * - LHP1: SectionMain, Section0 và không tồn tại nhóm tổ nào khác
         * - LHP2: SectionMain, Section1, Section2, Section3 và không tồn tại section0
         */
        if (nhomHocPhans == null || nhomHocPhans.size() == 0) {
            new Exception("Danh sách lớp học phần rỗng").printStackTrace();
            return false;
        }
        for (NhomHocPhan nhomHocPhan : nhomHocPhans) {
            if (!validate(nhomHocPhan, method)) {
                new Exception("Đã loại bỏ thông tin.").printStackTrace();
                nhomHocPhans.remove(nhomHocPhans.indexOf(nhomHocPhan));
            }
        }
        return true;
    }

    private boolean validate(NhomHocPhan nhomHocPhan, Method method) {
        if (nhomHocPhan.getLopHocPhanSections() == null || nhomHocPhan.getLopHocPhanSections().size() == 0) {
            new Exception("Lớp học phần không có thông tin học phần, id: " + nhomHocPhan.getIdNHP())
                    .getMessage();
            return false;
        } else if (nhomHocPhan.getLopHocPhanSections().size() == 1) {
            if (nhomHocPhan.getLopHocPhanSections().get(0).getNhomTo() != 255) {
                new Exception("Lỗi lớp học phần không có section thuộc nhóm, id: " + nhomHocPhan.getIdNHP())
                        .getMessage();
                return false;
            } else if (method == Method.GET) {
                nhomHocPhan.getLopHocPhanSections().add(lopHocPhanSectionService.taoPlaceHolder());
            }
        } else if (!lopHocPhanSectionService.validateListWithSameIdNHP(nhomHocPhan.getLopHocPhanSections())) {
            new Exception("Lớp học phần với section không hợp lệ, id: " + nhomHocPhan.getIdNHP()).getMessage();
            return false;
        }
        return true;
    }

    public enum Method {
        GET, POST, PUT, DELETE
    }
}
