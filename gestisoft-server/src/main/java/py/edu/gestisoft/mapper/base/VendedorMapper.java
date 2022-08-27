package py.edu.gestisoft.mapper.base;

import java.util.List;

import py.edu.gestisoft.model.base.Vendedor;

public interface VendedorMapper {
	List<Vendedor> findVendedorByNombreODocumento(String condition);
}
