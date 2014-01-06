/*
 * Copyright (c) 2009 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.starling.mvcs
{
	import org.robotlegs.starling.base.EventMap;
	import org.robotlegs.starling.base.MediatorBase;
	import org.robotlegs.starling.core.IEventMap;
	import org.robotlegs.starling.core.IMediatorMap;

	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * Abstract MVCS <code>IMediator</code> implementation
	 */
	public class Mediator extends MediatorBase
	{
		[Inject]
		public var contextView:DisplayObjectContainer;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		/**
		 * @private
		 */
		protected var _eventDispatcher:EventDispatcher;
		
		/**
		 * @private
		 */
		protected var _eventMap:IEventMap;
		
		public function Mediator()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function preRemove():void
		{
			if (_eventMap)
				_eventMap.unmapListeners();
			super.preRemove();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get eventDispatcher():EventDispatcher
		{
			return _eventDispatcher;
		}
		
		[Inject]
		/**
		 * @private
		 */
		public function set eventDispatcher(value:EventDispatcher):void
		{
			_eventDispatcher = value;
		}
		
		/**
		 * Local EventMap
		 *
		 * @return The EventMap for this Actor
		 */
		protected function get eventMap():IEventMap
		{
			return _eventMap || (_eventMap = new EventMap(eventDispatcher));
		}
		
		/**
		 * Dispatch helper method
		 *
		 * @param event The Event to dispatch on the <code>IContext</code>'s <code>EventDispatcher</code>
		 */
		protected function dispatch(event:Event):void
		{
 		    eventDispatcher.dispatchEvent(event);
		}

		/**
		 * Dispatch helper method with pooling
		 *
		 * @param type The <code>Event</code> type to dispatch on the <code>IContext</code>'s <code>EventDispatcher</code>
		 * @param bubbles Whether the event bubbles
		 * @param data The payload to include with the event
		 */
		protected function dispatchWith(type:String, bubbles:Boolean = false, data:Object = null):void
		{
			eventDispatcher.dispatchEventWith(type, bubbles, data);
		}
		
		/**
		 * Syntactical sugar for mapping a listener to the <code>viewComponent</code> 
		 * 
		 * @param type
		 * @param listener
		 * @param eventClass
		 * 
		 */		
		protected function addViewListener(type:String, listener:Function, eventClass:Class = null):void
		{
			eventMap.mapListener(EventDispatcher(viewComponent), type, listener, eventClass);
		}

        /**
		 * Syntactical sugar for mapping a listener from the <code>viewComponent</code>
		 *
		 * @param type
		 * @param listener
		 * @param eventClass
		 *
		 */
		protected function removeViewListener(type:String, listener:Function, eventClass:Class = null):void
		{
			eventMap.unmapListener(EventDispatcher(viewComponent), type, listener, eventClass);
		}

		/**
		 * Syntactical sugar for mapping a listener to an <code>EventDispatcher</code>
		 * 
		 * @param dispatcher
		 * @param type
		 * @param listener
		 * @param eventClass
		 * 
		 */		
		protected function addContextListener(type:String, listener:Function, eventClass:Class = null):void
	 	{
			eventMap.mapListener(eventDispatcher, type, listener, eventClass);
		}

		/**
		 * Syntactical sugar for unmapping a listener from an <code>IEventDispatcher</code>
		 *
		 * @param dispatcher
		 * @param type
		 * @param listener
		 * @param eventClass
		 *
		 */
		protected function removeContextListener(type:String, listener:Function, eventClass:Class = null):void
	 	{
			eventMap.unmapListener(eventDispatcher, type, listener, eventClass);
		}
	}
}
