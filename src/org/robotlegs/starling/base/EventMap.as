/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.starling.base
{
	import org.robotlegs.starling.core.IEventMap;

	import starling.events.Event;

	import starling.events.EventDispatcher;

	/**
	 * An abstract <code>IEventMap</code> implementation
	 */
	public class EventMap implements IEventMap
	{
		/**
		 * The <code>EventDispatcher</code>
		 */
		protected var eventDispatcher:EventDispatcher;
		
		/**
		 * @private
		 */
		protected var _dispatcherListeningEnabled:Boolean = true;
		
		/**
		 * @private
		 */
		protected var listeners:Array;
		
		//---------------------------------------------------------------------
		//  Constructor
		//---------------------------------------------------------------------
		
		/**
		 * Creates a new <code>EventMap</code> object
		 *
		 * @param eventDispatcher An <code>IEventDispatcher</code> to treat as a bus
		 */
		public function EventMap(eventDispatcher:EventDispatcher)
		{
			listeners = new Array();
			this.eventDispatcher = eventDispatcher;
		}
		
		//---------------------------------------------------------------------
		//  API
		//---------------------------------------------------------------------
		
		/**
		 * @return Is shared dispatcher listening allowed?
		 */
		public function get dispatcherListeningEnabled():Boolean
		{
			return _dispatcherListeningEnabled;
		}
		
		/**
		 * @private
		 */
		public function set dispatcherListeningEnabled(value:Boolean):void
		{
			_dispatcherListeningEnabled = value;
		}
		
		/**
		 * The same as calling <code>addEventListener</code> directly on the <code>EventDispatcher</code>,
		 * but keeps a list of listeners for easy (usually automatic) removal.
		 *
		 * @param dispatcher The <code>IEventDispatcher</code> to listen to
		 * @param type The <code>Event</code> type to listen for
		 * @param listener The <code>Event</code> handler
		 * @param eventClass Optional Event class for a stronger mapping. Defaults to <code>starling.events.Event</code>.
		 */
		public function mapListener(dispatcher:EventDispatcher, type:String, listener:Function, eventClass:Class = null):void
		{
			if (dispatcherListeningEnabled == false && dispatcher == eventDispatcher)
			{
				throw new ContextError(ContextError.E_EVENTMAP_NOSNOOPING);
			}
			if (!eventClass)
			{
				eventClass = Event;
			}
			
			var params:Object;
			var i:int = listeners.length;
			while (i--)
			{
				params = listeners[i];
				if (params.dispatcher == dispatcher
					&& params.type == type
					&& params.listener == listener
					&& params.eventClass == eventClass)
				{
					return;
				}
			}
			
			var callback:Function = function(event:Event):void
				{
					routeEventToListener(event, listener, eventClass);
				};
			params = {
					dispatcher: dispatcher,
					type: type,
					listener: listener,
					eventClass: eventClass,
					callback: callback
				};
			listeners.push(params);
			dispatcher.addEventListener(type, callback);
		}
		
		/**
		 * The same as calling <code>removeEventListener</code> directly on the <code>EventDispatcher</code>,
		 * but updates our local list of listeners.
		 *
		 * @param dispatcher The <code>IEventDispatcher</code>
		 * @param type The <code>Event</code> type
		 * @param listener The <code>Event</code> handler
		 * @param eventClass Optional Event class for a stronger mapping. Defaults to <code>starling.events.Event</code>.
		 * @param useCapture
		 */
		public function unmapListener(dispatcher:EventDispatcher, type:String, listener:Function, eventClass:Class = null):void
		{
			if (!eventClass)
			{
				eventClass = Event;
			}
			var params:Object;
			var i:int = listeners.length;
			while (i--)
			{
				params = listeners[i];
				if (params.dispatcher == dispatcher
					&& params.type == type
					&& params.listener == listener
					&& params.eventClass == eventClass)
				{
					dispatcher.removeEventListener(type, params.callback);
					listeners.splice(i, 1);
					return;
				}
			}
		}
		
		/**
		 * Removes all listeners registered through <code>mapListener</code>
		 */
		public function unmapListeners():void
		{
			var params:Object;
			var dispatcher:EventDispatcher;
			params = listeners.pop();
			while (params)
			{
				dispatcher = params.dispatcher;
				dispatcher.removeEventListener(params.type, params.callback);
				params = listeners.pop();
			}
		}
		
		//---------------------------------------------------------------------
		//  Internal
		//---------------------------------------------------------------------
		
		/**
		 * Event Handler
		 *
		 * @param event The <code>Event</code>
		 * @param listener
		 * @param originalEventClass
		 */
		protected function routeEventToListener(event:Event, listener:Function, originalEventClass:Class):void
		{
			if (event is originalEventClass)
			{
				var numArgs:int = listener.length;
				if (numArgs == 0) listener();
				else if (numArgs == 1) listener(event);
				else listener(event, event.data);
			}
		}
	}
}
