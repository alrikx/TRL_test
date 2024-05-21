@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection 2'
define root view entity Z56_I_CONN2
  as select from z56aconn
  //composition of target_data_source_name as _association_name
{
  key uuid                  as Uuid,
      carrier_id            as CarrierId,
      connection_id         as ConnectionId,
      airport_from_id       as AirportFromId,
      city_from             as CityFrom,
      country_from          as CountryFrom,
      airport_to_id         as AirportToId,
      city_to               as CityTo,
      country_to            as CountryTo,
      local_created_by      as LocalCreatedBy,
      local_created_at      as LocalCreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt
      //_association_name // Make association public
}
