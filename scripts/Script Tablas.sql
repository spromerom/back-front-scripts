

create table tipo_identificacion (
	tipo_identificacion			varchar2(3)		constraint tip_idnti_tip_idetificacion_pk	primary key
												constraint tip_idnti_tip_idetificacion_nn	not null,
	descripcion					varchar2(50)	constraint tip_idnti_descrpcion_nn			not null

);
comment on table tipo_identificacion is  'Tabla que almacena los diferentes tipo de identificación. Ej: Cedula, Pasaporte, etc';

insert into tipo_identificacion (tipo_identificacion, descripcion) values ('CC', 'Cedula de Ciudadania');
insert into tipo_identificacion (tipo_identificacion, descripcion) values ('PS', 'Pasaporte');
insert into tipo_identificacion (tipo_identificacion, descripcion) values ('CC', 'Cedula de Extrangeria');
commit;

create sequence sq_personas;
create table personas(
	persona_id					number(10)		constraint personas_persona_id_pk			primary key
												constraint personas_persona_id_nn			not null,
	tipo_identificacion			varchar2(3)		constraint personas_tipo_idetificacion_fk	references tipo_identificacion (tipo_identificacion)
												constraint personas_tipo_idetificacion_nn	not null,
	identificacion				varchar2(30)	constraint personas_identificacion_nn		not null,
	primer_nombre				varchar2(50)	constraint personas_tip_primer_nomnbre_nn	not null,	
	segundo_nombre				varchar2(50),
	primer_apellido				varchar2(50)	constraint personas_tip_primer_apellido_nn	not null,
	segundo_apellido			varchar2(50),
	numero_celular				number(10)		constraint personas_numero_celular_nn		not null,
	direccion					varchar2(200)	constraint personas_direccion_nn			not null,
	email						varchar2(100)
);
comment on table personas is  'Tabla que almacena la información basica de las personas';


create sequence sq_clientes;
create table clientes(
	cliente_id					number(10)		constraint clientes_cliente_id_pk			primary key
												constraint clientes_cliente_id_nn			not null,
	persona_id					number(10)		constraint clientes_persona_id_fk			references personas (persona_id)
												constraint clientes_persona_id_nn			not null
);
comment on table clientes is  'Tabla que almacena las personas que son cliente de la organización';


create table estado_empleado (
	codigo_estado				varchar2(3)		constraint estado_empleado_cod_estado_pk	primary key
												constraint estado_empleado_cod_estado_nn	not null,
	descripcion					varchar2(50)	constraint estado_empleado_descripcion_nn	not null
);
comment on table estado_empleado is  'Tabla que almacena los diferentes estados de un empleado. Ej: Activo, Inactivo, En vacaciones, etc';
insert into estado_empleado (codigo_estado, descripcion) values ('ACT', 'Activo');
insert into estado_empleado (codigo_estado, descripcion) values ('INA', 'Inactivo');
insert into estado_empleado (codigo_estado, descripcion) values ('VAC', 'Vacaciones');
insert into estado_empleado (codigo_estado, descripcion) values ('LCN', 'Licencia');
insert into estado_empleado (codigo_estado, descripcion) values ('INC', 'Incapacitado');


create sequence sq_empleados;
create table empleados(
	empleado_id					number(10)		constraint empleados_empleado_id_pk			primary key
												constraint empleados_empleado_id_nn			not null,
	persona_id					number(10)		constraint empleados_persona_id_pk			references personas (persona_id)
												constraint empleados_persona_id_nn			not null,
	codigo_estado				varchar2(3)		constraint empleados_estado_emplead_id_fk	references estado_empleado (codigo_estado)
												constraint empleados_estado_emplead_id_nn	not null,
	salario						number(15)		constraint empleados_salario_nn				not null
);
comment on table empleados is  'Tabla que almacena las personas que son empleados de una organización';


create sequence sq_vehiculos;
create table vehiculos(
	vehiculo_id					number(10)		constraint vehiculos_vehiculo_id_pk			primary key
												constraint vehiculos_vehiculo_id_nn			not null,
	placa						varchar2(6)		constraint vehiculos_placa_nn				not null,
	marca						varchar2(50)	constraint vehiculos_marca_nn				not null,
	linea						varchar2(50)	constraint vehiculos_linea_nn				not null,
	modelo						number(4)		constraint vehiculos_modelo_nn				not null,
	color						varchar2(50)	constraint vehiculos_color_nn				not null
);
comment on table vehiculos is  'Tabla que almacena la información básica de los vehiculos';


