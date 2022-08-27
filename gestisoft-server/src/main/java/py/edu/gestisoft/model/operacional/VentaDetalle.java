package py.edu.gestisoft.model.operacional;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import py.edu.gestisoft.model.base.Producto;

@Entity
@Table(name = "VENTA_DETALLE")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class VentaDetalle {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID_VENTA_DETALLE")
	private Long id;

//	PARA CALCULO DE CANTIDADES ES MEJOR UTILIZAR BIG DECIMAL 
	@NonNull
	@Column(name = "CANTIDAD")
	private BigDecimal cantidad;

//	PARA CALCULO DE VALORES ES MEJOR UTILIZAR BIG DECIMAL 
	@NonNull
	@Column(name = "PRECIO")
	private BigDecimal precio;

	@ManyToOne
	@JoinColumn(name = "ID_VENTA", referencedColumnName = "ID_VENTA")
	private Venta venta;

	@ManyToOne
	@JoinColumn(name = "ID_PRODUCTO", referencedColumnName = "ID_PRODUCTO")
	private Producto producto;

}
