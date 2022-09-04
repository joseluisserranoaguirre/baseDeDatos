

-- 1 Listar las canciones que poseen la letra “z” en su título.

select titulo  from cancion where titulo like "%Z%";


-- 2 Listar las canciones que poseen como segundo carácter la letra “a” y como último, la letra “s”.

select titulo  from cancion where titulo like "_a%s";

-- 3. Mostrar la playlist que tiene más canciones, renombrando las columnas poniendo mayúsculas en la primera letra, los tildes correspondientes y agregar los espacios entre palabras.

select cantcanciones as "Cantidad canciones", idestado as "Id Estado", idPlaylist as "Id Playlist", titulo as Título, idusuario as "Id Usuario", Fechacreacion as "Fecha de Creación", Fechaeliminada as "Fecha eliminada"   
from playlist order by cantcanciones desc;


-- 4. En otro momento se obtuvo un listado con los 5 usuarios más jóvenes, obtener un listado de los 10 siguientes.

select fecha_nac, nombreusuario
from usuario 
order by fecha_nac desc
limit 10
offset 5;

-- 5.Listar las 5 canciones con más reproducciones, ordenadas descendentemente.

select cantreproduccion, titulo
from cancion
order by cantreproduccion desc
limit 5;

-- 6. Generar un reporte de todos los álbumes ordenados alfabéticamente.

select titulo
from album
order by titulo asc;

-- Listar todos los álbumes que no tengan imagen, ordenados alfabéticamente.

select imagenportada, titulo
from album
where imagenportada is null;

-- Insertar un usuario nuevo con los siguientes datos (tener en cuenta las relaciones):
-- a) nombreusuario: nuevousuariodespotify@gmail.com

-- b) Nombre y apellido: Elmer Gomez

-- c) password: S4321m

-- d) Fecha de nacimiento: 15/11/1991

-- e) Sexo: Masculino

-- f) Código Postal: B4129ATF

-- g) País: Colombia

select * from usuario;

insert into usuario values (20, "nuevousuariodespotify@gmail.com", "Elmer Gomez", "1991-11-15" , "M","B4129ATF","B4129ATF", 2, 3, null );
 
select *  from tipousuario;

-- Eliminar todas las canciones de género “pop”.

select * from genero;

select * from generoxcancion;

delete from generoxcancion

where IdGenero = 9; 

-- Editar todos los artistas que no tengan una imagen cargada y cargarles el texto “Imagen faltante” en la columna de imagen.

select *  from artista;

update artista
set imagen = "Imagen faltante"
where imagen = imagen  is null; 
