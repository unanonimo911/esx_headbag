# esx_headbag

## Descripción

`esx_headbag` es un script de FiveM que permite a los jugadores poner o quitar una bolsa de la cabeza de un jugador cercano utilizando el comando `/bolsa`. Este script incluye opciones para configurar los trabajos que pueden utilizar esta funcionalidad.

## Configuración

En el archivo `config.lua`, puedes personalizar la configuración del script. Aquí están las opciones disponibles:

```lua
Config = {}

-- Trabajos autorizados para usar la bolsa en la cabeza
Config.jobs = {
    "police",
    "blood",
    "ballas"
}

-- AÑADE LOS TRABAJOS QUE DESEES