create sequence sq_vehiculos_cliente;
create table vehiculos_cliente(
	vehiculo_cliente_id			number(10)		constraint vehiculos_cln_vehc_clien_id_pk	primary key
												constraint vehiculos_cln_vehc_clien_id_nn	not null,
	cliente_id					number(10)		constraint vehiculos_cln_cliente_id_fk		references clientes (cliente_id)
												constraint vehiculos_cln_cliente_id_nn		not null,
	vehiculo_id					number(10)		constraint vehiculos_cln_vehiculo_id_fk		references vehiculos (vehiculo_id)
												constraint vehiculos_cln_vehiculo_id_nn		not null,
	constraint vehiculos_cln_vehiculo_clnt_un unique (cliente_id, vehiculo_id)
);
comment on table vehiculos_cliente is  'Tabla que almacena la relacion de los clientes con sus vehiculos';


create sequence sq_sucursales;
create table sucursales(
	sucursal_id					number(10)		constraint sucursales_sucursal_id_pk		primary key
												constraint sucursales_sucursal_id_nn		not null,
	nombre						varchar2(100)	constraint sucursales_nombre_nn				not null,
	direccion					varchar2(200)	constraint sucursales_direccion_nn			not null,
	telefono					number(20)		constraint sucursales_telefono_nn			not null
);
comment on table sucursales is  'Tabla que almacena la información básica de las sucursales de la organización';


create table estado_mantenimiento (
	estado_mante				varchar2(3)		constraint estado_mante_estado_mante_pk		primary key
												constraint estado_mante_estado_mante_nn		not null,
	descripcion					varchar2(50)	constraint estado_mante_descripcion_nn		not null
);
comment on table estado_mantenimiento is  'Tabla que almacena los diferentes estado que puede tener un mantenimiento. Ej: Solicitado, Iniciado, Terminado, etc';
insert into estado_mantenimiento (estado_mante, descripcion) values ('SLC', 'Solicitado');
insert into estado_mantenimiento (estado_mante, descripcion) values ('INC', 'Iniciado');
insert into estado_mantenimiento (estado_mante, descripcion) values ('TRM', 'Terminado');
insert into estado_mantenimiento (estado_mante, descripcion) values ('CNL', 'Cancelado');


create sequence sq_solicitud_mantenimiento;
create table solicitud_mantenimiento(
	solicitud_mante_id			number(10)		constraint soli_mante_solicit_mante_id_pk	primary key
												constraint soli_mante_solicit_mante_id_nn	not null,
	vehiculo_cliente_id			number(10)		constraint soli_mante_vehiculo_cliente_fk	references vehiculos_cliente (vehiculo_cliente_id)
												constraint soli_mante_vehiculo_cliente_nn	not null,
	empleado_id					number(10)		constraint soli_mante_empleado_id_fk		references empleados (empleado_id)
												constraint soli_mante_empleado_id_nn		not null,
	estado_mante				varchar2(3)		constraint soli_mante_estado_mante_fk		references estado_mantenimiento (estado_mante)
												constraint soli_mante_estado_mante_nn		not null,
	sucursal_id					number(15)		constraint soli_mante_sucursal_id_fk		references sucursales (sucursal_id)
												constraint soli_mante_sucursal_id_nn		not null,
	fecha						timestamp		default systimestamp
												constraint soli_mante_estado_fecha_nn		not null
);
comment on table solicitud_mantenimiento is  'Tabla que almacena la información de las solicitudes de mantenimiento';


create sequence sq_fotos_mantenimiento;
create table fotos_mantenimiento(
	foto_mante_id				number(10)		constraint fotos_mante_foto_mante_id_pk		primary key
												constraint fotos_mante_foto_mante_id_nn		not null,
	solicitud_mante_id			number(10)		constraint fotos_mante_solicit_mant_id_fk	references solicitud_mantenimiento (solicitud_mante_id)
												constraint fotos_mante_solicit_mant_id_nn	not null,
	foto						blob			constraint fotos_mante_empleado_id_nn		not null
);
comment on table fotos_mantenimiento is  'Tabla que almacena las fotos adjuntadas por el cliente al solicitar el mantenimiento';


create sequence sq_repuestos;
create table repuestos(
	repuesto_id					number(10)		constraint repuestos_repuesto_id_pk			primary key
												constraint repuestos_repuesto_id_nn			not null,
	nombre						varchar2(200)	constraint repuestos_nombre_nn				not null,
	referencia					varchar2(30)	constraint repuestos_referencia_nn			not null,
	descripcion					varchar2(100)	constraint repuestos_descripcion			not null,
	precio_unidad				number(15)		constraint repuestos_precio_unidad_nn		not null,
	cantidad					varchar2(4)		constraint repuestos_cantidad_nn			not null
);
comment on table repuestos is  'Tabla que almacena el inventario de repuestos que existen';


create sequence sq_servicios;
create table servicios(
	servicio_id					number(10)		constraint servicios_servicio_id_pk			primary key
												constraint servicios_servicio_id_nn			not null,
	tipo_servicio				varchar2(200)	constraint servicios_tipo_servicio_nn		not null,
	descripcion					varchar2(100)	constraint servicios_descripcion			not null,
	valor_minimo				number(15)		constraint servicios_valor_minimo_nn		not null,
	valor_maximo				number(15)		constraint servicios_valor_maximo_nn		not null
);
comment on table servicios is  'Tabla que almacena la lista del los servicios que presta la organización';


