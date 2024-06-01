package qlmph.service.universityCourse;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityCourse.NhomToHocPhan;
import qlmph.model.universityCourse.NhomHocPhan;
import qlmph.model.user.QuanLy;
import qlmph.model.user.SinhVien;
import qlmph.repository.universityCourse.NhomHocPhanRepository;
import qlmph.service.universityBase.MonHocService;
import qlmph.service.user.GiangVienService;
import qlmph.utils.Method;
import qlmph.utils.ValidateObject;

@Service
public class NhomHocPhanService {

    public final String IDSECTION_NULL = "000000";

    @Autowired
    NhomHocPhanRepository nhomHocPhanRepository;

    @Autowired
    NhomToHocPhanService nhomToHocPhanService;

    @Autowired
    MonHocService monHocService;

    @Autowired
    HocKy_LopSinhVienService hocKy_LopSinhVienService;

    @Autowired
    GiangVienService giangVienService;

    // MARK: MultiBasicTasks

    public List<NhomHocPhan> layDanhSach() {
        List<NhomHocPhan> nhomHocPhans = nhomHocPhanRepository.getAll();
        if (!validateList(nhomHocPhans, Method.GET)) {
            new Exception("Danh sách lớp học phần không hợp lệ.").printStackTrace();
            return null;
        }
        sortNhomToHocPhans(nhomHocPhans);
        return nhomHocPhans;
    }

    public List<NhomHocPhan> layDanhSachTheoDieuKien(Set<GetCommand> Commands,
            String idTaiKhoan) {
        List<NhomHocPhan> nhomHocPhans = nhomHocPhanRepository.getListByCondition(Commands, idTaiKhoan);
        if (!validateList(nhomHocPhans, Method.GET)) {
            new Exception("Danh sách lớp học phần không hợp lệ.").printStackTrace();
            return null;
        }
        sortNhomToHocPhans(nhomHocPhans);
        return nhomHocPhans;
    }

    // MARK: SingleBasicTasks

    public NhomHocPhan layThongTin(int IdNhomHocPhan) {
        if (IdNhomHocPhan == 0) {
            new Exception("Id nhóm học phần không hợp lệ.").printStackTrace();
            return null;
        }
        NhomHocPhan nhomHocPhan = nhomHocPhanRepository.getByIdNhomHocPhan(IdNhomHocPhan);
        if (!validate(nhomHocPhan, Method.GET)) {
            new Exception("Thông tin lớp học phần không hợp lệ.").printStackTrace();
            return null;
        }
        sortNhomToHocPhan(nhomHocPhan);
        return nhomHocPhan;
    }

    public boolean capNhatThongTin(NhomHocPhan nhomHocPhan) {
        if (!validate(nhomHocPhan, Method.PUT) || !nhomHocPhanRepository.update(nhomHocPhan)) {
            new Exception("Không thể cập nhật thông tin nhóm học phần.").printStackTrace();
            return false;
        }
        return true;
    }

    // MARK: SingleDynamicTasks

    // public NhomHocPhan luuThongTinNhomHocPhan(String MaMonHoc, String MaLopSinhVien, QuanLy QuanLyKhoiTao, String Nhom,
    //         String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot,
    //         String MaGVSection, String To, String MucDichSection, String Ngay_BDSection, String Ngay_KTSection,
    //         String MaGVSection2, String To2, String MucDichSection2, String Ngay_BDSection2, String Ngay_KTSection2,
    //         String MaGVSection3, String To3, String MucDichSection3, String Ngay_BDSection3, String Ngay_KTSection3) {

    //     NhomHocPhan nhomHocPhan = taoThongTin(MaMonHoc, MaLopSinhVien, Nhom, QuanLyKhoiTao);
    //     if(ValidateObject.isNullOrEmpty(nhomHocPhan)) {
    //         new Exception("Dữ liệu không hợp lệ!").printStackTrace();
    //         return null;
    //     }

