@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help definition'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MASTER
}

@ObjectModel.representativeKey: 'Country'
@ObjectModel.dataCategory: #VALUE_HELP

@Search.searchable: true

@Consumption.ranked: true

define view entity zcds_13_log_c363
  as select from zcds_12_log_c363
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key Country,
  
      @Search.defaultSearchElement: true
      @Semantics.text: true
      @Search.ranking: #LOW    
      _Text[ 1:Languaje = $session.system_language ].CountryName as Description,
      
      @Search.defaultSearchElement: true
      CountryThreeLetterISOCode,
      @Search.defaultSearchElement: true
      CountryThreeDigitISOCode,
  
      /* Associations */
      _Text
}
