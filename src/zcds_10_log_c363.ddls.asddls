@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consume TF (AMDP) from CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_10_log_c363

  with parameters
    pCountryCode : land1

  as select from /dmo/travel as Travel

  //association [0..*] to zcds_tf_01_log_c363 as _BookingCustomer on _BookingCustomer.TravelId = $projection.TravelId
  inner join zcds_tf_01_log_c363( pClient: $session.client, pCountryCode: $parameters.pCountryCode) as BookingCustomer on BookingCustomer.TravelId = Travel.travel_id

{
  key Travel.travel_id                                        as TravelId,
      Travel.agency_id                                        as AgencyId,
//      _BookingCustomer(pCountryCode: $parameters.pCountryCode,
//                       pClient: $session.client ).customer_id as CustomerId,
      BookingCustomer.customer_id as CustomerId,
      Travel.begin_date                                       as BeginDate,
      Travel.end_date                                         as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.booking_fee                                      as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Travel.total_price                                      as TotalPrice,
      Travel.currency_code                                    as CurrencyCode,
      Travel.description                                      as Description,
      Travel.status                                           as Status,
      BookingCustomer.last_name                                         as LastName
//      _BookingCustomer(pCountryCode: $parameters.pCountryCode,
//                       pClient: $session.client ).last_name   as LastName

}
