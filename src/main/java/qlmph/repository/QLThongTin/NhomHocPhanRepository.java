package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.model.QLThongTin.NhomHocPhan;

@Repository
@Transactional
public class NhomHocPhanRepository {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<NhomHocPhan> getAll() {
		List<NhomHocPhan> nhomHocPhans = null;
		Session session = null;
		try {

			session = sessionFactory.openSession();
			nhomHocPhans = (List<NhomHocPhan>) session.createQuery("FROM NhomHocPhan")
					.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return nhomHocPhans;
	}

	public NhomHocPhan getByIdLHP(int IdNHP) {

		NhomHocPhan nhomHocPhans = null;
		Session session = null;

		try {
			session = sessionFactory.openSession();
			nhomHocPhans = (NhomHocPhan) session.createQuery("FROM NhomHocPhan WHERE IdNHP = :IdNHP")
					.setParameter("IdNHP", IdNHP)
					.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return nhomHocPhans;
	}

	// public NhomHocPhan getByMaGVAndMaLopSVAndMaMH(String MaGV, String MaLopSV, String MaMH) {

	//     NhomHocPhan nhomHocPhans = null;
	//     Session session = null;

	//     try {
	//         session = sessionFactory.openSession();
	//         nhomHocPhans = (NhomHocPhan) session
	//                 .createQuery("FROM NhomHocPhan WHERE MaGV = :MaGV AND MaLopSV = :MaLopSV AND MaMH = :MaMH")
	//                 .setParameter("MaGV", MaGV)
	//                 .setParameter("MaLopSV", MaLopSV)
	//                 .setParameter("MaMH", MaMH)
	//                 .uniqueResult();
	//     } catch (Exception e) {
	//         e.printStackTrace();
	//     } finally {
	//         if (session != null) {
	//             session.close();
	//         }
	//     }
	//     return nhomHocPhans;
	// }

	public boolean validateGetList(List<NhomHocPhan> nhomHocPhans) {
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
		if(nhomHocPhans == null || nhomHocPhans.size() == 0) {
			new Exception("Danh sách lớp học phần rỗng").printStackTrace();
			return false;
		}
		for (NhomHocPhan nhomHocPhan : nhomHocPhans) {
			if(nhomHocPhan.getLopHocPhanSections() == null || nhomHocPhan.getLopHocPhanSections().size() == 0) {
				new Exception("Lớp học phần không có thông tin học phần, id: " + nhomHocPhan.getIdNHP()).printStackTrace();
				nhomHocPhans.remove(nhomHocPhans.indexOf(nhomHocPhan));
				continue;
			}
			if(nhomHocPhan.getLopHocPhanSections().size() == 1) {
				if(!nhomHocPhan.getLopHocPhanSections().get(0).getNhomTo().equals("")) {
					new Exception("Lỗi lớp học phần không có section thuộc nhóm, id: " + nhomHocPhan.getIdNHP()).printStackTrace();
					nhomHocPhans.remove(nhomHocPhans.indexOf(nhomHocPhan));
				}
				continue;
			}

			// Kiểm tra lớp học phần section
			if(!checkOnLopHocPhanSection(nhomHocPhan)) {
				new Exception("Lớp học phần với section không hợp lệ, id: " + nhomHocPhan.getIdNHP()).printStackTrace();
				nhomHocPhans.remove(nhomHocPhans.indexOf(nhomHocPhan));
				continue;
			}
		}

		return true;
	}

	private boolean checkOnLopHocPhanSection(NhomHocPhan nhomHocPhan) {
		boolean hasSectionWithNhom = false;
		boolean hasSectionWithNhomTo = false;
		boolean hasSectionWithoutNhomTo = false;
		for (LopHocPhanSection lopHocPhanSection : nhomHocPhan.getLopHocPhanSections()) {
			if(lopHocPhanSection.getNhomTo().equals("")) {
				if(hasSectionWithNhom != false) { 
					new Exception("Không được phép tồn tại nhiều hơn 2 section thuộc nhóm, id: " + nhomHocPhan.getIdNHP() + lopHocPhanSection.getIdLHPSection()).printStackTrace();
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
}
