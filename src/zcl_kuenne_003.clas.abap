CLASS zcl_kuenne_003 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_KUENNE_003 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'this is a demo output' ).

    select CarrierID, Name, \_connections-carrier_id
    from Z56_I_CARRIERVH
    INTO table @Data(lt_test).

  ENDMETHOD.
ENDCLASS.
