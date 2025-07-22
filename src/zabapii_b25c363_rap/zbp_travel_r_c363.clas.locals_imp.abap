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

    result = VALUE #( for travel in travels (
                                    %tky = travel-%tky
                                    %field-BookingFee = cond #( when travel-OverallStatus = travel_status-accepted
                                                                then if_abap_behv=>fc-f-read_only
                                                                else if_abap_behv=>fc-f-unrestricted )
                                    %action-acceptTravel = cond #( when travel-OverallStatus = travel_status-accepted
                                                                   then if_abap_behv=>fc-o-disabled
                                                                   else if_abap_behv=>fc-o-enabled )
                                    %action-rejectTravel = cond #( when travel-OverallStatus = travel_status-rejected
                                                                   then if_abap_behv=>fc-o-disabled
                                                                   else if_abap_behv=>fc-o-enabled )
                                    %action-deductDiscount = cond #( when travel-OverallStatus = travel_status-accepted
                                                                     then if_abap_behv=>fc-o-disabled
                                                                     else if_abap_behv=>fc-o-enabled )
    ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
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
  ENDMETHOD.

  METHOD reCalcTotalPrice.
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
  ENDMETHOD.

  METHOD setStatusToOpen.
  ENDMETHOD.

  METHOD setTravelNumber.
  ENDMETHOD.

  METHOD validateAgency.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateDateRange.
  ENDMETHOD.

ENDCLASS.
