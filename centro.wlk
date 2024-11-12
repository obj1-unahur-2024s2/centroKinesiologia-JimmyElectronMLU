object centro {
  const property pacientes = #{}
  const property aparatos = [] 
  var visitasDelTecnico = 0

  method agregarPacientes(unaLista) {
    aparatos.addAll(unaLista)
  }
  method agregarAparatos(unaLista) {
    aparatos.addAll(unaLista)
  }

  method coloresDeAparatos() {
    const coloresAparatosNoRepetidos = aparatos.map({p => p.color()}).asSet()
    return coloresAparatosNoRepetidos
  }

  method pacientesMenoresDe(unaEdad){
    return pacientes.filter({pacientes => pacientes.edad() < unaEdad})
  }

  method noPuedenRealizarLaSesion(unaRutina) {
    return pacientes.count({paciente => !paciente.puedeRealizarRutina(unaRutina)})
  }

  ////////////////////////////////////////////////////////////////////

  method estaEnOptimasCondiciones() = aparatos.all({p => !p.necesitaMantenimiento()}) 

  method losQueNecesitanMantenimiento() {
    const lista = aparatos.filter({p => p.necesitaMantenimiento()})
    return lista
  }

  method estaComplicado() {
    return self.losQueNecesitanMantenimiento().size() >= (aparatos.size()/2)
  }

  method visitasDelTecnico() = visitasDelTecnico

  method llamarTecnico(unTecnico) {
    visitasDelTecnico = visitasDelTecnico + 1
    unTecnico.realizarMantenimientoA(self)
  } 

  method algunoNecesitaMantenimiento() =
    aparatos.any({aparato => aparato.necesitaMantenimiento()})
  
  method hacerMantenimiento() {
    self.losQueNecesitanMantenimiento().forEach({a => a.hacerMantenimiento()})
  }
}

object tecnico {
  method realizarMantenimientoA(unLugar) {
    unLugar.hacerMantenimiento()
  }
}