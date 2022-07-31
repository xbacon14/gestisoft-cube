package py.edu.gestisoft.repositories.base;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.base.Producto;

public interface ProductoRepository extends JpaRepository<Producto, Long> {

}
