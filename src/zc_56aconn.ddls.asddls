@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_56ACONN'
@Search.searchable: true
define root view entity ZC_56ACONN
  provider contract transactional_query
  as projection on ZR_56ACONN
{
  key UUID,
      @Consumption.valueHelpDefinition: [{  entity: {name: 'Z56_I_CARRIERVH', element: 'CarrierID' }} ]
      @Search.defaultSearchElement: true
      CarrierID,
      ConnectionID,
      @Search.defaultSearchElement: true
      AirportFromID,
      CityFrom,
      CountryFrom,
      @Search.defaultSearchElement: true
      AirportToID,
      CityTo,
      @Consumption.valueHelpDefinition: [{  entity: {name: 'I_CountryVH', element: 'Country' }} ]
      CountryTo,
      LocalLastChangedAt

}
