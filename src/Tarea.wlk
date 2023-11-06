class Tarea{
	/* Punto 3 */
	method serRealizadaPor(unEmpleado){
		self.validarQueLaPuedaRealizar(unEmpleado)
		self.efectoDeTareaEn(unEmpleado)
	}
	
	method validarQueLaPuedaRealizar(unEmpleado){
		if(not self.laPuedeHacer(unEmpleado)) throw new Exception(message = "No puede realizar la tarea porque no cumple con los requisitos")
	}
	
	method laPuedeHacer(unEmpleado)
	
	method efectoDeTareaEn(unEmpleado)
}

class ArreglarUnaMaquina inherits Tarea{
	const maquina
	
	override method laPuedeHacer(unEmpleado) =  unEmpleado.tieneTantaEstaminaComo(maquina.complejidad()) and unEmpleado.tieneHerramientas(maquina.herramientasNecesarias())
	
	override method efectoDeTareaEn(unEmpleado){
		unEmpleado.perderEstaminaEn(self.complejidad())
	}
	
	method complejidad() = maquina.complejidad() * 2
}

class DefenderSector{
	const gradoDeAmenaza
	
	method validarQueLaPuedaRealizar(unEmpleado) = unEmpleado.puedeDefenderSector(gradoDeAmenaza)
	
	//method tieneFuerzaSuficiente(unEmpleado) = unEmpleado.fuerza() >= gradoDeAmenaza
	
	method efectoDeTareaEn(unEmpleado){
		unEmpleado.efectoPorDefenderSector()
	}
	
	method complejidad(unEmpleado) = gradoDeAmenaza * unEmpleado.factorDeComplejidadEnLaDefensaDelSector()
}

class LimpiarSector{
	const esGrandeElSector
	
	method complejidad() = cientifico.valorDeComplejidadPorLimpieza()
	
	method validarQueLaPuedaRealizar(unEmpleado) = unEmpleado.tieneTantaEstaminaComo(self.valorSegunSector())
	
	method valorSegunSector() = if (esGrandeElSector) 4 else 1
	
	method efectoDeTareaEn(unEmpleado){
		unEmpleado.limpiarSector(self.valorSegunSector())
	}
}	

object cientifico{
	method valorDeComplejidadPorLimpieza() = 10
}

class Maquina{/* Como no hay mucha info podría no reificarse y que esto sean properties de ArreglarMaquina */
	const property complejidad
	const property herramientasRequeridas
}