#' Muestra las series disponibles en el portal de datos abiertos de la Ciudad de México
#' @export
#' @import dplyr
#' @import rvest
#' @import utils
#' @import tibble
#' @examples
#' catalogo_disponible()

catalogo_disponible <- function() {

  catalogo <- read.csv("https://datos.cdmx.gob.mx/dataset/ec3ca76e-3c82-4e0e-9793-5ba6645c7b7f/resource/32264f77-85e0-4d61-a889-ce7deb631134/download/catalogo-recursos.csv")
  catalogo <- filter(catalogo, formato == "CSV", nombre_recurso != "Diccionario de Datos")
  catalogo <- catalogo %>% distinct(nombre_conjunto, .keep_all = TRUE)
  catalogo <- catalogo[order(catalogo$nombre_conjunto),]
  disponibles <- data.frame(nombre = catalogo$nombre_conjunto, id = 1:nrow(catalogo))
  as_tibble(data.frame(disponibles))
}


