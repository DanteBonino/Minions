class Empleado{
	var estamina
	const tareasRealizadas = new List()
	var rol
	
	method estamina() = estamina
	
	/* Punto 1 */
	method comer(unaFruta){
		unaFruta.serComidaPor(self)
	}
	
	method recuperarEstaminaEn(unaCantidad)
	
	/* Punto 2 */
	method experiencia() = self.cantidadDeTareasRealizadas() * self.dificultadTotalDeLasTareas()
	
	method cantidadDeTareasRealizadas() = tareasRealizadas.size()
	
	method dificultadTotalDeLasTareas() = tareasRealizadas.sum{unaTarea => unaTarea.complijidad()}
	
	/* Punto 3 */
	/* Arreglar Máquinas */
	method tieneTantaEstaminaComo(unaCantidad) = estamina >= unaCantidad
	
	method tieneHerramientas(unasHerramientas) = rol.tieneHerramientas(unasHerramientas)
	
	/* Defender Sector */
	method puedeDefenderSector(unGradoDeAmenaza){
		rol.puedeDefenderSector(self, unGradoDeAmenaza)
	}
	
	method fuerza() = estamina/2 + 2 + rol.factorDeFuerza()
	
	method perderEstaminaEn(unaCantidad){
		estamina = 0.max(estamina - unaCantidad)
	}
	
	method efectoPorDefenderSector(){
		rol.defenderSector(self)
	}
	
	method perderPorcentajeDeEstamina(unPorcentaje){
		estamina *= unPorcentaje/100
	}
	
	 /* Limpiar Sector */
	method limpiarSector(estaminaSegunSector){
		rol.limpiarSector(self, estaminaSegunSector)
	}
	
	method realizar(unaTarea){
		rol.realizarTarea(self, unaTarea) /* A partir del punto 4 */
		self.agregarTareaRealizada(unaTarea)
	}
	
	method agregarTareaRealizada(unaTarea){
		tareasRealizadas.add(unaTarea)
	}
	
	method esMasExperimentado(otroEmpleado) = self.experiencia() > otroEmpleado.experiencia()
	
	method puedeRealizarTarea(unaTarea) = unaTarea.laPuedeHacer(self)
}

class Ciclope inherits Empleado{
	/* Punto 1 */
	override method recuperarEstaminaEn(unaCantidad){
		estamina += unaCantidad
	}
	
	override method fuerza() = super()/2
	
	method factorDeComplejidadEnLaDefensaDelSector() = 2
}

class Biclope inherits Empleado{
	/* Punto 1 */
	override method recuperarEstaminaEn(unaCantidad){
		estamina = 10.min(estamina + unaCantidad)
	}
	
	method factorDeComplejidadEnLaDefensaDelSector() = 1
}

class Rol{
	method tieneHerramientas(unasHerramientas) = unasHerramientas.isEmpty()
	
	method puedeDefenderSector(unEmpleado, unGradoDeAmenaza) = unEmpleado.fuerza() > unGradoDeAmenaza
	
	method factorDeFuerza() = 0
	
	method limpiarSector(unEmpleado, unaCantidad){
		unEmpleado.perderEstaminaEn(unaCantidad)
	}
	
	method defenderSector(unEmpleado){
		unEmpleado.perderPorcentajeDeEstamina(50)
	}
	
	method realizarTarea(unEmpleado, unaTarea){
		unaTarea.serRealizadaPor(unEmpleado)
	}
}

object mucama inherits Rol{
	override method limpiarSector(_unEmpleado, _unaCantidad){
		/* No hace nada */
	}
	
	override method puedeDefenderSector(_unEmpleado, _unGradoDeAmenaza) = false
}

class Obrero inherits Rol{
	const herramientas
	override method tieneHerramientas(unasHerramientas) = unasHerramientas.all{herramienta => herramientas.contains(herramienta)}
}

class Soldado inherits Rol{
	var practica
	var danio
	
	override method factorDeFuerza() = practica
	
	override method defenderSector(_unEmpleado){
		self.usarArma()
	}
	
	method usarArma(){
		practica ++
		danio += 2
	}
}

class Capataz inherits Rol{
	const empleados
	
	override method realizarTarea(unEmpleado, unaTarea){
		super(self.empleadoMasExperimentadoParaResolver(unaTarea), unaTarea)
	}
	
	method empleadoMasExperimentadoParaResolver(unaTarea){
		return self.empleadosSegunExperiencia().findOrDefault({unEmpleado => unEmpleado.puedeRealizarTarea()}, self)
	}
	
	method empleadosSegunExperiencia() = empleados.sortedBy{unEmpleado, otroEmpleado => unEmpleado.esMasExperimentado(otroEmpleado)}
	/*
	 * Cuál sería el más experimentado?
	 */
}
