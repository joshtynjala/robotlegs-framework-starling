/*
 * Copyright (c) 2009 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.starling.mvcs
{
	import org.robotlegs.starling.core.ICommandMap;
	import org.robotlegs.starling.core.IInjector;
	import org.robotlegs.starling.core.IMediatorMap;

	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * Abstract MVCS command implementation
	 */
	public class Command
	{
		[Inject]
		public var contextView:DisplayObjectContainer;
		
		[Inject]
		public var commandMap:ICommandMap;
		
		[Inject]
		public var eventDispatcher:EventDispatcher;
		
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		public function Command()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function execute():void
		{
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