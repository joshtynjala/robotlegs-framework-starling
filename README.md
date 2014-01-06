# Robotlegs Framework for Starling and Feathers

This is a complete port of [Robotlegs](http://www.robotlegs.org/) version 1.x targeting [Starling Framework](http://starling-framework.org/) instead of the classic display list. Unlike the [robotlegs-starling-plugin](https://github.com/s9tpepper/robotlegs-starling-plugin), which extends the existing Robotlegs library to add support for Starling display objects, this fork changes the core internals of Robotlegs to specifically target Starling only.

## Notable Changes and Features

* Uses `starling.events.EventDispatcher` instead of `flash.events.EventDispatcher` for all events, including the context.
* Support for Starling's event pooling, to reduce garbage collection and increase performance (especially on mobile!).
* Can take advange of the `data` property on Starling events and the optional strongly-typed `data` argument on Starling event listeners to avoid the creation of many event subclasses.
* Adds a `dispatchWith()` convenience function next to the existing `dispatch()` convenience function on things like commands and mediators to quickly dispatch pooled events.

## Links

* [Compiled SWC](http://feathersui.com/download/other/robotlegs-framework-starling-v0.9.0.swc)
* [API Reference](http://feathersui.com/documentation/robotlegs-starling)

## Credits

Based on the hard work of the original Robotlegs contributors. Ported to Starling by [Josh Tynjala](http://twitter.com/joshtynjala), creator of the [Feathers](http://feathersui.com/) open source user interface components for Starling.