@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Interface Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ztravel_i_c363
  provider contract transactional_interface
  as projection on ztravel_r_c363
{
    key TravelUUID,
    TravelID,
    AgencyID,
    CustomerID,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    OverallStatus,
    
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LocalLastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    LastChangedAt,
    
    /* Associations */
    _Agency,
    _Currency,
    _Customer,
    _OverallStatus
  }
