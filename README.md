# Trabajo Práctico Integrador - TTPS Ruby

Proyecto de software construido con Rails 5.1.4 como trabajo integrador de la materia Taller 
de Tecnologías de Producción de Software de la Facultad de Informática - UNLP. A través del sistema
se pueden gestionar distintos años de cursadas de la materia, las evaluaciones y las notas de los
alumnos en las mismas.

**Dependencias:**

Intérprete de Ruby

Bundler, para las instalación y actualización de las gemas usadas en el proyecto

Rails

SQLite3

Otras dependencias:

Bootstrap(4.0.0), como librería de estilos

Simple-form, para la construcción sencilla de formularios

Sorcery, como mecanismo de autenticación

Font Awesome, para el uso de íconos

**Preparación del ambiente para la ejecución de la app:**

1 - Clonar el repositorio

`git clone https://github.com/triperodericota/catedra-ttps-ruby.git`

2 - Instalación de las dependencias con Bundler

`cd catedra-ttps-ruby/`

`bundle`

Se utiliza SQLite3 como motor de base de datos, en caso de no disponer de dicho DBMS en sistemas 
linux se debe ejecutar:

`sudo apt-get install sqlite3`

3 - Creación de la BD y carga de datos:

`rails db:migrate`

`rails db:seeds`

ó directamente:

`rails db:setup`

4 - Para levantar y correr el servidor:

`rails s`

Acceder a la aplicación desde el browser. Por default: localhost:3000/

Es posible crear una nueva cuenta de usuario en localhost:3000/sign_up ó
iniciar sesión con el email _admin@gmail.com_ y la pass _adminadmin_


**Tests**

Para la ejecución de todos los test usar el comando `rails test`. También es posible ejecutar cada
uno de los tests en forma separada, para esto indicar el path del test que se desea ejecutar 
(por ejemplo: `rails test test/models/course_test.rb`). En caso de querer ejecutar un método en 
particular usar el argumento _-n_ junto con el nombre del método deseado.
