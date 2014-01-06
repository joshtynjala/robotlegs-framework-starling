/*
 * Copyright (c) 2009 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.starling.mvcs
{
	import org.robotlegs.starling.base.EventMap;
	import org.robotlegs.starling.core.IEventMap;

	import starling.events.Event;

	import starling.events.EventDispatcher;

	/**
	 * Abstract MVCS <code>IActor</code> implementation
	 *
	 * <p>As part of the MVCS implementation the <code>Actor</code> provides core functionality to an applications
	 * various working parts.</p>
	 *
	 * <p>Some possible uses for the <code>Actor</code> include, but are no means limited to:</p>
	 *
	 * <ul>
	 * <li>Service classes</li>
	 * <li>Model classes</li>
	 * <li>Controller classes</li>
	 * <li>Presentation model classes</li>
	 * </ul>
	 *
	 * <p>Essentially any class where it might be advantageous to have basic dependency injection supplied is a candidate
	 * for extending <code>Actor</code>.</p>
	 *
	 */
	public class Actor
	{
		/**
		 * @private
		 */
		protected var _eventDispatcher:EventDispatcher;
		
		/**
		 * @private
		 */
		protected var _eventMap:IEventMap;
		
		//---------------------------------------------------------------------
		//  Constructor
		//---------------------------------------------------------------------
		
		public function Actor()
		{
		}
		
		//---------------------------------------------------------------------
		//  API
		//---------------------------------------------------------------------
		
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
		
		//---------------------------------------------------------------------
		//  Internal
		//---------------------------------------------------------------------
		
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
		 * @param event The <code>Event</code> to dispatch on the <code>IContext</code>'s <code>EventDispatcher</code>
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
	}
}
