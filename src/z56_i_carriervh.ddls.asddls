@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH For Carrier'
@Metadata.ignorePropagatedAnnotations: true

define view entity Z56_I_CarrierVH
  as select from /dmo/carrier
  association[0..*] to /dmo/connection as _connections on $projection.CarrierID = _connections.carrier_id
{
      @UI.lineItem: [{position: 10 }]
  key carrier_id as CarrierID,
      @UI.lineItem: [{position: 20 }]
      name       as Name,
      cast('100000' as abap.int8 ) as INT8,
      _connections
}