    //     if (ValidateObject.allNullOrEmpty(MaGVRoot, MucDichRoot, Ngay_BDRoot, Ngay_KTRoot)) {
    //         new Exception("Thông tin lớp học phần không hợp lệ.").printStackTrace();
    //         return null;
    //     }
    //     nhomHocPhan.getNhomToHocPhans()
    //             .add(nhomToHocPhanService.taoThongTin(null, MaGVRoot, "255", MucDichRoot, Ngay_BDRoot,
    //                     Ngay_KTRoot));

    //     if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
    //         nhomHocPhan.getNhomToHocPhans()
    //                 .add(nhomToHocPhanService.taoThongTin(null, MaGVSection, To, MucDichSection, Ngay_BDSection,
    //                         Ngay_KTSection));
    //     }

    //     if (ValidateObject.allNotNullOrEmpty(MaGVSection2, To2, MucDichSection2, Ngay_BDSection2, Ngay_KTSection2)) {
    //         nhomHocPhan.getNhomToHocPhans()
    //                 .add(nhomToHocPhanService.taoThongTin(null, MaGVSection2, To2, MucDichSection2, Ngay_BDSection2,
    //                         Ngay_KTSection2));
    //     }

    //     if (ValidateObject.allNotNullOrEmpty(MaGVSection3, To3, MucDichSection3, Ngay_BDSection3, Ngay_KTSection3)) {
    //         nhomHocPhan.getNhomToHocPhans()
    //                 .add(nhomToHocPhanService.taoThongTin(null, MaGVSection3, To3, MucDichSection3, Ngay_BDSection3,
    //                         Ngay_KTSection3));
    //     }

    //     if (!validate(nhomHocPhan, Method.POST)) {
    //         new Exception("Thông tin lớp học phần không hợp lệ.").printStackTrace();
    //         return null;
    //     }

    //     nhomHocPhan = nhomHocPhanRepository.saveNhomHocPhan(nhomHocPhan);
    //     if (ValidateObject.isNullOrEmpty(nhomHocPhan)) {
    //         new Exception("Không thể lưu thông tin nhóm học phần.").printStackTrace();
    //         return null;
    //     }
    //     return nhomHocPhan;
    // }

    // public NhomHocPhan capNhatThongTinLopHocPhan(NhomHocPhan nhomHocPhan, String IdSection,
    //         String MaMonHoc, String MaLopSinhVien, QuanLy QuanLyKhoiTao, String Nhom, String To,
    //         String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot,
    //         String MaGVSection, String MucDichSection, String Ngay_BDSection, String Ngay_KTSection) {

    //     // Kiểm tra và chỉnh sửa thông tin chính của lớp học phần
    //     if (nhomHocPhan == null) {
    //         new Exception("Không tìm thấy thông tin lớp học phần chính.").printStackTrace();
    //         return null;
    //     }
    //     nhomHocPhan = chinhsuaThongTin(nhomHocPhan, MaMonHoc, Short.parseShort(Nhom), QuanLyKhoiTao);

    //     // Lấy, kiểm tra và chỉnh sửa thông tin phần thứ nhất của lớp học phần
    //     NhomToHocPhan firstSection = timNhomToHocPhan(nhomHocPhan, IDSECTION_NULL);
    //     if (firstSection == null) {
    //         new Exception("Không tìm thấy thông tin phần thứ nhất lớp học phần.").printStackTrace();
    //         return null;
    //     }
    //     firstSection = nhomToHocPhanService.chinhSuaThongTin(firstSection, MaGVRoot, null, MucDichRoot, Ngay_BDRoot,
    //             Ngay_KTRoot);

