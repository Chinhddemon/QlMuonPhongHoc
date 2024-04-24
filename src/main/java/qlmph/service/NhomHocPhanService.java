package qlmph.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.LopHocPhanSection;
import qlmph.model.NguoiMuonPhong;
import qlmph.model.NhomHocPhan;
import qlmph.model.QuanLy;
import qlmph.repository.QLThongTin.NhomHocPhanRepository;
import qlmph.utils.Method;
import qlmph.utils.ValidateObject;

@Service
public class NhomHocPhanService {

    public final String IDSECTION_NULL = "000000";

    @Autowired
    NhomHocPhanRepository nhomHocPhanRepository;

    @Autowired
    LopHocPhanSectionService lopHocPhanSectionService;

    @Autowired
    MonHocService monHocService;

    @Autowired
    LopSVService lopSVService;

    @Autowired
    GiangVienService giangVienService;

    // MARK: MultiBasicTasks

    public List<NhomHocPhan> layDanhSach() {
        List<NhomHocPhan> nhomHocPhans = nhomHocPhanRepository.getAll();
        if (!validateList(nhomHocPhans, Method.GET)) {
            new Exception("Danh sách lớp học phần không hợp lệ.").printStackTrace();
            return null;
        }
        return nhomHocPhans;
    }

    // MARK: SingleBasicTasks

    public NhomHocPhan layThongTin(int IdNHP) {
        if (IdNHP == 0) {
            new Exception("Id nhóm học phần không hợp lệ.").printStackTrace();
            return null;
        }
        return nhomHocPhanRepository.getByIdLHP(IdNHP);
    }

    public boolean capNhatThongTin(NhomHocPhan nhomHocPhan) {
        if (!validate(nhomHocPhan, Method.PUT) || !nhomHocPhanRepository.update(nhomHocPhan)) {
            new Exception("Không thể cập nhật thông tin nhóm học phần.").printStackTrace();
            return false;
        }
        return true;
    }

    // MARK: SingleDynamicTasks

    public NhomHocPhan luuThongTinNhomHocPhan(String MaMH, String MaLopSV, QuanLy QuanLyKhoiTao, String Nhom,
            String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot,
            String MaGVSection, String To, String MucDichSection, String Ngay_BDSection, String Ngay_KTSection,
            String MaGVSection2, String To2, String MucDichSection2, String Ngay_BDSection2, String Ngay_KTSection2,
            String MaGVSection3, String To3, String MucDichSection3, String Ngay_BDSection3, String Ngay_KTSection3) {

        NhomHocPhan nhomHocPhan = taoThongTin(MaMH, MaLopSV, Nhom, QuanLyKhoiTao);
        if(ValidateObject.isNullOrEmpty(nhomHocPhan)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }

        if (ValidateObject.allNullOrEmpty(MaGVRoot, MucDichRoot, Ngay_BDRoot, Ngay_KTRoot)) {
            new Exception("Thông tin lớp học phần không hợp lệ.").printStackTrace();
            return null;
        }
        nhomHocPhan.getLopHocPhanSections()
                .add(lopHocPhanSectionService.taoThongTin(null, MaGVRoot, "255", MucDichRoot, Ngay_BDRoot,
                        Ngay_KTRoot));

        if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
            nhomHocPhan.getLopHocPhanSections()
                    .add(lopHocPhanSectionService.taoThongTin(null, MaGVSection, To, MucDichSection, Ngay_BDSection,
                            Ngay_KTSection));
        }

        if (ValidateObject.allNotNullOrEmpty(MaGVSection2, To2, MucDichSection2, Ngay_BDSection2, Ngay_KTSection2)) {
            nhomHocPhan.getLopHocPhanSections()
                    .add(lopHocPhanSectionService.taoThongTin(null, MaGVSection2, To2, MucDichSection2, Ngay_BDSection2,
                            Ngay_KTSection2));
        }

        if (ValidateObject.allNotNullOrEmpty(MaGVSection3, To3, MucDichSection3, Ngay_BDSection3, Ngay_KTSection3)) {
            nhomHocPhan.getLopHocPhanSections()
                    .add(lopHocPhanSectionService.taoThongTin(null, MaGVSection3, To3, MucDichSection3, Ngay_BDSection3,
                            Ngay_KTSection3));
        }

        if (!validate(nhomHocPhan, Method.POST)) {
            new Exception("Thông tin lớp học phần không hợp lệ.").printStackTrace();
            return null;
        }

