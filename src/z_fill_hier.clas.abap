CLASS z_fill_hier DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z_FILL_HIER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lt_hier TYPE TABLE OF zhier.

    lt_hier = VALUE #( ( id = 1             text = 'A' value = 100 )
                       ( id = 2 parent = 1  text = 'A1' value = 100 )
                       ( id = 3 parent = 1  text = 'A2' value = 100 )
                       ( id = 4 parent = 2  text = 'B1' value = 100 )
                       ( id = 5 parent = 3  text = 'C' value = 100 )
                       ( id = 6 parent = 4  text = 'B2' value = 100 ) ).
    delete from zhier.
    INSERT zhier FROM TABLE @lt_hier.

  ENDMETHOD.
ENDCLASS.