create sequence sq_repuestos_mantenimiento;
create table repuestos_mantenimiento(
	reepuesto_mante_id			number(10)		constraint repuest_mante_reps_mante_id_pk	primary key
												constraint repuest_mante_reps_mante_id_nn	not null,
	solicitud_mante_id			number(10)		constraint repuest_mante_solic_mant_id_fk	references solicitud_mantenimiento (solicitud_mante_id)
												constraint repuest_mante_solic_mant_id_nn	not null,
	repuesto_id					number(10)		constraint repuest_mante_repuesto_id_fk		references repuestos (repuesto_id)
												constraint repuest_mante_repuesto_id_nn		not null,
	cantidad					number(13)		constraint repuest_mante_cantidad_nn		not null,
	descuento					number(10)		default 0
												constraint repuest_mante_descuento_nn		not null
);
comment on table repuestos_mantenimiento is  'Tabla que almacena el listado de los repuestos que se utilizaron en la solicitud de un mantenimiento';


create sequence sq_servicios_mantenimiento;
create table servicios_mantenimiento(
	servicio_mante_id			number(10)		constraint servi_mante_servci_mante_id_pk	primary key
												constraint servi_mante_servci_mante_id_nn	not null,
	solicitud_mante_id			number(10)		constraint servi_mante_solicit_mant_id_fk	references solicitud_mantenimiento (solicitud_mante_id)
												constraint servi_mante_solicit_mant_id_nn	not null,
	servicio_id					number(10)		constraint servi_mante_servicio_id_fk		references servicios (servicio_id)
												constraint servi_mante_servicio_id_nn		not null,
	valor_servicio				number			default 0
												constraint servi_mante_valor_servicio_nn	not null
);
comment on table servicios_mantenimiento is  'Tabla que almacena el listado de los servicios que se realizaron bajo una solicitud de un mantenimiento';


create sequence sq_facturas;
create table facturas(
	factura_id					number(10)		constraint facturas_factura_id_pk			primary key
												constraint facturas_factura_id_nn			not null,
	numero_factura				varchar2(10)	constraint facturas_numero_factura_un		unique
												constraint facturas_numero_factura_nn		not null,
	cliente_id					number(10)		constraint facturas_cllientes_id_fk			references clientes (cliente_id)
												constraint facturas_cllientes_id_nn			not null,
	fecha						timestamp		default systimestamp
												constraint facturas_fecha_nn				not null,
	valor_presupuesto			number(15)		constraint facturas_valor_presupuesto_nn	not null,
	valor_subtotal				number(15)		constraint facturas_valor_subtotal_nn		not null,
	valor_iva					number(15)		constraint facturas_valor_iva_nn			not null,
	valor_descuento				number(15)		default 0
												constraint facturas_valor_descuento_nn		not null,
	valor_total					number(15)		constraint facturas_valor_total_nn			not null
	
);
comment on table facturas is  'Tabla que almacena la información de las facturas realizadas a un client';


create sequence sq_facturas_solicitud;
create table facturas_solicitud (
	factura_soli_id				number(10)		constraint facturas_soli_factura_sol_id_pk	primary key
												constraint facturas_soli_factura_sol_id_nn	not null,
	factura_id					number(10)		constraint facturas_soli_factura_id_fk		references facturas (factura_id)
												constraint facturas_soli_factura_id_nn		not null,
	solicitud_mante_id			number(10)		constraint facturas_soli_solici_mant_id_fk	references solicitud_mantenimiento (solicitud_mante_id)
												constraint facturas_soli_solici_mant_id_nn	not null,
	valor_total					number(15)		constraint facturas_soli_valor_total_nn		not null
);
comment on table facturas_solicitud is  'Tabla que almacena la relacion de las facturas de un cliente con las solicutudes de manteniento realizadas';


create sequence sq_facturas_item;
create table facturas_item (
	factura_item				number(10)		constraint facturas_item_factura_item_pk	primary key
												constraint facturas_item_factura_item_nn	not null,
	factura_id					number(10)		constraint facturas_item_factura_id_fk		references facturas (factura_id)
												constraint facturas_item_factura_id_nn		not null,
	tipo_producto				number(10)		constraint facturas_item_tipo_producto_nn	not null,
	producto_id					number(10)		constraint facturas_item_producto_id_nn		not null,
	cantidad					number(4)		constraint facturas_item_cantidad_id_nn		not null,
	precio_unidad				number(15)		constraint facturas_item_precio_unidad_nn	not null,
	valor_total					number(15)		constraint facturas_item_valor_total_nn		not null
);
comment on table facturas_item is  'Tabla que almacena la relacion de los productos y servicios contenidos en una factura';
	
	

