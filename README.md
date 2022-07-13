
# APIdatosCDMX

<!-- badges: start -->
<!-- badges: end -->

El objetivo del paquete `APIdatosCDMX` es facilitar la descarga masiva de datos desde el portal de datos abiertos de la Ciudad de México. Más de 240 bases de datos a su disposición. 

## Instalación

Usted puede instalar la versión en desarrollo de `APIdatosCDMX` mediante el siguiente código:

``` r
# install.packages("devtools")
devtools::install_github("cghv94/APIdatosCDMX")
```

## Ejemplo

Para activar el paquete, utilice `library(APIdatosCDMX)`:

``` r
library(APIdatosCDMX)
```

Para acceder al catálogo de datos disponibles en el portal de datos abiertos de la Ciudad de México, utilice la función `catalogo_disponible()`:

``` r
catalogo_disponible()
```

Elija un ID de las series disponibles:

``` r
id <- 3
```

Usted puede cargar la base de datos de la serie seleccionada al enviroment de R como un objeto tipo tibble, mediante la función `obtener_datos`:

``` r
datos <- obtener_datos(id = id)
datos
```

Usted puede cargar los metadatos de la serie seleccionada al enviroment de R como un objeto tipo data.frame, mediante la función `obtener_metadatos`:

``` r
metadatos <- obtener_metadatos(id = id)
metadatos
```

Para descargar la base de datos, el diccionario de datos y los metadatos en formato `.csv`, utilice la función `descargar_datos` y escriba el ID de la serie que desea descargar dentro del paréntesis:

``` r
descargar_datos(id = id)
```

También puede ver el ejemplo disponible en RStudio Cloud: <https://rstudio.cloud/project/4256994>

## Notas

Este paquete es un diseño experimental de una API no oficial para realizar descargas masivas del portal de datos abiertos de la Ciudad de México:
<https://datos.cdmx.gob.mx/>

## Contacto

Puede ponerse en contacto con el autor del paquete `APIdatosCDMX` mediante el siguiente correo electrónico: 
<cghv94@outlook.es>

Twitter:
<https://twitter.com/cghv94>
