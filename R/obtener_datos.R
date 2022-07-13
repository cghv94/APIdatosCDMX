#' Elija un ID de las series disponibles y cargue la base de datos de la serie seleccionada al enviroment de R como un objeto tipo tibble
#' @export
#' @param id numeric variable
#' @import dplyr
#' @import rvest
#' @import utils
#' @importFrom data.table fread
#' @import tibble
#' @examples
#' id <- 3
#' datos <- obtener_datos(id = id)
#' datos

obtener_datos <- function(id) {
  catalogo11 <- utils::read.csv("https://datos.cdmx.gob.mx/dataset/ec3ca76e-3c82-4e0e-9793-5ba6645c7b7f/resource/32264f77-85e0-4d61-a889-ce7deb631134/download/catalogo-recursos.csv")
  catalogo11 <- dplyr::filter(catalogo11, formato == "CSV", nombre_recurso != "Diccionario de Datos")
  catalogo11 <- catalogo11 %>% dplyr::distinct(nombre_conjunto, .keep_all = TRUE)
  catalogo11 <- catalogo11[order(catalogo11$nombre_conjunto),]
  disponibles11 <- data.frame(nombre = catalogo11$nombre_conjunto, id = 1:nrow(catalogo11))
  id11 <- id # No hay diccionario de datos para los atals de riesgos (id: 20-31)
  liga11 <- rvest::read_html(catalogo11$link_recurso[id11])
  descarga11 <-liga11 %>% rvest::html_element(".resource-url-analytics") %>% rvest::html_attr("href")
  datos11 <- data.table::fread(descarga11, encoding = "Latin-1") # El encoding puede ser Latin-1 o UTF-8
  datos11 <- as_tibble(datos11)
}

