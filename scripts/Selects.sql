-- 1. Definición de Modulos
	-- Parametrización
		-- Tipo de identificación
		-- Estados de Empleado
		-- Estados de mantenimiento
	-- Gestión de Empleados (consultas, crear, modificar, eliminar)
	-- Gestión de Clientes (consultas, crear, modificar, eliminar)
	-- Gestión de Vehiculos y asociación a clientes
	-- 

-- 5.	Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 días
   select a.cliente_id
        , c.primer_nombre || ' ' || c.primer_apellido cliente
        , sum(a.valor_total)
     from facturas              a
     join clientes              b on a.cliente_id   = b.cliente_id
     join personas              c on b.persona_id   = c.persona_id
    where trunc(a.fecha)        >= trunc(sysdate - 60)
 group by a.cliente_id
        , c.primer_nombre
		, c.primer_apellido
 having sum(a.valor_total)      >= 100000;
	
 
 -- 6.	Consulta de los 100 productos más vendidos en los últimos 30 días
    select producto_id
		, count(producto_id)	cantidad_vendida
	 from facturas_item         a
	 join facturas				b on a.factura_id			= b.factura_id
      and trunc(b.fecha)       	>= trunc(sysdate - 30)
 group by producto_id
 order by cantidad_vendida
fetch first 100 rows only;
	

--- 7. Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días.
   select d.sucursal_id
		, count(a.producto_id)		cantidad_vendida
	 from facturas_item				a
	 join facturas_solicitud		b on a.factura_id			= b.factura_id
	 join facturas					c on a.factura_id			= c.factura_id
	 join solicitud_mantenimiento	d on b.solicitud_mante_id	= d.solicitud_mante_id
	where a.producto_id				= 100
	and trunc(c.fecha)        		>= trunc(sysdate - 60)
 group by d.sucursal_id
 having sum(a.producto_id)			>= 100;


--- 8. Consulta de todos los clientes que han tenido más de un(1) mantenimiento en los últimos 30 días.
   select b.cliente_id
		, count(a.solicitud_mante_id)	
	 from solicitud_mantenimiento		a
	 join vehiculos_cliente			    b on a.vehiculo_cliente_id	= b.vehiculo_cliente_id
	where trunc(a.fecha)        		>= trunc(sysdate - 30)
 group by b.cliente_id
 having count(a.solicitud_mante_id)		> 1;


--- 9. Procedimiento que reste la cantidad de productos del inventario de las tiendas cada que se presente una venta.
create or replace procedure actualizar_inventario(p_producto_id		in number
											     , p_cantidad		in number
											     , o_respuesta		out varchar2) as
	begin
		update repuestos
		   set cantidad		= cantidad - p_cantidad
		where repuesto_id	= p_producto_id;
		o_respuesta	:= 'Se actualizo el inventario exitosamente';
		commit;
	exception
		when others then
			o_respuesta	:= 'Error: ' || sqlerrm;
end;
/