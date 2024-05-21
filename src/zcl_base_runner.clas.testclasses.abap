*"* use this source file for your ABAP unit test classes
CLASS ltcl_base_runner DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      convertuuid FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_base_runner IMPLEMENTATION.

  METHOD convertuuid.
    DATA(lv_result) = zcl_base_runner=>convertuuid( str = '7cd44fff-036a-4155-b0d2-f5a4dfbcee92' ).

    cl_abap_unit_assert=>assert_equals( exp = '7CD44FFF036A4155B0D2F5A4DFBCEE92' act = lv_result level = if_abap_unit_constant=>severity-low ).

  ENDMETHOD.

ENDCLASS.