    //     // Lấy, kiểm tra và chỉnh sửa thông tin phần thứ hai của lớp học phần
    //     NhomToHocPhan secondSection = null;
    //     if (!IdSection.equals(IDSECTION_NULL)) {
    //         secondSection = timNhomToHocPhan(nhomHocPhan, IdSection);
    //         if (ValidateObject.isNullOrEmpty(secondSection)) {
    //             secondSection = nhomToHocPhanService.taoThongTin(nhomHocPhan, MaGVSection, To, MucDichSection, Ngay_BDSection,
    //                     Ngay_KTSection);
    //             nhomHocPhan.getNhomToHocPhans().add(secondSection);
    //         } else {
    //             if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
    //                 secondSection = nhomToHocPhanService.chinhSuaThongTin(secondSection, MaGVSection, To,
    //                         MucDichSection, Ngay_BDSection, Ngay_KTSection);
    //             } else {
    //                 nhomHocPhan.getNhomToHocPhans()
    //                         .remove(nhomHocPhan.getNhomToHocPhans().indexOf(secondSection));
    //             }
    //         }
    //     }

    //     if (!validate(nhomHocPhan, Method.PUT)) {
    //         new Exception("Thông tin lớp học phần không hợp lệ.").printStackTrace();
    //         return null;
    //     }

    //     if (IdSection.equals(IDSECTION_NULL)) {
    //         if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
    //             nhomHocPhan = nhomHocPhanRepository.saveAndUpdateLopHocPhan(nhomHocPhan);
    //         } else if (ValidateObject.allNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
    //             nhomHocPhan = nhomHocPhanRepository.updateLopHocPhan(nhomHocPhan);
    //         }
    //     } else {
    //         if (ValidateObject.allNotNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
    //             nhomHocPhan = nhomHocPhanRepository.updateLopHocPhan(nhomHocPhan);
    //         } else if(ValidateObject.allNullOrEmpty(MaGVSection, To, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
    //             nhomHocPhan = nhomHocPhanRepository.updateAndDeleteLopHocPhan(nhomHocPhan, IdSection);
    //         }
    //     }
    //     if(ValidateObject.isNullOrEmpty(nhomHocPhan)) {
    //         new Exception("Không thể cập nhật thông tin nhóm học phần.").printStackTrace();
    //         return null;
    //     }
    //     return nhomHocPhan;
    // }

    // MARK: SingleUtilsTasks

