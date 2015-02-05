module Monitoring.Shinken.Configuration where

import           Data.Map.Strict

type Configuration = [Object]

data Object = Arbiter Attributes
            | Broker Attributes
            | Command Attributes
            | Contact Attributes
            | ContactGroup Attributes
            | DiscoveryRule Attributes
            | DiscoveryRun Attributes
            | Host Attributes
            | HostGroup Attributes
            | Module Attributes
            | NotificationWay Attributes
            | Poller Attributes
            | Reactionner Attributes
            | Realm Attributes
            | Receiver Attributes
            | Scheduler Attributes
            | Service Attributes
            | TimePeriod Attributes
            deriving (Show)

type Attributes = Map String String

type Attribute = (String, String)

parseObjectType :: String -> Attributes -> Maybe Object
parseObjectType "arbiter"        attribute = Just (Arbiter         attribute)
parseObjectType "broker"         attribute = Just (Broker          attribute)
parseObjectType "command"        attribute = Just (Command         attribute)
parseObjectType "contact"        attribute = Just (Contact         attribute)
parseObjectType "contactgroup"   attribute = Just (ContactGroup    attribute)
parseObjectType "discoveryrule"  attribute = Just (DiscoveryRule   attribute)
parseObjectType "discoveryrun"   attribute = Just (DiscoveryRun    attribute)
parseObjectType "host"           attribute = Just (Host            attribute)
parseObjectType "hostgroup"      attribute = Just (HostGroup       attribute)
parseObjectType "module"         attribute = Just (Module          attribute)
parseObjectType "notificationway"attribute = Just (NotificationWay attribute)
parseObjectType "poller"         attribute = Just (Poller          attribute)
parseObjectType "reactionner"    attribute = Just (Reactionner     attribute)
parseObjectType "realm"          attribute = Just (Realm           attribute)
parseObjectType "receiver"       attribute = Just (Receiver        attribute)
parseObjectType "scheduler"      attribute = Just (Scheduler       attribute)
parseObjectType "service"        attribute = Just (Service         attribute)
parseObjectType "timeperiod"     attribute = Just (TimePeriod      attribute)
parseObjectType _                attribute = Nothing
