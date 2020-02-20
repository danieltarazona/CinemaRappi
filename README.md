# Cinema

## Features
- Algolia Search
- Algolia Sync Records
- Async CoreData API Sync
- CoreDataStack
- TheMovieDB API 
- Movies and Series
- TopRated, Popular and Upcoming Categories
- Paginate Search
- Codable
- Image Storage as Cache or File
- 55MB Ram Consumption
- XCUITests
- Fastlane Lanes
- XCTest HTML Reports
- Jazzy Docs

## Install

```zsh
git clone https://github.com/ShiftCipher/Cinema.git
cd Cinema
sudo gem install
pod install
brew install https://raw.githubusercontent.com/TitouanVanBelle/XCTestHTMLReport/develop/xchtmlreport.rb
open Cinema.xcworkspace
```

## Generate Docs

```zsh 
bundle exec fastlane jazz
```

## API

### Public
```zsh
https://api.themoviedb.org/3/
```

## Poster

__w300__ as 300x450 or 45KB \
__w500__ as 500x750 or 111KB \
__original__ as 2000x3000 or 1170KB

```zsh
# base_url/t/p/file_size/poster_path
# Avengers Endgame
https://image.tmdb.org/t/p/w500/1ELa9bm6zxIADz8u71VZtvNzx3k.jpg
```
## Requirements

### Platform and Target

| Software         | Version |
|------------------|---------|
| OSX Version      | 11.15.3 |
| Xcode Version    | 11.3.1  |
| iOS Version      | 13.2    |


## Codigo Limpio
Un codigo limpio se caracteriza por:
* El codigo se pudre asi que siempre se debe pensar en la mantenibilidad, debe estar comentado.
* Ser legible para un programador novato, asi llame funciones avanzadas.
* El mejor codigo es el que jamas tiene que ser escrito. Menos codigo es mas.
* Tener un espaciado adecuado 2 a 3 espacios.
* No poseer impresiones en consola.
* No tener cadenas de texto quemadas.
* Debe estar preparado o poseer internacionalizacion.
* La posicion de las llaves es importante, al final de la linea.
* Las variables deben estar bien nombradas: en minusculas.
* Las clases deben estar bien nombradas: en mayuscula utilizando camelcase sin guiones sin simbolos.
* Siempre programar en ingles.
* Debe ser visualmente compacto.
* Puede ser visualmente homogeneo.
* El espaciado es un arte, todo espacio entre lineas tiene una logica.
* las funciones no deben contener mas de 40 lineas de codigo.
* Los archivos no deben contener mas de 200 a 400 lineas de codigo.
* El programador que habita el tao conoce esto y por lo tanto el tao habita en el.

## Unica Responsabilidad 
A cada clase le corresponde una unica responsabilidad, asi pues la programacion orientada a objetos establece que toda clase define a un conjunto de objetos y por lo tanto esa clase a su vez tambien define unos metodos y/o comportamientos para un conjunto tal, luego aparecio la herencia y la interfaz, ahora en un mundo de ciegos, el tuerto es el rey Swift es un lenguaje orientado a protocolos, un paradigma nuevo quizas unico, donde una responsabilidad puede tener una clase, o existir una clase de responsabilidades para una unica responsabilidad, son infinitas posibilidades, ahora testeemos los protocolos de la clase padre exclame, el silencio en la consola es el rey ahora. Gracias Fastlane.

## El Buen Codigo
Un codigo no es bueno, ni es malo, todo bit que es procesado por el computador no tiene en el transistor ninguna intencion mas alla de viajar en los bordes de su canal, suponer que algo es bueno o es malo es darle caracter espiritual, por el contrario existe el codigo eficiente o ineficiente, si no consume mucha ram y puedes copiar y pegarlo en otro proyecto, gran eficiencia has alcanzado a los ojos de tu project manager, si por el contrario debes refactorizar y al hacerlo te consumes un sprint y la mitad de la ram de tu equipo movil, Houston... te presento a mis amigos recursividad, complejidad y optimizacion.

