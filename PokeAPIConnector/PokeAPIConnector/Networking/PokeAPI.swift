//
//  PokeAPI.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

func fetchPokemonData() {
    // Definimos la URL base de la API de Pokémon
    let baseURL = "https://pokeapi.co/api/v2/"
    // Definimos el endpoint específico para obtener información sobre un Pokémon
    let pokemonEndpoint = "pokemon/1/" // Cambia "1" por el ID del Pokémon que quieras obtener

    // Construimos la URL completa combinando la URL base y el endpoint del Pokémon
    if let url = URL(string: baseURL + pokemonEndpoint) {
        // Creamos una tarea de URLSession para realizar la solicitud GET
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Verificamos si hubo algún error al realizar la solicitud
            if let error = error {
                print("Error al realizar la solicitud: \(error.localizedDescription)")
                return
            }
            
            // Verificamos si la respuesta de la solicitud es válida (código de estado HTTP 200-299)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Respuesta de la solicitud no válida")
                return
            }
            
            // Verificamos si se recibieron datos en la respuesta
            if let data = data {
                do {
                    // Intentamos convertir los datos recibidos en un objeto JSON
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    // Imprimimos la respuesta JSON obtenida (puedes procesarla según tus necesidades)
                    print(json)
                } catch {
                    // Si hay un error al convertir los datos JSON, lo manejamos e imprimimos el error
                    print("Error al convertir los datos JSON: \(error.localizedDescription)")
                }
            }
        }
        // Iniciamos la tarea de URLSession para realizar la solicitud
        task.resume()
    }
}
