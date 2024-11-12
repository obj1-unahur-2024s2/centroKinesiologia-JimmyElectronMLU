// aparatos.wlk
class Aparato {
  const property color = blanco
  method puedeSerUsado(unPaciente) 
  method serUsado(unPaciente)
  method esDeColor(unColor) = color == unColor 
  method necesitaMantenimiento() 
  method hacerMantenimiento
}
class Magneto inherits Aparato {
  var imantacion = 800
  method perderImantacionPorUso() {
    imantacion = 0.max(imantacion - 1)
  }
  override method necesitaMantenimiento() {
    return imantacion < 100
  } 

  override method hacerMantenimiento() {
    imantacion = imantacion + 500
  }

  override method puedeSerUsado(unPaciente) = true

  override method serUsado(unPaciente) {
    const porcentajeDeRecup = (unPaciente.dolor() * 10) / 100
    unPaciente.disminuirDolor(porcentajeDeRecup) //pegarle una chequeada
    self.perderImantacionPorUso()
  }
}

class Bicicleta inherits Aparato{
  var desajustesDeTornillos = 0
  var perdidasDeAceite = 0

  override method necesitaMantenimiento() {
    return desajustesDeTornillos >= 10 || perdidasDeAceite >= 5
  } 
  override method hacerMantenimiento() {
    desajustesDeTornillos = 0
    perdidasDeAceite = 0
  }

  method desgastePorUso(unPaciente) {
    if(unPaciente.dolor() > 30){
      desajustesDeTornillos = desajustesDeTornillos + 1
        if(unPaciente.edad().between(30, 50))
          perdidasDeAceite = perdidasDeAceite + 1
    }
  }

  override method puedeSerUsado(unPaciente) = 
    unPaciente.edad() > 8

  override method serUsado(unPaciente) {
      self.desgastePorUso(unPaciente)
      unPaciente.disminuirDolor(4)
      unPaciente.aumentarFortaleza(3)
  }
}

class Minitramp inherits Aparato{
  override method puedeSerUsado(unPaciente) = 
    unPaciente.dolor() < 20

  override method necesitaMantenimiento() = false

  override method hacerMantenimiento(){}

  override method serUsado(unPaciente) {
    const porcentajeEdad = (unPaciente.edad() * 10) / 100
    unPaciente.aumentarFortaleza(porcentajeEdad)
  }
}

class Rutina {  //podria ser un objeto
  const property aparatos = []

  method agregarAparatosDeRutina(unAparato) {
    aparatos.add(unAparato)}  //probablemente no la use

  method quitarAparatosDeRutina(unAparato) {
    if (aparatos.contains({p => p == unAparato})){
        aparatos.remove(unAparato)}  //probablemente no la use
  }

  method realizarSesionCompleta(unPaciente) {
    aparatos.forEach({aparato => unPaciente.usarAparato(aparato)})
  }
  method cantidadDeAparatos() = aparatos.size()

  method hayAparatoDeColor(unColor) {  // es innecesario pero lo voy a dejar xd
    const aparatosColores = aparatos.map({p => p.color()})
    return aparatosColores.contains(unColor)
  }
  method hayAparatoRojo() = self.hayAparatoDeColor(rojo)
}

object blanco {}
object rojo {}
object verde {}