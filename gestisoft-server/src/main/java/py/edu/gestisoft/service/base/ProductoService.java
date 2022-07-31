package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.model.base.Producto;
import py.edu.gestisoft.repositories.base.ProductoRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class ProductoService {

	@Autowired
	private ProductoRepository productoRepository;
//	PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA PRODUCTO
	public Producto save(Producto producto) {
		return productoRepository.save(producto);
	}

//	DEVUELVE TODOS LOS PRODUCTOS DE LA TABLA PRODUCTOS
	public List<Producto> findAllProductos() {
		return productoRepository.findAll();
	}

}
