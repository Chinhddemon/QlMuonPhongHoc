package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.model.QLThongTin.NhomHocPhan;
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
        if (nhomHocPhanRepository.validateList(nhomHocPhans)) {
            return nhomHocPhans;
        }
        return null;
    }

    public NhomHocPhan layThongTin(int IdLHP) {
        return nhomHocPhanRepository.getByIdLHP(IdLHP);
    }

    public boolean capNhatThongTinLopHocPhan(NhomHocPhan nhomHocPhan, String IdSection,
            String MaMH, String MaLopSV, QuanLy QuanLyKhoiTao, String Nhom, String To,
            String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot,
            String MaGVSection, String MucDichSection, String Ngay_BDSection, String Ngay_KTSection) {

        NhomHocPhan backUpNhomHocPhan = null;
        LopHocPhanSection backUpFirstSection = null;
        
        // Kiểm tra thông tin lớp học phần chính
        if (nhomHocPhan == null) {
            new Exception("Không tìm thấy thông tin lớp học phần chính.").printStackTrace();
            return false;
        }
        backUpNhomHocPhan = new NhomHocPhan(nhomHocPhan);

        // Lấy và kiểm tra thông tin phần thứ nhất của lớp học phần
        LopHocPhanSection FirstSection = timLopHocPhanSection(nhomHocPhan, "000000");
        if (FirstSection == null) {
            new Exception("Không tìm thấy thông tin phần thứ nhất lớp học phần.").printStackTrace();
            return false;
        }
        backUpFirstSection = new LopHocPhanSection(FirstSection);

        // Lấy và kiểm tra thông tin phần thứ hai của lớp học phần
        LopHocPhanSection SecondSection = null;
        if (!IdSection.equals("000000")) {
            SecondSection = timLopHocPhanSection(nhomHocPhan, IdSection);
            if (SecondSection == null) {
                new Exception("Không tìm thấy thông tin phần thứ hai lớp học phần.").printStackTrace();
                return false;
            }
        }

        // Chỉnh sửa thông tin của lớp học phần
        nhomHocPhan.setMonHoc(monHocService.layThongTin(MaMH));
        nhomHocPhan.setNhom(Byte.parseByte(Nhom));
        nhomHocPhan.setQuanLyKhoiTao(QuanLyKhoiTao);

        // Lần lượt cập nhật từng phần thông tin của lớp học phần
        if (!nhomHocPhanRepository.update(nhomHocPhan)) {
            new Exception("Không thể cập nhật thông tin chính của lớp học phần.").printStackTrace();
            return false;
        }
        if(!lopHocPhanSectionService.capNhatThongTin(FirstSection, 
                MaGVRoot, MucDichRoot, Ngay_BDRoot, Ngay_KTRoot)) {
            new Exception("Không thể cập nhật thông tin phần thứ nhất lớp học phần.").printStackTrace();
            if (!nhomHocPhanRepository.update(backUpNhomHocPhan)) {
                new Exception("Lỗi hệ thống! Không thể cập nhật thông tin chính của lớp học phần.").printStackTrace();
                return false;
            }
            return false;
        }
        if(SecondSection != null && !lopHocPhanSectionService.capNhatThongTin(SecondSection, 
                MaGVSection, MucDichSection, Ngay_BDSection, Ngay_KTSection)) {
            new Exception("Không thể cập nhật thông tin phần thứ hai lớp học phần.").printStackTrace();
            if (!nhomHocPhanRepository.update(backUpNhomHocPhan)) {
                new Exception("Lỗi hệ thống! Không thể cập nhật thông tin chính của lớp học phần.").printStackTrace();
                return false;
            }
            if(!lopHocPhanSectionService.capNhatThongTin(backUpFirstSection)) {
                new Exception("Lỗi hệ thống! Không thể cập nhật thông tin phần thứ nhất lớp học phần.").printStackTrace();
                return false;
            }
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
                    new Exception("Không tìm thấy thông tin phần thứ nhất lớp học phần.").printStackTrace();
                    return null;
                }
                break;
            }
        }
        return Section;
    }
}
