CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF travel_status,
        open     TYPE c LENGTH 1 VALUE 'O', " Open
        accepted TYPE c LENGTH 1 VALUE 'A', " Accepted
        rejected TYPE c LENGTH 1 VALUE 'X', " Rejected
      END OF travel_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS deductDiscount FOR MODIFY
      IMPORTING keys FOR ACTION Travel~deductDiscount RESULT result.

    METHODS reCalcTotalPrice FOR MODIFY
      IMPORTING keys FOR ACTION Travel~reCalcTotalPrice.

    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~calculateTotalPrice.

    METHODS setStatusToOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~setStatusToOpen.

    METHODS setTravelNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~setTravelNumber.

    METHODS validateAgency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateAgency.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomer.

    METHODS validateDateRange FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDateRange.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    FIELDS ( OverallStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels)
    FAILED failed.

    result = VALUE #( FOR travel IN travels (
                                    %tky = travel-%tky
                                    %field-BookingFee = COND #( WHEN travel-OverallStatus = travel_status-accepted
                                                                THEN if_abap_behv=>fc-f-read_only
                                                                ELSE if_abap_behv=>fc-f-unrestricted )
                                    %action-acceptTravel = COND #( WHEN travel-OverallStatus = travel_status-accepted
                                                                   THEN if_abap_behv=>fc-o-disabled
                                                                   ELSE if_abap_behv=>fc-o-enabled )
                                    %action-rejectTravel = COND #( WHEN travel-OverallStatus = travel_status-rejected
                                                                   THEN if_abap_behv=>fc-o-disabled
                                                                   ELSE if_abap_behv=>fc-o-enabled )
                                    %action-deductDiscount = COND #( WHEN travel-OverallStatus = travel_status-accepted
                                                                     THEN if_abap_behv=>fc-o-disabled
                                                                     ELSE if_abap_behv=>fc-o-enabled )
    ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.

    DATA: update_requested TYPE abap_bool,
          update_granted   TYPE abap_bool,
          delete_requested TYPE abap_bool,
          delete_granted   TYPE abap_bool.

    READ ENTITIES OF ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    FIELDS ( AgencyID )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels)
    FAILED failed.

    update_requested = COND #( WHEN requested_authorizations-%update = if_abap_behv=>mk-on
                                 OR requested_authorizations-%action-Edit = if_abap_behv=>mk-on
                               THEN abap_true
                               ELSE abap_false ).

    delete_requested = COND #( WHEN requested_authorizations-%delete = if_abap_behv=>mk-on
                               THEN abap_true
                               ELSE abap_false ).

    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).

    LOOP AT travels INTO DATA(travel).

      IF travel-AgencyID IS NOT INITIAL.

        IF update_requested EQ abap_true.

          IF lv_technical_name EQ 'CB9980007474' AND travel-AgencyID NE '70021'.

            update_granted = abap_true.

          ELSE.

            update_granted = abap_false.

            APPEND VALUE #( %tky = travel-%tky
                            %msg = NEW /dmo/cm_flight_messages( textid = /dmo/cm_flight_messages=>not_authorized_for_agencyid
                                                                agency_id = travel-AgencyID
                                                                severity = if_abap_behv_message=>severity-error )
                            %element-AgencyID = if_abap_behv=>mk-on ) TO reported-travel.

          ENDIF.

        ENDIF.

        IF delete_requested EQ abap_true.

          IF lv_technical_name EQ 'CB9980007474' AND travel-AgencyID NE '70021'.

            delete_granted = abap_true.

          ELSE.

            delete_granted = abap_false.

            APPEND VALUE #( %tky = travel-%tky
                            %msg = NEW /dmo/cm_flight_messages( textid    = /dmo/cm_flight_messages=>not_authorized_for_agencyid
                                                                agency_id = travel-AgencyID
                                                                severity  = if_abap_behv_message=>severity-error )
                            %element-AgencyID = if_abap_behv=>mk-on ) TO reported-travel.

          ENDIF.

        ENDIF.

      ELSE.

        IF lv_technical_name EQ 'CB9980007474'.

          update_granted = abap_true.

        ENDIF.

        IF update_granted = abap_false.

          APPEND VALUE #( %tky = travel-%tky
                          %msg = NEW /dmo/cm_flight_messages( textid    = /dmo/cm_flight_messages=>not_authorized
                                                              severity  = if_abap_behv_message=>severity-error )
                          %element-AgencyID = if_abap_behv=>mk-on ) TO reported-travel.

        ENDIF.

      ENDIF.

      APPEND VALUE #( LET upd_auth = COND #( WHEN update_granted EQ abap_true
                                             THEN if_abap_behv=>auth-allowed
                                             ELSE if_abap_behv=>auth-unauthorized )
                          del_auth = COND #( WHEN delete_granted EQ abap_true
                                             THEN if_abap_behv=>auth-allowed
                                             ELSE if_abap_behv=>auth-unauthorized )

                       IN
                       %tky = travel-%tky
                       %update = upd_auth
                       %action-Edit = upd_auth
                       %delete = del_auth ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_global_authorizations.

    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name( ).

    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.

      IF lv_technical_name EQ 'CB9980007474'.

        result-%create = if_abap_behv=>auth-allowed .

      ELSE.

        result-%create = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg = NEW /dmo/cm_flight_messages( textid    = /dmo/cm_flight_messages=>not_authorized
                                                            severity  = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) TO reported-travel.

      ENDIF.

    ENDIF.

    IF requested_authorizations-%update EQ if_abap_behv=>mk-on OR
       requested_authorizations-%action-Edit EQ if_abap_behv=>mk-on.

      IF lv_technical_name EQ 'CB9980007474'.

        result-%update = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.

      ELSE.

        result-%update = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg = NEW /dmo/cm_flight_messages( textid    = /dmo/cm_flight_messages=>not_authorized
                                                            severity  = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) TO reported-travel.

      ENDIF.

    ENDIF.

    IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.

      IF lv_technical_name EQ 'CB9980007474'.

        result-%delete = if_abap_behv=>auth-allowed .

      ELSE.

        result-%delete = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg = NEW /dmo/cm_flight_messages( textid    = /dmo/cm_flight_messages=>not_authorized
                                                            severity  = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) TO reported-travel.

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD acceptTravel.

    "EML - Entity Manipulation Languaje
    MODIFY ENTITIES OF ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    UPDATE
    FIELDS ( OverallStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OverallStatus = travel_status-accepted ) ).

    READ ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    RESUlT = VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                              %param = travel ) ).

  ENDMETHOD.

  METHOD deductDiscount.

    DATA: travels_for_update TYPE TABLE FOR UPDATE ztravel_r_c363.

    DATA(keys_valid_discount) = keys.

    LOOP AT keys_valid_discount ASSIGNING FIELD-SYMBOL(<fs_key_valid_discount>)
       WHERE %param-discount_percent IS INITIAL
          OR %param-discount_percent > 100
          OR %param-discount_percent <= 0.

      APPEND VALUE #( %tky = <fs_key_valid_discount>-%tky ) TO failed-travel.

      APPEND VALUE #( %tky = <fs_key_valid_discount>-%tky
                      %msg = NEW /dmo/cm_flight_messages( textid = /dmo/cm_flight_messages=>discount_invalid
                                                          severity = if_abap_behv_message=>severity-error )
                      %op-%action-deductDiscount = if_abap_behv=>mk-on ) TO reported-travel.

      DATA(lv_error) = abap_true.

    ENDLOOP.

    CHECK lv_error NE abap_true.

    READ ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    FIELDS ( BookingFee )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    DATA percentage TYPE decfloat16.

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<fs_travel>).

      DATA(discount_percentage) = keys[ KEY id %tky = <fs_travel>-%tky ]-%param-discount_percent.
      percentage = discount_percentage / 100.
      DATA(reduced_fee) = <fs_travel>-BookingFee * ( 1 - percentage ).

      APPEND VALUE #( %tky = <fs_travel>-%tky
                      BookingFee = reduced_fee ) TO travels_for_update.

    ENDLOOP.

    MODIFY ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
           ENTITY Travel
           UPDATE
           FIELDS ( BookingFee )
           WITH travels_for_update.

    READ ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
          ENTITY Travel
          ALL FIELDS
          WITH CORRESPONDING #( keys )
          RESULT DATA(travels_with_dicount).

    result = VALUE #( FOR travel IN travels_with_dicount ( %tky   = travel-%tky
                                                           %param = travel ) ).

  ENDMETHOD.

  METHOD reCalcTotalPrice.

    READ ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    FIELDS ( BookingFee CurrencyCode )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    DELETE travels WHERE CurrencyCode IS INITIAL.

    LOOP AT travels ASSIGNING FIELD-SYMBOL(<fs_travel>).

      CLEAR <fs_travel>-TotalPrice.

      SELECT SINGLE FROM /dmo/booking
             FIELDS flight_price
             WHERE currency_code EQ @<fs_travel>-CurrencyCode
             INTO @DATA(lv_flight_price).

      IF sy-subrc = 0.

        <fs_travel>-TotalPrice += lv_flight_price.

      ENDIF.

      <fs_travel>-TotalPrice += <fs_travel>-BookingFee.

    ENDLOOP.

    MODIFY ENTITIES OF ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    UPDATE
    FIELDS ( TotalPrice )
    WITH CORRESPONDING #( travels ).

  ENDMETHOD.

  METHOD rejectTravel.

    "EML - Entity Manipulation Languaje
    MODIFY ENTITIES OF ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    UPDATE
    FIELDS ( OverallStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OverallStatus = travel_status-rejected ) ).

    READ ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    RESUlt = VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                              %param = travel ) ).

  ENDMETHOD.

  METHOD calculateTotalPrice.

    MODIFY ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
             ENTITY Travel
             EXECUTE reCalcTotalPrice
             FROM CORRESPONDING #( keys ).

  ENDMETHOD.

  METHOD setStatusToOpen.

    READ ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
          ENTITY Travel
          FIELDS ( OverallStatus )
          WITH CORRESPONDING #( keys )
          RESULT DATA(travels).

    DELETE travels WHERE OverallStatus IS NOT INITIAL.

    CHECK travels IS NOT INITIAL.

    MODIFY ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
           ENTITY Travel
           UPDATE FIELDS ( OverallStatus )
           WITH VALUE #( FOR travel IN travels ( %tky          = travel-%tky
                                                 OverallStatus = travel_status-open ) ).

  ENDMETHOD.

  METHOD setTravelNumber.

    READ ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
      ENTITY Travel
      FIELDS ( TravelID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    DELETE travels WHERE TravelID IS NOT INITIAL.

    CHECK travels IS NOT INITIAL.

    SELECT SINGLE FROM ztravel_c363_a
    FIELDS MAX( travel_id )
    INTO @DATA(lv_max_travel_id).

    MODIFY ENTITIES OF Ztravel_r_c363 IN LOCAL MODE
    ENTITY Travel
    UPDATE FIELDS ( TravelID )
    WITH VALUE #( FOR travel IN travels INDEX INTO i
                             ( %tky = travel-%tky
                               TravelID = lv_max_travel_id + 1 ) ).


  ENDMETHOD.

  METHOD validateAgency.

    READ ENTITIES OF ztravel_r_c363 IN LOCAL MODE
      ENTITY Travel
      FIELDS ( AgencyID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    DATA agencies TYPE SORTED TABLE OF /dmo/agency WITH UNIQUE KEY client agency_id.

    agencies = CORRESPONDING #( travels DISCARDING DUPLICATES MAPPING agency_id = AgencyID EXCEPT * ).
    DELETE agencies WHERE agency_id IS INITIAL.

    IF agencies IS NOT INITIAL.

      SELECT FROM /dmo/agency AS ddbb
               INNER JOIN @agencies AS http_req ON ddbb~agency_id EQ http_req~agency_id
               FIELDS ddbb~agency_id
               INTO TABLE @DATA(valid_agencies).

    ENDIF.

    LOOP AT travels INTO DATA(travel).

      APPEND VALUE #( %tky = travel-%tky
                      %state_area = 'VALIDATE_AGENCY' ) TO reported-travel.

      IF travel-AgencyID IS INITIAL.

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.

        APPEND VALUE #( %tky        = travel-%tky
                        %state_area = 'VALIDATE_AGENCY'
                        %msg = NEW /dmo/cm_flight_messages( textid   = /dmo/cm_flight_messages=>enter_agency_id
                                                            severity = if_abap_behv_message=>severity-error )
                        %element-AgencyID = if_abap_behv=>mk-on
                        ) TO reported-travel.

      ELSEIF travel-AgencyID IS NOT INITIAL AND NOT line_exists( valid_agencies[ agency_id = travel-AgencyID ] ).

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.

        APPEND VALUE #( %tky = travel-%tky
                        %state_area = 'VALIDATE_AGENCY'
                        %msg = NEW /dmo/cm_flight_messages( textid   = /dmo/cm_flight_messages=>agency_unkown
                                                            agency_id = travel-AgencyID
                                                            severity = if_abap_behv_message=>severity-error )
                        %element-AgencyID = if_abap_behv=>mk-on
                        ) TO reported-travel.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateDateRange.
  ENDMETHOD.

ENDCLASS.
