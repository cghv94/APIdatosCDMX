#' Elija un ID de las series disponibles y descargue la base de datos, el diccionario de datos y los metadatos
#' @export
#' @param id numeric variable
#' @import dplyr
#' @import rvest
#' @import utils
#' @importFrom data.table fread
#' @examples
#' # id <- 3
#' # descargar_datos(id = id)
#' # Puede realizar descargas masivas creando un vector con
#' # los ids de las series que desea descargar y un ciclo for:
#' # Ejemplo 1
#' # ids <- 105:110
#' # for(i in ids) {descargar_datos(i)}
#' # Ejemplo 2
#' # series <- c(2, 94, 170, 241)
#' # for(i in series) {descargar_datos(i)}


descargar_datos <- function(id) {
  catalogo1 <- utils::read.csv("https://datos.cdmx.gob.mx/dataset/ec3ca76e-3c82-4e0e-9793-5ba6645c7b7f/resource/32264f77-85e0-4d61-a889-ce7deb631134/download/catalogo-recursos.csv")
  catalogo1 <- dplyr::filter(catalogo1, formato == "CSV", nombre_recurso != "Diccionario de Datos")
  catalogo1 <- catalogo1 %>% dplyr::distinct(nombre_conjunto, .keep_all = TRUE)
  catalogo1 <- catalogo1[order(catalogo1$nombre_conjunto),]
  disponibles1 <- data.frame(nombre = catalogo1$nombre_conjunto, id = 1:nrow(catalogo1))
  id <- id # No hay diccionario de datos para los atals de riesgos (id: 20-31)
  liga <- rvest::read_html(catalogo1$link_recurso[id])
  descarga <-liga %>% rvest::html_element(".resource-url-analytics") %>% rvest::html_attr("href")
  datos <- data.table::fread(descarga, encoding = "Latin-1") # El encoding puede ser Latin-1 o UTF-8
  if (nrow(datos) != 0) {
    write.csv(datos, paste0(disponibles1$nombre[id], ".csv"))
    print(paste0("La base de datos de ", disponibles1$nombre[id], " se descargo con exito"))} else {paste0("No hay datos para ", disponibles1$nombre[id])}

  # Metadatos

  metadatos <- t(dplyr::filter(catalogo1, nombre_conjunto == disponibles1$nombre[id])) %>% data.frame()
  if (nrow(metadatos) != 0) {
    write.csv(metadatos, paste0("metadatos-", disponibles1$nombre[id], ".csv"))
    print(paste0("Los metadatos de ", disponibles1$nombre[id], " se descargaron con exito"))} else {paste0("No hay metadatos para ", disponibles1$nombre[id])}

  # Diccionario. No hay diccionario de datos para los atals de riesgos (id: 20-31)

  diccionario <- utils::read.csv("https://datos.cdmx.gob.mx/dataset/ec3ca76e-3c82-4e0e-9793-5ba6645c7b7f/resource/32264f77-85e0-4d61-a889-ce7deb631134/download/catalogo-recursos.csv")
  diccionario <- dplyr::filter(diccionario, formato == "CSV", nombre_recurso == "Diccionario de Datos")
  diccionario <- diccionario %>% dplyr::distinct(nombre_conjunto, .keep_all = TRUE)
  diccionario <- dplyr::filter(diccionario, nombre_conjunto == disponibles1$nombre[id])

  if (nrow(diccionario) != 0) {
    liga_diccionario <- rvest::read_html(diccionario$link_recurso)
    diccionario <- liga_diccionario %>% rvest::html_element(".resource-url-analytics") %>% rvest::html_attr("href")
    diccionario <- data.table::fread(diccionario, encoding = "Latin-1") # El encoding puede ser Latin-1 o UTF-8
    write.csv(diccionario, paste0("diccionario-de-datos-", disponibles1$nombre[id], ".csv"))
    print(paste0("El diccionario de datos de ", disponibles1$nombre[id], " se descargo con exito"))} else {print(paste0("No hay diccionario de datos para ", disponibles1$nombre[id]))}

}

