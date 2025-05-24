INTERFACE zif_03_log_c363
  PUBLIC .

  METHODS:
    get_airports
      IMPORTING
                iv_airport_id     TYPE string
      RETURNING VALUE(rs_airport) TYPE /dmo/airport.

ENDINTERFACE.
