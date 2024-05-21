CLASS zcl_runner_test DEFINITION
  PUBLIC
  INHERITING FROM zcl_base_runner
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: logic REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RUNNER_TEST IMPLEMENTATION.


  METHOD logic.
    write( 123 ).

    SELECT * FROM /dmo/carrier INTO TABLE @DATA(lt_carrier).
    write( name = 'MyName'
           data = lt_carrier ).

    DATA lv_test TYPE TABLE OF /dmo/airport.

    lv_test = VALUE #( airport_id = 'DRS'
                       city       = 'Dresden'
                       country    = 'DE'
                       ( )
                       ( )
                       ( ) ).
    write( lv_test ).
    write( name = 'MyName'
           data = lv_test ).

    DATA lv_test2 TYPE /dmo/airport.

    lv_test2-airport_id = 'SAP'.
    lv_test2-city       = 'CTY'.

    write( lv_test2 ).
    write( name = 'STR Test'
           data = lv_test2 ).
  ENDMETHOD.
ENDCLASS.
