SET sql_mode = 'ONLY_FULL_GROUP_BY';

-- Listar todos los huéspedes cuyo nombre comience con la letra "S". Se debe
-- mostrar id como "Número de huésped", apellido y nombre.

select nombre, id as "Número de huésped", apellido
from huesped
where nombre like "s%";


-- 2. Mostrar el número de legajo del empleado con domicilio "Av. Rosalind Franklin
-- 600".

select legajo, domicilio
from empleado
where domicilio= "Av. Rosalind Franklin 600";


-- 3. Se requiere saber cuál es el mayor importe registrado en las reservas.


select max(importe)
from reserva
order by importe desc;


-- 4. Listar las reservas realizadas con números 15, 19, 21, 35.

select id
from reserva
WHERE id IN (15,19,21,35);


-- 5. Calcular el importe total recaudado para la habitación número 40. El reporte
-- debe tener dos columnas denominadas "Número de habitación " y el "Importe
-- Total".

select sum(importe) as "Importe Total", habitacion_numero as "Número de habitación " 
from checkin
where habitacion_numero = 40;


-- Base de datos I - CheckPoint II - Pág. 1

-- 6. Listar de manera ordenada (fecha de nacimiento), los empleados que no
-- pertenezcan al sector 3 y que la fecha de nacimiento sea mayor que 3/9/1989 o
-- igual a 7/11/1986.

select fecha_nacimiento, sector_id
from empleado
where sector_id != 3 and fecha_nacimiento> "1989-9-3" or fecha_nacimiento = "1986-11-7"
order by fecha_nacimiento;


-- 7. Listar los importes de las reservas con valor entre $10499,50 a $12000,00
-- (ordenarlos por el importe de mayor a menor).


select importe
from reserva
where importe between 10499.50 and 12000.00
order by importe desc;

-- 8. Mostrar el quinto importe del check-in realizado con menor valor.
-- 9. Mostrar el check-in con mayor importe. Este reporte debe contener el número
-- del check-in, fecha de entrada y el importe.
-- 10. Mostrar las diez reservas con menor importe. Este reporte debe contener el
-- número de reserva, importe y el número del servicio.
-- 11. Listar las reservas registradas entre 14/07/21 al 15/08/21 (ordenarlos por fecha)
-- 12. Listar en forma ordenada los check-in que tengan un importe superior o igual a
-- $34125,00 y con fecha de salida inferior a 26/6/2020.
-- 13. Listar todos los empleados cuyo nombre termine con los caracteres "ia". Se debe
-- mostrar el legajo, apellido, nombre y teléfono móvil.
-- 14. Se desea conocer cuál es el importe promedio de las reservas que se hayan
-- pagado en efectivo.
-- 15. Mostrar el tercer check-in con mayor importe pagado con tarjeta de crédito.
-- 16. Calcular la cantidad de check-in que tiene la habitación número siete. El reporte
-- debe tener dos columnas denominadas "Habitación" y el "Cantidad".
-- 17. Mostrar todos los domicilios de los huéspedes que contengan una palabra de
-- cinco caracteres, pero el tercer carácter debe ser igual a "n".
-- 18. Modificar el tipo de decoración "italiana" por "romana"
-- 19. Agregar al huésped Palermo Díaz Ricardo Omar cuyo pasaporte es 28001555 y
-- fecha de nacimiento 5/1/1980, domiciliado en calle Av. Sarmiento 752 este -
-- Argentina, teléfono móvil +542645667714 y el correo electrónico es
-- pal1980sj@gmail.com.
-- 20. Eliminar el registro del servicio básico número 5
