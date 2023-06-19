
-- public.candidatos definition

-- Drop table

-- DROP TABLE public.candidatos;

CREATE TABLE public.candidatos (
	id_candidato serial4 NOT NULL,
	nombre_candidato varchar NOT NULL,
	CONSTRAINT candidatos_pk PRIMARY KEY (id_candidato)
);

-- public.regiones definition

-- Drop table

-- DROP TABLE public.regiones;

CREATE TABLE public.regiones (
	id_region serial4 NOT NULL,
	nombre_region varchar NOT NULL,
	CONSTRAINT regiones_pk PRIMARY KEY (id_region)
);

-- public.comunas definition

-- Drop table

-- DROP TABLE public.comunas;

CREATE TABLE public.comunas (
	id_comuna serial4 NOT NULL,
	nombre_comuna varchar NOT NULL,
	id_region int4 NOT NULL,
	CONSTRAINT comunas_pk PRIMARY KEY (id_comuna),
	CONSTRAINT comunas_un UNIQUE (id_region)
);

-- public.formulario_postulacion definition

-- Drop table

-- DROP TABLE public.formulario_postulacion;

CREATE TABLE public.formulario_postulacion (
	nombre_apellido varchar NOT NULL,
	alias varchar NOT NULL,
	rut varchar NOT NULL,
	email varchar NOT NULL,
	id_region int4 NOT NULL,
	id_comuna int4 NOT NULL,
	id_candidato int4 NOT NULL,
	metodo_divulgacion json NOT NULL,
	id_formulario serial4 NOT NULL,
	CONSTRAINT formulario_postulacion_pk PRIMARY KEY (id_formulario)
);


-- public.formulario_postulacion foreign keys

ALTER TABLE public.formulario_postulacion ADD CONSTRAINT formulario_postulacion_candidatos_fk FOREIGN KEY (id_candidato) REFERENCES public.candidatos(id_candidato);
ALTER TABLE public.formulario_postulacion ADD CONSTRAINT formulario_postulacion_comunas_fk FOREIGN KEY (id_comuna) REFERENCES public.comunas(id_comuna);
ALTER TABLE public.formulario_postulacion ADD CONSTRAINT formulario_postulacion_fk FOREIGN KEY (id_region) REFERENCES public.regiones(id_region);

-- public.comunas foreign keys

ALTER TABLE public.comunas ADD CONSTRAINT comunas_fk FOREIGN KEY (id_region) REFERENCES public.regiones(id_region);




INSERT INTO public.candidatos (id_candidato,nombre_candidato) VALUES
	 (1,'Juan perez'),
	 (2,'Tania morales'),
	 (3,'Jose torres'),
	 (4,'Javiera rodriguez');

INSERT INTO public.regiones (id_region,nombre_region) VALUES
	 (1,'Arica y parinacota'),
	 (2,'Tarapaca'),
	 (3,'Antofagasta'),
	 (4,'Atacama'),
	 (5,'Coquimbo'),
	 (6,'Valparaiso'),
	 (7,'Metropolitana'),
	 (9,'Maule'),
	 (10,'Nuble'),
	 (11,'Biobio');
INSERT INTO public.regiones (id_region,nombre_region) VALUES
	 (12,'La araucania'),
	 (13,'Los rios'),
	 (14,'Los Lagos'),
	 (15,'Aysen'),
	 (16,'Magallanes'),
	 (8,'Ohiggins');
	 
INSERT INTO public.comunas (id_comuna,nombre_comuna,id_region) VALUES
	 (1,'Arica',1),
	 (2,'Alto Hospicio',2),
	 (3,'Calama',3),
	 (4,'Alto del Carmen',4),
	 (5,'La Serena',5),
	 (6,'Quillota',6),
	 (7,'Independencia',7),
	 (8,'Navidad',8),
	 (9,'Curico',9),
	 (10,'Chillan',10);
INSERT INTO public.comunas (id_comuna,nombre_comuna,id_region) VALUES
	 (11,'Arauco',11),
	 (12,'Temuco',12),
	 (13,'Valdivia',13),
	 (14,'Puerto Varas',14),
	 (15,'Aysen',15),
	 (16,'Punta Arenas',16);