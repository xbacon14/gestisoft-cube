package py.edu.gestisoft.repositories.base;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.base.Cliente;

public interface ClienteRepository extends JpaRepository<Cliente, Long> {

}
