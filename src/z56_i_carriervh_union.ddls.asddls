@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH For Carrier'
@Metadata.ignorePropagatedAnnotations: true

define view entity Z56_I_CARRIERVH_UNION
  as select from /dmo/carrier
{
      @UI.lineItem: [{position: 10 }]
  key carrier_id as CarrierID,
      @UI.lineItem: [{position: 20 }]
      name       as Name
}
union all 
select from /dmo/carrier
{
  key carrier_id as CarrierID,
      name       as Name
}
