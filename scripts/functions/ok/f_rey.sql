/*
función que retorna la coordenada del rey del jugador 1 ó 2
*/
create or replace function f_rey(n number)
return number is
	rey coordenadas_tablero.id_cord_tab%type;
	f number(1);
	mueven varchar2(9);
	partida partida_activa.id_partida%type;
begin
	partida := f_partida_activa;
	if partida > 0 then
		mueven := f_mueve;
		if n = 1 then
			if mueven = 'Blancas' then
				f := 0;
			else
				f := 6;
			end if;
		else
			if mueven = 'Blancas' then
				f := 6;
			else
				f := 0;
			end if;
		end if;
		-- se define la coordenada del rey
		select coalesce(sum(id_cord_tab),0) 
		into rey
		from estado_partidas
		where id_ficha = (1 + f) and id_partida = partida;
	else
		rey := -1; -- no hay partida activa
	end if;
	return rey;
end;
/