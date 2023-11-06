class Comida{
	const property estamina
	method  serComidaPor(unEmpleado){
		unEmpleado.recuperarEstaminaEn(self.estamina())
	}
	
}

const banana  = new Comida(estamina = 10)
const manzana = new Comida(estamina = 5)
const uva     = new Comida(estamina = 1)