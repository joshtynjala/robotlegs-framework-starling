/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.starling.base
{
	import flash.utils.getDefinitionByName;
	
	import org.robotlegs.starling.core.IMediator;

	import starling.events.Event;

	import starling.events.EventDispatcher;

	/**
	 * An abstract <code>IMediator</code> implementation
	 */
	public class MediatorBase implements IMediator
	{
		/**
		 * Feathers work-around part #1
		 */
		protected static var FeathersControlType:Class;

		/**
		 * Feathers work-around part #2
		 */
		protected static const feathersAvailable:Boolean = checkFeathers();
		
		/**
		 * Internal
		 *
		 * <p>This Mediator's View Component - used by the RobotLegs MVCS framework internally.
		 * You should declare a dependency on a concrete view component in your
		 * implementation instead of working with this property</p>
		 */
		protected var viewComponent:Object;
		
		/**
		 * Internal
		 *
		 * <p>In the case of deffered instantiation, onRemove might get called before
		 * onCreationComplete has fired. This here Bool helps us track that scenario.</p>
		 */
		protected var removed:Boolean;
		
		//---------------------------------------------------------------------
		//  Constructor
		//---------------------------------------------------------------------
		
		/**
		 * Creates a new <code>Mediator</code> object
		 */
		public function MediatorBase()
		{
		}
		
		//---------------------------------------------------------------------
		//  API
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function preRegister():void
		{
			removed = false;

			if (feathersAvailable && (viewComponent is FeathersControlType) && !viewComponent['isCreated'])
			{
				EventDispatcher(viewComponent).addEventListener('creationComplete', onCreationComplete);
			}
			else
			{
				onRegister();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function onRegister():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function preRemove():void
		{
			if (feathersAvailable && (viewComponent is FeathersControlType))
			{
				EventDispatcher(viewComponent).removeEventListener('creationComplete', onCreationComplete);
			}
			removed = true;
			onRemove();
		}
		
		/**
		 * @inheritDoc
		 */
		public function onRemove():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function getViewComponent():Object
		{
			return viewComponent;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setViewComponent(viewComponent:Object):void
		{
			this.viewComponent = viewComponent;
		}
		
		//---------------------------------------------------------------------
		//  Internal
		//---------------------------------------------------------------------

		/**
		 * Feathers work-around part #3
		 *
		 * <p>Checks for availability of Feathers by trying to get the class for IFeathersControl.</p>
		 */
		protected static function checkFeathers():Boolean
		{
			try
			{
				FeathersControlType = getDefinitionByName('feathers.core::IFeathersControl') as Class;
			}
			catch (error:Error)
			{
				// do nothing
			}
			return FeathersControlType != null;
		}

		/**
		 * Feathers work-around part #4
		 *
		 * <p><code>FeathersEventType.CREATION_COMPLETE</code> handler for this Mediator's View Component</p>
		 *
		 * @param e The event
		 */
		protected function onCreationComplete(e:Event):void
		{
			e.target.removeEventListener('creationComplete', onCreationComplete);

			if (!removed)
				onRegister();
		}
	
	}
}
