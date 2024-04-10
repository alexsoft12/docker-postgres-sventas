insert into producto values(1, 'Notebook', 1200.99, '2024-01-01', '2025-01-01');
insert into marcas values(1, 'Samsumg', 1 );

select id , nombre, precio from producto;
select * from marcas;
update producto set nombre = 'Notebook A4', fecha_produccion = '2023-01-01' where id = 1;
-- update producto set id = 2 where id = 1; -- prueba restriocion no update
delete from marcas  where id = 1;
delete from producto  where id = 1;

-- delete from producto; -- Danger no hacer en la BD prod.
truncate marcas;


select v.id,
       concat(c.nombre, ' ', c.apellido) as nombre_completo_cliente,-- sql standard
       v.fecha as fecha_venta,
       p.nombre as producto,
       m.nombre as marca,
       dv.cantidad,
       v.monto_total,
       --    e.nombre || ' ' || e.apellido as nombre_completo, -- postgres neto
       concat(e.nombre, ' ', e.apellido) as nombre_completo_empleado-- sql standard

from ventas v
         left join clientes c on c.id = v.cliente_id
         inner join empleado e on e.id = v.empleado_id
         inner join detalle_ventas dv on v.id = dv.venta_id
         inner join producto p on dv.producto_id = p.id
         inner join marcas m on m.producto_id = p.id
;
select *
from detalle_ventas dv
         inner join producto p on dv.producto_id = p.id
where venta_id = 1;

select *
from detalle_ventas dv
         inner join producto p on dv.producto_id = p.id
order by cantidad desc;

select  sum(cantidad) as total, avg(precio_venta) as total_precio
from detalle_ventas dv
         inner join producto p on dv.producto_id = p.id
-- where cantidad = 9
group by cantidad  ;