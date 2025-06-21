CLASS zcl_amdp_tf_log_c363 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES: if_amdp_marker_hdb.

  class-METHODS: get_cust_bookings for TABLE FUNCTION zcds_tf_01_log_c363.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_tf_log_c363 IMPLEMENTATION.

  METHOD get_cust_bookings BY DATABASE FUNCTION FOR HDB
                           LANGUAGE SQLSCRIPT
                           OPTIONS READ-ONLY
                           USING /dmo/booking /dmo/customer.
 RETURN SELECT    b.client,
                  b.travel_id as TravelId,
                  b.booking_id,
                  c.customer_id,
                  c.first_name,
                  c.last_name,
                  b.booking_date,
                  b.carrier_id,
                  b.connection_id,
                  b.flight_date,
                  b.flight_price,
                  b.currency_code
                  from "/DMO/BOOKING" as b
                  inner join "/DMO/CUSTOMER" as c
                             on --b.client = c.client
                             --and
                             b.customer_id = c.customer_id
                  where c.client = :pClient
                    and c.country_code = :pCountryCode
                   --where c.country_code = :pCountryCode
                  order by b.booking_date desc;
  ENDMETHOD.

ENDCLASS.
