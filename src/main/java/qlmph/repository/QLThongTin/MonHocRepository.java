package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.MonHoc;

@Repository
@Transactional
public class MonHocRepository {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<MonHoc> getAll() {
		List<MonHoc> monHocs = null;
		Session session = null;
		try {

			session = sessionFactory.openSession();
			monHocs = (List<MonHoc>) session.createQuery("FROM MonHoc")
					.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return monHocs;
	}
	
	public MonHoc getByMaMH(String MaMH) {
		MonHoc monHoc = null;
		Session session = null;
		try {
			session = sessionFactory.openSession();
			monHoc = (MonHoc) session.get(MonHoc.class, MaMH);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return monHoc;
	}

}