## Clases

* __AppDelegate__ - Clase responsable de gestionar el ciclo de vida de la aplicacion y sus estados iniciales, ademas de inicializar Vaccine para hacer injeccion de live coding.
* __CoreDataStack__ - Clase responsable de inicializar el contexto de CoreData, el contenedor o los contenedores y almacenar la data que va a persistir de acuerdo al contexto.
* __Images__ - Modelo responsable de codificar y decoficar utilizando el protocolo Codable las imagenes para ser almacenadas como BinaryData en CoreData.
* __MoviesDetails__ - Clase responsable de codificar y decoficar utilizando el protocolo Codable los detalles de las peliculas y a su vez administrar el contexto en CoreData.
* __TVDetails__ - Clase responsable de codificar y decoficar utilizando el protocolo Codable los detalles de las series y a su vez administrar el contexto en CoreData.
* __Pages__ - Modelo responsable de codificar y decoficar utilizando el protocolo Codable el sistema de paginacion del API de TheMovieDB y a su vez administrar el contexto en CoreData.
* __Results__ - Modelo responsable de codificar y decoficar utilizando el protocolo Codable los arreglos de objetos dentro de la clase Pages y a su vez administrar el contexto en CoreData.
* __Seasons__ - Modelo responsable de codificar y decoficar utilizando el protocolo Codable los arreglos de objetos dentro de la clase TVDetails y a su vez administrar el contexto en CoreData.
* __Videos__ - Modelo responsable de codificar y decodificar utilizando el protocolo Codable la lista de videos de las peliculas o series.
* __PosterCellView__ - Clase responsable de instanciar las celdas dentro de la UICollectionView de las series y peliculas.
* __PageController__ - Clase responsable de la visualizacion de los datos de la API tanto de TheMovieDB como los resultados de la busqueda online con Algolia.
* __PosterDetailController__ - Clase responsable de la visualizacion de los datos en detalle de las peliculas y series incluyendo los videos.
* __API__ - Clase responsable de gestion de peticiones de cache, networking y/o coredata para las paginas, videos y detalles de las peliculas y series.


## Capas

### Networking
La capa de networking esta compuesta por la clase API, que a la vez gestiona la creacion de espacio de cache, el contexto de CoreData y las peticiones de red a la API, segun la jerarquia y los recursos de mayor a menor impacto en el rendimiento de la aplicacion, por ultimo realiza un guardado directo de los registros a Algolia para lograr sincronizar las peticiones con las busquedas.

## Persistence 
La capa de persistencia funciona entre Cache y CoreData gestionada por la capa de networking para hacer un MVC-N, la clase CoreDataStack se encarga de gestionar la creacion del contexto y del ciclo de vida de los mismos, utilizados luego por el decoder, asi tambien de realizar el guardadado de los datos recibidos por la capa de networking, este esta ligado al achivo Cinema.xcmodel creado para espeficar los datos a almacener en CoreData y tambien en los modelos por el NSManagedObject.

## View 
El SplashScreen fue elaborado como Storyboard, a su vez la capa de vistas esta compuesta por tres clases principalmente PosterCellView que se encarga de instanciar las celdas dentro de una UICollection view en el PageController, dentro podremos encontrar los delegates de la collecion y el por ultimo PosterDetailController que funciona como una vista presentacional de datos, a su vez cada una esta conectada con el Storyboard Main que se encarga del manejo visual de los constraints, elementos y orden de las capas, haciendo el proceso semiprogramatico.

## Bussines Logic
La capa logica de negocio se encuentra embeida entre el PageController y el API, representada principalmente por las busquedas en Algolia, al mostrar los resultados recarga la vista y actualiza los datos, pertenecientes a CoreData, todo mientras mantiene la sincronia con las peticiones del networking y el delegate de la barra de busqueda sin superar los 55MB de memoria ram.

![Layers](/readme/iOS.png)