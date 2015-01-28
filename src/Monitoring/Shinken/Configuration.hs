module Monitoring.Shinken.Configuration where

type Configuration = [ConfObject]

data ConfObject = Arbiter
                | Broker
                | Command
                | Contact
                | ContactGroup
                | DiscoveryRule
                | DiscoveryRun
                | Host
                | HostGroup String
                | Module
                | NotificationWay
                | Poller
                | Reactionner
                | Realm
                | Receiver
                | Scheduler
                | Service
                | TimePeriod
                deriving (Show)

