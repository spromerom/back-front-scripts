-- EN ESTE CONTEXTO SE NECESITA CREAR UN CRUD (CREAR, CONSULTAR, ACTUALIZAR, Y ELIMINAR) PARA LA FUNCIONALIDAD DE CLIENTES:

-- Crear / Actualizar Cliente
create or replace procedure crear_actualizar_cliente( p_cliente_id				in out number
													, p_tipo_identificacion		in varchar2
													, p_identificacion			in varchar2
													, p_primer_nombre			in varchar2
													, p_segundo_nombre			in varchar2
													, p_primer_apellido			in varchar2
													, p_segundo_apellido		in varchar2
													, p_numero_celular			in number
													, p_direccion				in varchar2
													, p_email					in varchar2
													, o_respuesta				out varchar2) as
	v_persona_id	personas.persona_id%type;	
	begin
		-- Creación
		if p_cliente_id is null then 
			-- Se registra la persona
			begin
				v_persona_id	:= sq_personas.nextval;
				insert into personas (persona_id,			tipo_identificacion,	identificacion,			primer_nombre
									, segundo_nombre,		primer_apellido,		segundo_apellido,		numero_celular
									, direccion,			email) 
							  values (v_persona_id,			p_tipo_identificacion,	p_identificacion,		p_primer_nombre
									, p_segundo_nombre,		p_primer_apellido,		p_segundo_apellido,		p_numero_celular
									, p_direccion,			p_email);				
			exception
				when others then
					o_respuesta	:= 'Error al crear la persona ' || sqlerrm;
			end;
			
			-- Se registra el cliente
			begin 
				p_cliente_id	:= sq_clientes.nextval;
				insert into clientes (cliente_id, persona_id) values (p_cliente_id, v_persona_id);
			exception
				when others then
					o_respuesta	:= 'Error al crear el cliente ' || sqlerrm;
			end;
			
			o_respuesta	:= 'Se creo el cliente exitosamente';
		
		-- Actualización
		else
			begin
				update personas
				   set tipo_identificacion		= p_tipo_identificacion
				     , identificacion			= p_identificacion
				     , primer_nombre			= p_primer_nombre
				     , segundo_nombre			= p_segundo_nombre
				     , primer_apellido			= p_primer_apellido
				     , segundo_apellido			= p_segundo_apellido
				     , numero_celular			= p_numero_celular
				     , direccion				= p_direccion
				     , email					= p_email
				 where persona_id				= (select persona_id from clientes where cliente_id = p_cliente_id);
			exception
				when others then
					o_respuesta	:= 'Error al actualizar la informaciòn del cliente ' || sqlerrm;
			end;
		end if;
	exception
		when others then
			o_respuesta	:= 'Error: ' || sqlerrm;
end;
/

-- Consultar cliente
create or replace procedure consultar_cliente ( p_cliente_id				in number
											  , o_tipo_identificacion		out varchar2
											  , o_identificacion			out varchar2
											  , o_primer_nombre			out varchar2
											  , o_segundo_nombre			out varchar2
											  , o_primer_apellido			out varchar2
											  , o_segundo_apellido			out varchar2
											  , o_numero_celular			out number
											  , o_direccion					out varchar2
											  , o_email						out varchar2
											  , o_respuesta					out varchar2) as
	begin
		select tipo_identificacion
			  , identificacion	
			  , segundo_nombre	
			  , primer_apellido	
			  , segundo_apellido
			  , numero_celular	
			  , direccion		
			  , identificacion	
			  , email
		   into o_tipo_identificacion
			  , o_identificacion	
			  , o_segundo_nombre	
			  , o_primer_apellido	
			  , o_segundo_apellido
			  , o_numero_celular	
			  , o_direccion		
			  , o_identificacion	
			  , o_email
		 from personas
		where persona_id		= (select persona_id from clientes where cliente_id = p_cliente_id);
	exception
		when no_data_found then
			o_respuesta	:= 'No se encontro informaciòn para el cliente ingresado';
		when others then
			o_respuesta	:= 'Error al consultar el cliente: ' || sqlerrm;
	end;
/

-- Eliminar cliente
create or replace procedure eliminar_cliente ( p_cliente_id				in number
											  , o_respuesta					out varchar2) as
	
	begin
		delete from clientes where cliente_id = p_cliente_id;
		commit;
	exception
		when others then
			o_respuesta	:= 'Error al eliminar el cliente: ' || sqlerrm;
	
end;
/


-- Eliminar cliente
create or replace procedure eliminar_cliente ( p_cliente_id				in number
											  , o_respuesta					out varchar2) as
	
	begin
		delete from clientes where cliente_id = p_cliente_id;
		commit;
	exception
		when others then
			o_respuesta	:= 'Error al eliminar el cliente: ' || sqlerrm;
	
end;
/
