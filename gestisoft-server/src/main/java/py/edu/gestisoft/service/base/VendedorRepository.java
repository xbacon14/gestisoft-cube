package py.edu.gestisoft.service.base;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.base.Vendedor;

public interface VendedorRepository extends JpaRepository<Vendedor, Long> {
	Vendedor findByCi(String ci);
}
