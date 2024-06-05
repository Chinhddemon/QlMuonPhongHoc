package qlmph.repository.user;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.user.VaiTro;

@Repository
@Transactional
public class VaiTroRepository {

    @Autowired
    private SessionFactory sessionFactory;

    public VaiTro getByMaVaiTro(String maVaiTro) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery("FROM VaiTro WHERE maVaiTro = :maVaiTro", VaiTro.class)
                    .setParameter("maVaiTro", maVaiTro)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
