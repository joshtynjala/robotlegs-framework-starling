/*
 * Copyright (c) 2009 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.starling.core
{
	import starling.events.EventDispatcher;

	/**
	 * The Robotlegs EventMap contract
	 */
	public interface IEventMap
	{
		/**
		 * The same as calling <code>addEventListener</code> directly on the <code>EventDispatcher</code>,
		 * but keeps a list of listeners for easy (usually automatic) removal.
		 *
		 * @param dispatcher The <code>IEventDispatcher</code> to listen to
		 * @param type The <code>Event</code> type to listen for
		 * @param listener The <code>Event</code> handler
		 * @param eventClass Optional Event class for a stronger mapping. Defaults to <code>starling.events.Event</code>.
		 */
		function mapListener(dispatcher:EventDispatcher, type:String, listener:Function, eventClass:Class = null):void;
		
		/**
		 * The same as calling <code>removeEventListener</code> directly on the <code>EventDispatcher</code>,
		 * but updates our local list of listeners.
		 *
		 * @param dispatcher The <code>EventDispatcher</code>
		 * @param type The <code>Event</code> type
		 * @param listener The <code>Event</code> handler
		 * @param eventClass Optional Event class for a stronger mapping. Defaults to <code>starling.events.Event</code>.
		 */
		function unmapListener(dispatcher:EventDispatcher, type:String, listener:Function, eventClass:Class = null):void;
		
		/**
		 * Removes all listeners registered through <code>mapListener</code>
		 */
		function unmapListeners():void;
	}
}