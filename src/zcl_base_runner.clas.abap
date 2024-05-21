"! <p class="shorttext synchronized" lang="en">Base Runner</p>
"! Improved class runner with enhanced logging capabilities
CLASS zcl_base_runner DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    "! <p class="shorttext synchronized" lang="en">This method implements your logic</p>
    "! You can use { @link .METH:write } with enhanced capabilities or the { @link .DATA:out }->write( ) for plain logging.
    "! @raising cx_root | <p class="shorttext synchronized" lang="en">any exception not caught, will be handled in the runner.</p>
    METHODS logic ABSTRACT
      RAISING cx_root.

    CLASS-METHODS convertuuid
      IMPORTING
                str            TYPE string
      RETURNING VALUE(rv_uuid) TYPE sysuuid_c32.

  PROTECTED SECTION.

    DATA out TYPE REF TO if_oo_adt_classrun_out.

    "! <p class="shorttext synchronized" lang="en">wrapper for out->write( )</p>
    "! this enhances the default function by writing a timestamp.
    "! this method should be used in {@link .METH:logic }
    "! @parameter data | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter name | <p class="shorttext synchronized" lang="en"></p>
    METHODS write
      IMPORTING
        data TYPE any
        name TYPE string OPTIONAL.

  PRIVATE SECTION.

    "! <p class="shorttext synchronized" lang="en">determine the current timestamp and returns as string</p>
    "! <ul><li>in users timezone</li><li>in users prefered format</li></ul>
    "! @parameter rv_dateandtime | <p class="shorttext synchronized" lang="en"></p>
    CLASS-METHODS getCurrentDateandTimeFormatted
      RETURNING VALUE(rv_dateandtime) TYPE string.

    "! <p class="shorttext synchronized" lang="en">draws a horizontal line on the console</p>
    "!
    "! @parameter out | <p class="shorttext synchronized" lang="en"></p>
    CLASS-METHODS horizontalLine
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_BASE_RUNNER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    me->out = out.

    horizontalline( out ).

    TRY.

        out->write( |Start on { xco_cp=>current->tenant( )->get_url( io_type = xco_cp_tenant=>url_type->ui )->get_host(  ) } runner { cl_abap_classdescr=>get_class_name( me ) } by { cl_abap_context_info=>get_user_formatted_name( ) }| &&
        | at { getcurrentdateandtimeformatted(  ) }| ).

      CATCH cx_abap_context_info_error INTO DATA(lc_context_error).
        "handle exception
        out->write( 'Error occured in determine current user:' ).
        out->write( lc_context_error->get_text(  ) ).
    ENDTRY.

    TRY.
        me->logic( ).

      CATCH cx_root INTO DATA(lc_error).
        "handle exception
        write( 'Error occured in executing the logic:' ).
        write( lc_error->get_text(  ) ).
        DATA(previous) = lc_error->previous.
        IF lc_error->previous IS BOUND.
          write( name = 'Previous' data = lc_error->previous->get_text(  ) ).
        ENDIF.


    ENDTRY.

    out->write( |Done at { getcurrentdateandtimeformatted(  ) }| ).

    horizontalline( out ).

  ENDMETHOD.


  METHOD convertuuid.
    DATA(lo_uuid) = xco_cp_uuid=>format->c36->to_uuid( str ).
    rv_uuid = xco_cp_uuid=>format->c32->from_uuid( lo_uuid ).
  ENDMETHOD.


  METHOD horizontalline.
    out->write( repeat( val = '-' occ = 120 ) ).
  ENDMETHOD.


  METHOD getcurrentdateandtimeformatted.
    DATA tsp TYPE tzntstmps.
    DATA(lo_unix_timestamp) = xco_cp=>sy->unix_timestamp( ).
    DATA(lo_moment) = lo_unix_timestamp->get_moment( xco_cp_time=>time_zone->user ).
    tsp = lo_moment->as( xco_cp_time=>format->abap )->value.
    rv_dateandtime = |{ tsp TIMESTAMP = USER }|.
  ENDMETHOD.


  METHOD write.

    DATA(descr_ref) = cl_abap_typedescr=>describe_by_data( data ).

    IF name IS INITIAL.

      IF descr_ref IS INSTANCE OF cl_abap_elemdescr.
        out->write( data = |{ getcurrentdateandtimeformatted(  ) }: { data }| ).
      ELSE.
        out->write( data = |{ getcurrentdateandtimeformatted(  ) }:| ).
        out->write( data = data ).
      ENDIF.

    ELSE.
      IF descr_ref IS INSTANCE OF cl_abap_elemdescr.
        out->write( data = |{ getcurrentdateandtimeformatted(  ) }: { Name }:{ data }| ).
      ELSE.
        out->write( data = |{ getcurrentdateandtimeformatted(  ) }: { Name }:| ).
        out->write( data = data ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
