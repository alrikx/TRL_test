@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Test2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z56_I_CARRIERVH2 as select from Z56_I_CarrierVH
{
    key CarrierID,
    Name,
    cast( INT8 as abap.int2 ) as test,
    /* Associations */
    _connections
}
