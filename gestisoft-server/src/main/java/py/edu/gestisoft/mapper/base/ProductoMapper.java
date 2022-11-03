package py.edu.gestisoft.mapper.base;

import java.util.List;

import py.edu.gestisoft.model.base.Producto;

public interface ProductoMapper {
	List<Producto> findByNombre(String condition);

	List<Producto> findProductosReporte(String condition, String orderBy);
}
