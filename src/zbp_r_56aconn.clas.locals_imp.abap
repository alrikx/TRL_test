CLASS lhc_connection DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Connection
        RESULT result,
      switchAirPorts FOR MODIFY
        IMPORTING keys FOR ACTION Connection~switchAirPorts RESULT result,
      checkUnique FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connection~checkUnique,
      get_instance_features FOR INSTANCE FEATURES
            IMPORTING keys REQUEST requested_features FOR Connection RESULT result.
ENDCLASS.

CLASS lhc_connection IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD switchAirPorts.

    READ ENTITIES OF zr_56aconn IN LOCAL MODE
    ENTITY Connection
    ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_connection).

    LOOP AT lt_connection ASSIGNING FIELD-SYMBOL(<fs_connection>).

      DATA(ls_tmp_connection) = <fs_connection>.

      <fs_connection>-AirportFromID =  <fs_connection>-AirportToID.
      <fs_connection>-CityFrom =  <fs_connection>-CityTo.
      <fs_connection>-CountryFrom = <fs_connection>-CountryTo.


      <fs_connection>-AirportToID = ls_tmp_connection-AirportFromID.
      <fs_connection>-CityTo = ls_tmp_connection-CityFrom.
      <fs_connection>-CountryTo = ls_tmp_connection-CountryFrom.

    ENDLOOP.

    MODIFY ENTITIES OF zr_56aconn IN LOCAL MODE
    ENTITY Connection
    UPDATE FIELDS ( AirportFromID AirportToID CityFrom CityTo CountryFrom CountryTo ) WITH CORRESPONDING #( lt_connection ).

    result = value #( FOR ls_connection IN lt_connection ( %tky = ls_connection-%tky %param = ls_connection ) ).

  ENDMETHOD.

  METHOD checkUnique.

    READ ENTITIES OF zr_56aconn IN LOCAL MODE
    ENTITY Connection
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_connection).


    LOOP AT lt_connection ASSIGNING FIELD-SYMBOL(<fs_connection>) .
      SELECT count( * )
      FROM z56aconn
      WHERE carrier_id = @<fs_connection>-CarrierID
        AND connection_id = @<fs_connection>-ConnectionID
        AND uuid <> @<fs_connection>-uuid
      into @DATA(ls_result).

      if ls_result > 0.
        append value #( %tky = <fs_connection>-%tky ) to failed-connection.
        append value #( %tky = <fs_connection>-%tky
                        %element-connectionid   = if_abap_behv=>mk-on

                        %msg = new_message_with_text(
                         severity = if_abap_behv_message=>severity-warning
                         Text = |This Connection already exists.| ) ) to reported-connection.
      endif.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zr_56aconn IN LOCAL MODE
    ENTITY Connection
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_connection).

    loop at lt_connection ASSIGNING FIELD-SYMBOL(<fs_connection>).
        if <fs_connection>-%is_draft = if_abap_behv=>mk-on.
             append value #( %tky = <fs_connection>-%tky %action-switchairports = if_abap_behv=>fc-o-disabled ) to result.
        else.
             append value #( %tky = <fs_connection>-%tky %action-switchairports = if_abap_behv=>fc-o-enabled ) to result.
        endif.


    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
