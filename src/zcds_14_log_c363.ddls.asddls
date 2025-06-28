@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Scalar Funtions - Use'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcds_14_log_c363
  as select from /dmo/carrier
{
  key carrier_id                                        as CarrierId,
      name                                              as Name,
      currency_code                                     as CurrencyCode,
      zsf_vat_by_airline_c363( pAirline => carrier_id ) as VAT
}
