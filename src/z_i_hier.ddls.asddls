@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'hoer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_I_HIER as select from zhier
    association[1..*] to Z_I_HIER as _Parent
    on $projection.Parent = _Parent.Id
{
    key id as Id,
    parent as Parent,
    value as Value,
    text as Text,
    _Parent
}
