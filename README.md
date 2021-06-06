# Movie Test

## Capas

Estas con las capas que conforman la aplicación, están distribuidas en diferentes carpetas del proyecto que se pueden identificar con los siguientes nombres:

### UI

Son todas aquellas vistas auxiliares que se pueden reutilizar en varias secciones de la aplicación. Las conforman las siguientes clases.

1. SearchBar: Es la barra de búsqueda de la página principal.
2. MoviewCardView: Es la vista de portada para cada película mostrada en la página principal.
3. GenreView: Vista que me permite crear las categorías de la película como si fuera una nube de tags.
4. PopularityBadge: Es esa pequeña vista que muestra de manera visual el promedio de votos dados a una película.
5. CastView: Es la vista para mostrar a los actores que participan en la película.
6. PlaceHolderMovieView: Es una vista que se coloca en caso de que no haya descargado o falte la imagen de la portada de alguna pelicula.
7. AsyncImage: Permite cargar de manera remota una imagen, coloca un placeholder si la carga falla o no existe la imagen en el servidor.

### API

Aquí agrupe todas las clases que servirán para traer información de un servicio web (capa networking), así como las imágenes remotas que requiera el proyecto.

1. ServicesClient: Es la clase genérica para la llamada de servicios usando la versión publisher de URLSession.datatask.
2. MovieAPI: Aquí coloque unas constantes para el proyecto, como apikey, url de servicios y el armado de los request para cada servicio.

#### RemoteImages

Clases auxiliares para la descarga de imágenes para la aplicación.

1. PosterLoader: Es el encargado de descargar las imágenes de las portadas para las películas.
2. ImageCache: Aquí se configuran las propiedades para el cache de las imágenes, así como el limite del cache.
3. EnviromentValues+ImageCache: Extensión para colocar el cache de nuestras imágenes como una variable de ambiente.

### MVVM

Esta es la arquitectura de la aplicación el ejercicio se realizo con SwiftUI y combine e incorpora los siguientes módulos:

1. MovieList: Lista de las películas.
    * MoviesView: Es la vista del módulo.
    * MoviesModel: Son todos los objetos que nos ayudan a enviar información entre las capas.
    * MoviesViewModel: Es la clase con la lógica de negocio de la aplicación, se encarga de cargar la lista de películas.
2. MovieDetail: Es el detalle de cada película.
    *  MovieDetailView: Es la vista del módulo.
    * MovieDetailModel: Son todos los objetos que nos ayudan a enviar información entre las capas.
    * MovieDetailViewModel: Es la clase con la lógica de negocio de la aplicación, se encarga de cargar los detalles de cada película.

## Preguntas

1.  En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito?
    R. Consiste en definir a una sola clase, función o módulo un solo propósito, con el objetivo de evitar errores, complejidad innecesaria, reutilización, mejorar la fase de pruebas y facilitar el entendimiento de esa clase. 
2.  Qué características tiene, según su opinión, un “buen” código o código limpio.
    R. Que Sea fácil de entender, que este documentado, no manejar complejidad innecesaria, que sea actualizable y que de opción a que sea fácil realizar pruebas.