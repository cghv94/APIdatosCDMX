% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/obtener_datos.R
\name{obtener_datos}
\alias{obtener_datos}
\title{Elija un ID de las series disponibles y cargue la base de datos de la serie seleccionada al enviroment de R como un objeto tipo tibble}
\usage{
obtener_datos(id)
}
\arguments{
\item{id}{numeric variable}
}
\description{
Elija un ID de las series disponibles y cargue la base de datos de la serie seleccionada al enviroment de R como un objeto tipo tibble
}
\examples{
id <- 3
datos <- obtener_datos(id = id)
datos
}
