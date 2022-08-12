package py.edu.gestisoft.mapper.base;

import java.util.List;

import py.edu.gestisoft.model.base.Cliente;

public interface ClienteMapper {

	List<Cliente> findClientesPorNombreODocumento(String condition);

	Long getProximoId();
}
