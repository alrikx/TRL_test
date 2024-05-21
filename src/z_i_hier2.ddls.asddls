
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Hierarchie 2'

define hierarchy Z_I_HIER2
  as parent child hierarchy (
    source Z_I_HIER
    child to parent association _Parent
    start where Parent = 0
    siblings order by Value
  )
{
    Id,
    Text,
    Value
}
