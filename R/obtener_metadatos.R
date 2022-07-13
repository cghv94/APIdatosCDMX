#' Elija un ID de las series disponibles y cargue los metadatos de la serie seleccionada al enviroment de R como un data.frame
#' @export
#' @param id numeric variable
#' @import dplyr
#' @import rvest
#' @import utils
#' @importFrom data.table fread
#' @examples
#' id <- 3
#' metadatos <- obtener_metadatos(id = id)
#' metadatos

obtener_metadatos <- function(id) {
  catalogo111 <- utils::read.csv("https://datos.cdmx.gob.mx/dataset/ec3ca76e-3c82-4e0e-9793-5ba6645c7b7f/resource/32264f77-85e0-4d61-a889-ce7deb631134/download/catalogo-recursos.csv")
  catalogo111 <- dplyr::filter(catalogo111, formato == "CSV", nombre_recurso != "Diccionario de Datos")
  catalogo111 <- catalogo111 %>% dplyr::distinct(nombre_conjunto, .keep_all = TRUE)
  catalogo111 <- catalogo111[order(catalogo111$nombre_conjunto),]
  disponibles111 <- data.frame(nombre = catalogo111$nombre_conjunto, id = 1:nrow(catalogo111))
  id111 <- id # No hay diccionario de datos para los atals de riesgos (id: 20-31)
  metadatos111 <- t(dplyr::filter(catalogo111, nombre_conjunto == disponibles111$nombre[id111])) %>% data.frame()
}


