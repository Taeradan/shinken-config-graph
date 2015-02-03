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

parseObjectType :: String -> Attributes -> Object
parseObjectType "host" = Host
parseObjectType "hostgroup" = HostGroup
parseObjectType _ = Host
