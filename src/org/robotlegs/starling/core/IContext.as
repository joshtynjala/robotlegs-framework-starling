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
	 * The Robotlegs Context contract
	 */
	public interface IContext
	{
		/**
		 * The <code>IContext</code>'s <code>EventDispatcher</code>
		 */
		function get eventDispatcher():EventDispatcher;
	
	}
}