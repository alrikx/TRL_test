@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection'
@Metadata.ignorePropagatedAnnotations: true

define view entity Z56_I_CONNECTION_join
  as select from /dmo/connection as co
    join         /dmo/carrier    as ca on co.carrier_id = ca.carrier_id
{
  key co.carrier_id      as CarrierId,
  key co.connection_id   as ConnectionId,
      ca.name            as carrierName,
      co.airport_from_id as AirportFromId,
      co.airport_to_id   as AirportToId,
      co.departure_time  as DepartureTime,
      co.arrival_time    as ArrivalTime
}
