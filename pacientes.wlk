class Paciente {
  var property edad
  var property fortaleza
  var property dolor 

  method puedeUsarAparato(unAparato) = 
    unAparato.puedeSerUsado(self)

  method usarAparato(unAparato) {
    if (self.puedeUsarAparato(unAparato)){
      unAparato.serUsado(self)
    }
  }

  method disminuirDolor(unaCantidad){
    dolor = 0.max(dolor - unaCantidad)
  }

  method aumentarFortaleza(unaCantidad) {
    fortaleza = fortaleza + unaCantidad
  }

  method puedeRealizarRutina(unaRutina) =
    unaRutina.aparatos().all({unAparato => self.puedeUsarAparato(unAparato)}) 

  method realizarRutina(unaRutina) {
    if (self.puedeRealizarRutina(unaRutina)){
      unaRutina.realizarSesionCompleta(self)
    }
  }
}

class Resistente inherits Paciente {
   override method realizarRutina(unaRutina) {
     super(unaRutina) 
     self.aumentarFortaleza(unaRutina.cantidadDeAparatos())
   }
}

class Caprichoso inherits Paciente{
   override method puedeRealizarRutina(unaRutina) = 
   super(unaRutina) 
   and unaRutina.hayAparatoRojo()

   override method realizarRutina(unaRutina) {
    super(unaRutina)
    unaRutina.realizarSesionCompleta(self)
   }
}

class RapidaRecuperacion inherits Paciente {
  const recuperacion = disminucionRapida

  override method realizarRutina(unaRutina) {
    super(unaRutina)
    self.disminuirDolor(recuperacion.valor())
  }
}

object disminucionRapida {
  var valor = 3
  method decrementoDelDolor(nuevoValor) {
    valor = nuevoValor
  } 
  method valor() = valor 
}