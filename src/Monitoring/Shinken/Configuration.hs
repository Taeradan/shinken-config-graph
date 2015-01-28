module Monitoring.Shinken.Configuration where

type Configuration = [ConfObject]

data ConfObject = HostGroup
                | Arbiter
                | Broker
                | Command
                | Contact
                | Contactgroup
                | Discoveryrule
                | Discoveryrun
                | Cost
                | Costgroup
                | Module
                | Notificationway
                | Poller
                | Reactionner
                | Realm
                | Receiver
                | Scheduler
                | Service
                | Timeperiod
                deriving (Show)