    protected NhomHocPhan taoThongTin(String MaMonHoc, String IdHocKy_LopSinhVien, String Nhom, QuanLy QuanLyKhoiTao) {
        if(ValidateObject.exsistNullOrEmpty(MaMonHoc, IdHocKy_LopSinhVien, Nhom, QuanLyKhoiTao)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        NhomHocPhan nhomHocPhan = new NhomHocPhan(
                monHocService.layThongTin(MaMonHoc),
                hocKy_LopSinhVienService.layThongTin(Integer.parseInt(IdHocKy_LopSinhVien)),
                QuanLyKhoiTao,
                Short.parseShort(Nhom),
                new ArrayList<NhomToHocPhan>(),
                new ArrayList<SinhVien>());
        return nhomHocPhan;
    }

    protected NhomHocPhan chinhsuaThongTin(NhomHocPhan nhomHocPhan,
            String MaMonHoc, short Nhom, QuanLy QuanLyKhoiTao) {
        nhomHocPhan.setMonHoc(monHocService.layThongTin(MaMonHoc));
        nhomHocPhan.setNhom(Nhom);
        nhomHocPhan.setQuanLyKhoiTao(QuanLyKhoiTao);
        return nhomHocPhan;
    }

    protected NhomToHocPhan timNhomToHocPhan(NhomHocPhan nhomHocPhan, String IdSection) {
        for (NhomToHocPhan section : nhomHocPhan.getNhomToHocPhans()) {
            if (section.getNhomTo() == 255 && IdSection.equals(IDSECTION_NULL)
                    || section.getNhomToAsString().equals(IdSection)) {
                return section;
            }
        }
        new Exception("Không tìm thấy thông tin các phần của lớp học phần.").printStackTrace();
        return null;
    }

    // MARK: OtherTasks

    protected void sortNhomToHocPhans(List<NhomHocPhan> nhomHocPhans) {
        Iterable<NhomHocPhan> nhomHocPhanIterable = nhomHocPhans;
        nhomHocPhanIterable.forEach(nhomHocPhan -> {
            sortNhomToHocPhan(nhomHocPhan);
        });
    }

    protected void sortNhomToHocPhan(NhomHocPhan nhomHocPhan) {
        // Sort by NhomTo ASC in NhomToHocPhan if NhomTo = -1, place at the end of list
        nhomHocPhan.getNhomToHocPhans().sort((nhomTo1, nhomTo2) -> {
            if (nhomTo1.getNhomTo() == -1) {
                return 1;
            } else if (nhomTo2.getNhomTo() == -1) {
                return -1;
            } else {
                return nhomTo1.getNhomTo() - nhomTo2.getNhomTo();
            }
        });
        Iterator<NhomToHocPhan> iterator = nhomHocPhan.getNhomToHocPhans().iterator();
        while (iterator.hasNext()) {
            NhomToHocPhan nhomToHocPhan = iterator.next();
            if(nhomToHocPhan.getNhomTo() == 0) {
                nhomToHocPhan.setNhomTo((short) 255);
                break;
            }
        }
    }

    protected boolean validateList(List<NhomHocPhan> nhomHocPhans, Method method) {
        /*
         * Xử lý ngoại lệ:
         * 1. Nếu danh sách lớp học phần rỗng, bỏ qua xử lý và báo lỗi
         * 2. Mỗi nhóm học phần chứa ít nhất 1 nhóm tổ học phần thuộc nhóm và có thể hoặc không có nhóm tổ học phần không thuộc tổ
         * 3. Nhóm tổ học phần thuộc nhóm chỉ sử dụng với mục đích là học lý thuyết, nhóm tổ học phần thuộc tổ sử dụng với mục đích là học thực hành
         * Ví dụ:
         * - LHP1: Section0
         * - LHP2: Section0, Section0, Section0,...
         * - LHP3: Section0, Section1, Section2, Section3
         * - LHP4: Section0, Section0,... , Section1, Section1,...
         */
        if (nhomHocPhans == null || nhomHocPhans.size() == 0) { // Nếu danh sách lớp học phần rỗng
            if(method == Method.GET) { // Nếu phương thức là GET
                return true; // Bỏ qua xử lý và trả về true
            }
            new Exception("Danh sách lớp học phần rỗng").printStackTrace(); // Ngược lại, báo lỗi
            return false;
        }

        Iterator<NhomHocPhan> iterator = nhomHocPhans.iterator();
        while (iterator.hasNext()) { // Duyệt qua từng lớp học phần
            NhomHocPhan nhomHocPhan = iterator.next();
            if (!validate(nhomHocPhan, method)) { // Nếu lớp học phần không hợp lệ
                new Exception("Đã loại bỏ thông tin.").printStackTrace(); // Báo lỗi
                iterator.remove(); // và loại bỏ thông tin lớp học phần
            }
        }
        return true;
    }

    protected boolean validate(NhomHocPhan nhomHocPhan, Method method) {
        if (nhomHocPhan.getNhomToHocPhans() == null || nhomHocPhan.getNhomToHocPhans().size() == 0) {
            new Exception("Lớp học phần không có thông tin học phần, id: " + nhomHocPhan.getIdNhomHocPhanAsString())
                    .getMessage();
            return false;
        } else if (nhomHocPhan.getNhomToHocPhans().size() == 1) {
            if (nhomHocPhan.getNhomToHocPhans().get(0).getNhomTo() != 0) {
                new Exception("Lỗi lớp học phần không có section thuộc nhóm, id: " + nhomHocPhan.getIdNhomHocPhanAsString())
                        .getMessage();
                return false;
            } else if (method == Method.GET) {
                nhomHocPhan.getNhomToHocPhans().add(nhomToHocPhanService.taoPlaceHolder());
            }
        } else if (!nhomToHocPhanService.validateListWithSameIdNhomHocPhan(nhomHocPhan.getNhomToHocPhans())) {
            new Exception("Lớp học phần với section không hợp lệ, id: " + nhomHocPhan.getIdNhomHocPhanAsString()).getMessage();
            return false;
        }
        return true;
    }

    public enum GetCommand {
        TheoNguoiDung
    }
}
