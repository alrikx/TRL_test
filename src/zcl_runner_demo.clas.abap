CLASS zcl_runner_demo DEFINITION
  PUBLIC
  INHERITING FROM zcl_base_runner
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: logic REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RUNNER_DEMO IMPLEMENTATION.


  METHOD logic.
    DATA ls_airport type /dmo/airport.

    write( `Hello World this is changed by Git` ).

    ls_airport = value #( airport_id = 'SAP' city = 'Dokkerland' ).

    write( ls_airport ).

    write( name = 'Info about airport' data = ls_airport ).

  ENDMETHOD.
ENDCLASS.
