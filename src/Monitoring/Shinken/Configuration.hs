module Monitoring.Shinken.Configuration where

type Configuration = [ConfObject]

data ConfObject = Arbiter {objectBlock :: String}
                | Broker {objectBlock :: String}
                | Command {objectBlock :: String}
                | Contact {objectBlock :: String}
                | ContactGroup {objectBlock :: String}
                | DiscoveryRule {objectBlock :: String}
                | DiscoveryRun {objectBlock :: String}
                | Host {objectBlock :: String}
                | HostGroup {objectBlock :: String}
                | Module {objectBlock :: String}
                | NotificationWay {objectBlock :: String}
                | Poller {objectBlock :: String}
                | Reactionner {objectBlock :: String}
                | Realm {objectBlock :: String}
                | Receiver {objectBlock :: String}
                | Scheduler {objectBlock :: String}
                | Service {objectBlock :: String}
                | TimePeriod {objectBlock :: String}
                deriving (Show)

type Attribute = (String, String)

parseObjectType :: String -> String -> ConfObject
parseObjectType "host" = Host
parseObjectType "hostgroup" = HostGroup
parseObjectType _ = Host
