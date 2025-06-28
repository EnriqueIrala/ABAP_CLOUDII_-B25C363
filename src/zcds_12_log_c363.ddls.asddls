@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Country Code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MASTER
}

@ObjectModel.representativeKey: 'Country'
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE, 
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET ] 

@Search.searchable: true

define view entity zcds_12_log_c363
  as select from zcountry_lgl
  
  association [0..*] to zcds_11_log_c363 as _Text on _Text.Country = $projection.Country
  
{
   @Search.fuzzinessThreshold: 0.8
   @Search.defaultSearchElement: true
   @ObjectModel.text.association: '_Text'
   key land1 as Country,
   intca3 as CountryThreeLetterISOCode,
   intcn3 as CountryThreeDigitISOCode,
   intca as ContryISOCode,
   xegld as IsEuropanUnionMember,
   
   _Text
  }
