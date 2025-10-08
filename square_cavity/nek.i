mesh_width = 0.0193145

[Mesh]
  type = NekRSMesh
  volume = true
  order=FIRST
[]

[Problem]
  type = NekRSProblem
  casename = 'cavity'
  [FieldTransfers]
    [T]
      type = NekFieldVariable
      direction = from_nek
      field = temperature
    []
    [P]
      type = NekFieldVariable
      direction = from_nek
      field = pressure
    []
    [vel_x]
      type = NekFieldVariable
      direction = from_nek
      field = velocity_x
    []
    [vel_y]
      type = NekFieldVariable
      direction = from_nek
      field = velocity_y
    []
    [vel_z]
      type = NekFieldVariable
      direction = from_nek
      field = velocity_z
    []
  []
[]

[Executioner]
  type = Transient

  [TimeStepper]
    type = NekTimeStepper
  []
[]


[Postprocessors]
  [heat_flux]
    type = NekHeatFluxIntegral
    boundary = '1'
  []
  [nusselt]
    type = ParsedPostprocessor
    expression = '-heat_flux / width_y'
    pp_names = 'heat_flux'
    constant_names = 'width_y'
    constant_expressions = '${mesh_width}'
  []
[]

[Outputs]
  csv=true
  execute_on=final
[]

