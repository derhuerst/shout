# *shout* – A realtime notification service.

*shout* is a service to let organizers of a group send push notifications its subscribers.

## What is broken?

**People want to receive notifications about things they are interested in.** For example:

- They might want to help refugees in Berlin, but **don't know where, because the demand for helpers changes every day**.
- They might join a demonstration. Getting to know where the people are right now is difficult and **often they have to refresh Twitter contstantly**.
- There are meetups, flashmobs and happenings all over the city. **It's really hard to notice *fast enough* that something will happen.** In addition, effectively, you need to be on Facebook, Meetup, Twitter (and check dozens of hashtags) and Foursquare and therefore get a lot of noise.

There are tools for this like Facebook, Twitter, GitHub and blogs. **But all of these are either for long-term things** (like joining a group on Facebook) **or not realtime enough** (don't provide push notifications). Many people have notifications turned off for Twitter & Facebook, simply because the **noise level is too high**, simply because they don't want to go through all the selfies, game invitations and spam.



## How do we solve it?

**Let's create a service that enables people to do just one thing: To get notified what happens in certain groups.** For this we need two things:

1. A website where people can create a group and – using a key they get – send messages to all subscribers in realtime. No accounts, no emails, no admin panel.
2. An app that people can download. They can subscribe to groups by clicking on an [URL-schemed link](https://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899) in order to receive push notifications.



## What about Pushbullet & Co?

**There are soo many services for push notifications, but they all have shortcomings.**

- They require an account or a complicated setup, raising the entry barrier and therefore hinder adoption.
- There are white-label services targeted to developers who integrate them into other apps & services.
- There are services targeted to paying, commercial customers.
- There are services newsletter companies like MailChimp, but again, newsletters are far too noisy and not realtime enough.
- There are chats, IRC and so on, where the complexity of following a group is too high (and noise is a problem again). The barrier is too damn high.



## Contributing

If you **have a question**, **found a bug** or want to **propose a feature**, have a look at [the issues page](https://github.com/derhuerst/shout/issues).
