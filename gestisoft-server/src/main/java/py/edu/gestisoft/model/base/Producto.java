package py.edu.gestisoft.model.base;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

@Entity
@Table(name = "PRODUCTO")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Producto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID_PRODUCTO")
	private Long id;

	@NonNull
	@Column(name = "ESTADO")
	private Boolean estado;

	@NonNull
	@Column(name = "NOMBRE")
	private String nombre;

//	TODO 4
//	VERIFICAR SI SE CAMBIA A BIG DECIMAL
	@NonNull
	@Column(name = "CANTIDAD")
	private Long cantidad;

//	TODO 5
//	VERIFICAR SI SE CAMBIA A BIG DECIMAL
	@Column(name = "PRECIO_VENTA")
	private Long precioVenta;

	@Column(name = "UNIDAD_MEDIDA")
	private String unidadMedida;

	@Column(name = "FECHA_REGISTRO")
	private LocalDateTime fechaRegistro;

	@Column(name = "EXISTENCIA")
	private Double existencia;

	@Column(name = "OBSERVACION")
	private String observacion;

}
