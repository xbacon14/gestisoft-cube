package py.edu.gestisoft.repositories.base;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.base.Persona;

public interface PersonaRepository extends JpaRepository<Persona, Long> {

}
