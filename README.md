# pokemon
Requerimientos:
- El negocio necesita que los usuarios puedan acceder a una lista completa de Pokémons
  para que puedan agregarlos a su equipo rápidamente.
- Genera una aplicación con 1 sola pantalla.
- La primera pantalla mostrará una lista completa de pokémons. Tendrás que usar el
  endpoint de obtención de la lista que devuelve el nombre únicamente, y complementar
  la lista usando el endpoint del detalle. Está bien si tienes que hacer varias requests para
  enriquecer las tarjetas. Solo se necesita el nombre, imágen (solo una de todos los
  sprites que devuelve el API) y los types (los colores de los types pueden ser cualquiera).
- Muestra un status de loading (skeleton o solo un label con "Cargando..." ) en las
  imágenes de la lista mientras se cargan los datos de la request de detalle.
- Debido a que son muchos pokémons y muchas requests, es necesario paginar la lista
  usando una estrategia Lazy Load
- El botón de agregar a mi equipo agregará el pokémon a un estado global y el ícono de
  la navbar debe mostrar el contador. Si el pokémon ya es parte del equipo, el botón debe
  ser reemplazado por el label "Ya es parte de tu equipo". No se pueden agregar
  pokémons repetidos al equipo. Si ya hay 5 pokémons en el equipo, los botones deben
  mostrar un para notificar que "Tu equipo está completo"
- El ícono superior derecho de la navbar abrirá una Ventana emergente (alert, modal) que
  permita remover pokémons del equipo
- No es necesario guardar datos en ninguna base de datos
- Implementar caché de ser posible para evitar realizar requests recientes