        nhomHocPhan = nhomHocPhanRepository.saveNhomHocPhan(nhomHocPhan);
        if (ValidateObject.isNullOrEmpty(nhomHocPhan)) {
            new Exception("Không thể lưu thông tin nhóm học phần.").printStackTrace();
            return null;
        }
        return nhomHocPhan;
    }

    public NhomHocPhan capNhatThongTinLopHocPhan(NhomHocPhan nhomHocPhan, String IdSection,
            String MaMH, String MaLopSV, QuanLy QuanLyKhoiTao, String Nhom, String To,
            String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot,
            String MaGVSection, String MucDichSection, String Ngay_BDSection, String Ngay_KTSection) {

        // Kiểm tra và chỉnh sửa thông tin chính của lớp học phần
        if (nhomHocPhan == null) {
            new Exception("Không tìm thấy thông tin lớp học phần chính.").printStackTrace();
            return null;
        }
        nhomHocPhan = chinhsuaThongTin(nhomHocPhan, MaMH, Short.parseShort(Nhom), QuanLyKhoiTao);

        // Lấy, kiểm tra và chỉnh sửa thông tin phần thứ nhất của lớp học phần
        LopHocPhanSection firstSection = timLopHocPhanSection(nhomHocPhan, IDSECTION_NULL);
        if (firstSection == null) {
            new Exception("Không tìm thấy thông tin phần thứ nhất lớp học phần.").printStackTrace();
            return null;
        }
        firstSection = lopHocPhanSectionService.chinhSuaThongTin(firstSection, MaGVRoot, null, MucDichRoot, Ngay_BDRoot,
                Ngay_KTRoot);

        // Lấy, kiểm tra và chỉnh sửa thông tin phần thứ hai của lớp học phần
        LopHocPhanSection secondSection = null;
        if (!IdSection.equals(IDSECTION_NULL)) {
            secondSection = timLopHocPhanSection(nhomHocPhan, IdSection);
            if (ValidateObject.isNullOrEmpty(secondSection)) {
                secondSection = lopHocPhanSectionService.taoThongTin(nhomHocPhan, MaGVSection, To, MucDichSection, Ngay_BDSection,
                        Ngay_KTSection);
                nhomHocPhan.getLopHocPhanSections().add(secondSection);
            } else {
                if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
                    secondSection = lopHocPhanSectionService.chinhSuaThongTin(secondSection, MaGVSection, To,
                            MucDichSection, Ngay_BDSection, Ngay_KTSection);
                } else {
                    nhomHocPhan.getLopHocPhanSections()
                            .remove(nhomHocPhan.getLopHocPhanSections().indexOf(secondSection));
                }
            }
        }

        if (!validate(nhomHocPhan, Method.PUT)) {
            new Exception("Thông tin lớp học phần không hợp lệ.").printStackTrace();
            return null;
        }

        if (IdSection.equals(IDSECTION_NULL)) {
            if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
                nhomHocPhan = nhomHocPhanRepository.saveAndUpdateLopHocPhan(nhomHocPhan);
            } else if (ValidateObject.allNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
                nhomHocPhan = nhomHocPhanRepository.updateLopHocPhan(nhomHocPhan);
            }
        } else {
            if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
                nhomHocPhan = nhomHocPhanRepository.updateLopHocPhan(nhomHocPhan);
            } else if(ValidateObject.allNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
                nhomHocPhan = nhomHocPhanRepository.updateAndDeleteLopHocPhan(nhomHocPhan, IdSection);
            }
        }
        if(ValidateObject.isNullOrEmpty(nhomHocPhan)) {
            new Exception("Không thể cập nhật thông tin nhóm học phần.").printStackTrace();
            return null;
        }
        return nhomHocPhan;
    }

    // MARK: SingleUtilsTasks

    protected NhomHocPhan taoThongTin(String MaMH, String MaLopSV, String Nhom, QuanLy QuanLyKhoiTao) {
        if(ValidateObject.exsistNullOrEmpty(MaMH, MaLopSV, Nhom, QuanLyKhoiTao)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        NhomHocPhan nhomHocPhan = new NhomHocPhan(
                monHocService.layThongTin(MaMH),
                lopSVService.layThongTin(MaLopSV),
                QuanLyKhoiTao,
                Short.parseShort(Nhom),
                new ArrayList<NguoiMuonPhong>(),
                new ArrayList<LopHocPhanSection>());
        return nhomHocPhan;
    }

    protected NhomHocPhan chinhsuaThongTin(NhomHocPhan nhomHocPhan,
            String MaMH, short Nhom, QuanLy QuanLyKhoiTao) {
        nhomHocPhan.setMonHoc(monHocService.layThongTin(MaMH));
        nhomHocPhan.setNhom(Nhom);
        nhomHocPhan.setQuanLyKhoiTao(QuanLyKhoiTao);
        return nhomHocPhan;
    }

    protected LopHocPhanSection timLopHocPhanSection(NhomHocPhan nhomHocPhan, String IdSection) {
        for (LopHocPhanSection section : nhomHocPhan.getLopHocPhanSections()) {
            if (section.getNhomTo() == 255 && IdSection.equals(IDSECTION_NULL)
                    || section.getIdLHPSectionAsString().equals(IdSection)) {
                return section;
            }
        }
        new Exception("Không tìm thấy thông tin các phần của lớp học phần.").printStackTrace();
        return null;
    }

    // MARK: ValidateTasks

    protected boolean validateList(List<NhomHocPhan> nhomHocPhans, Method method) {
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

    protected boolean validate(NhomHocPhan nhomHocPhan, Method method) {
        if (nhomHocPhan.getLopHocPhanSections() == null || nhomHocPhan.getLopHocPhanSections().size() == 0) {
            new Exception("Lớp học phần không có thông tin học phần, id: " + nhomHocPhan.getIdNHPAsString())
                    .getMessage();
            return false;
        } else if (nhomHocPhan.getLopHocPhanSections().size() == 1) {
            if (nhomHocPhan.getLopHocPhanSections().get(0).getNhomTo() != 255) {
                new Exception("Lỗi lớp học phần không có section thuộc nhóm, id: " + nhomHocPhan.getIdNHPAsString())
                        .getMessage();
                return false;
            } else if (method == Method.GET) {
                nhomHocPhan.getLopHocPhanSections().add(lopHocPhanSectionService.taoPlaceHolder());
            }
        } else if (!lopHocPhanSectionService.validateListWithSameIdNHP(nhomHocPhan.getLopHocPhanSections())) {
            new Exception("Lớp học phần với section không hợp lệ, id: " + nhomHocPhan.getIdNHPAsString()).getMessage();
            return false;
        }
        return true;
    }
}
