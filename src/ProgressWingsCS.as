/*
 *  __  __      
 * /\ \/\ \  __________   
 * \ \ \_\ \/_______  /\   
 *  \ \  _  \  ____/ / /  
 *   \ \_\ \_\ \ \/ / / 
 *    \/_/\/_/\ \ \/ /  
 *             \ \  /
 *              \_\/
 *
 * -----------------------------------------------------------------------------
 * @author: Herbert Veitengruber 
 * @version: 1.0.0
 * -----------------------------------------------------------------------------
 *
 * Copyright (c) 2010-2012 Herbert Veitengruber 
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 */
package
{
	import as3.hv.components.progress.IProgressSymbol;
	import as3.hv.components.progress.AbstractProgressSymbol;
	
	import flash.text.TextField;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	
	[IconFile("progressWingsIcon.png")]
	
	// =========================================================================
	// Class ProgressWingsCS
	// =========================================================================
	// Progress Symbol base class for ProgressWingsCS.swc 
	// I used this symbol for my Crimsion Skies Edtior "Aeronaut"
	//
	public class ProgressWingsCS 
			extends AbstractProgressSymbol 
			implements IProgressSymbol
	{
		
		/**
		 * =====================================================================
		 * Constructor
		 * =====================================================================
		 */
		public function ProgressWingsCS():void
		{
			super();
			
			// Assign the internal vars to the real component parameters.
			// Due to a bug in Flash CS3. the default values you set for
			// component parameters are only used if at least one of them is
			// changed in your movieclip.
			
			// component var = internal var 
			progressBackgroundColor = bgColor;
			progressBackgroundAlpha = bgAlpha;
			progressForegroundColor = fgColor;
			progressIdleAnimColor = idleAnimColor;
			
			percentTextColor = pTextColor;
			statusTextColor = sTextColor;
		}
		
		
		// =====================================================================
		// FUNCTIONS
		// =====================================================================
		
		/**
		 * ---------------------------------------------------------------------
		 * init
		 * ---------------------------------------------------------------------
		 */
		public function init():void 
		{
		    (this as MovieClip).movCycleAnim.gotoAndPlay(10);
			(this as MovieClip).movVisualProgress.gotoAndStop(1);
			(this as MovieClip).txtPercent.text = "0%";
			(this as MovieClip).txtStatus.text = "";
			
			this.visible = true;
		}
		
		/**
		 * ---------------------------------------------------------------------
		 * setProgressTo
		 * ---------------------------------------------------------------------
		 *
		 * Set the Progress to a new state.
		 *
		 * @param percent	A int between 0-100
		 * @param msg		A status message if your Symbol is able to show one.
		 */
		public function setProgressTo(
				percent:int, 
				msg:String
			):void 
		{
			//frames = 1-17
			
			if (percent == 0) {
				(this as MovieClip).txtPercent.text = percent+"%";
				(this as MovieClip).movVisualProgress.gotoAndStop(1);
			
			} else if (percent < 100) {
				(this as MovieClip).txtPercent.text = percent+"%";
				var frame:int = int( percent/100 *17);
				(this as MovieClip).movVisualProgress.gotoAndStop(frame);
			
			} else {
				(this as MovieClip).txtPercent.text = "100%";
				(this as MovieClip).movVisualProgress.gotoAndStop(17);
			}
			
			(this as MovieClip).txtStatus.text = msg;
		}
		
		
		/**
		 * ---------------------------------------------------------------------
		 * hide
		 * ---------------------------------------------------------------------
		 * hide the symbol and stop also animations inside.
		 */
		public function hide():void
		{
			this.visible = false;
		}
		
		// =====================================================================
		// COMPONENT PARAMETERS
		// =====================================================================
		
		/**
		 * ---------------------------------------------------------------------
		 * progressBackgroundColor
		 * ---------------------------------------------------------------------
		 * get/set
		 * Background color of our progress. in this case the outer circle.
		 */
		[Inspectable(name="Background Progress Color", type=Color, defaultValue="#000000")]
		public function set progressBackgroundColor(newcolor:uint)
		{
			this.bgColor = newcolor;
			this.recolorElement(
					(this as MovieClip).movProgressBG, 
					this.bgColor, 
					this.bgAlpha
				);
		}

		public function get progressBackgroundColor():uint
		{
			return this.bgColor;
		}
		
		/**
		 * ---------------------------------------------------------------------
		 * progressBackgroundAlpha
		 * ---------------------------------------------------------------------
		 * get/set
		 * Background alpha of our progress. in this case the outer circle.
		 */
		[Inspectable(name="Background Progress Alpha", type=Number, defaultValue=100)]
		public function set progressBackgroundAlpha(val:int)
		{
			if( val < 0 ) {
				val = 0;
			} else if( val > 100 ) {
				val = 100;
			} 
			
			this.bgAlpha = val;
			this.recolorElement(
					(this as MovieClip).movProgressBG, 
					this.bgColor, 
					this.bgAlpha
				);
			
		}

		public function get progressBackgroundAlpha():int
		{
			return this.bgAlpha;
		}
		
		/**
		 * ---------------------------------------------------------------------
		 * progressForegroundColor
		 * ---------------------------------------------------------------------
		 * get/set
		 * Foreground color of our progress. in this case the outer circle.
		 */
		[Inspectable(name="Foreground Progress Color", type=Color, defaultValue="#0x00CC00")]
		public function set progressForegroundColor(newcolor:uint)
		{
			this.fgColor = newcolor;
			this.recolorElement(
					(this as MovieClip).movVisualProgress, 
					this.fgColor, 
					100
				);
		}

		public function get progressForegroundColor():uint
		{
			return this.fgColor;
		}
		
		
		// --------------------------------------------------------
		// progressIdleAnimColor
		// --------------------------------------------------------
		// Komponentenparameter (get/set)
		// Kreiselanimationsfarbe 
		[Inspectable(name="Idle Animation Progress Color", type=Color, defaultValue="#FFFFFF")]
		public function set progressIdleAnimColor(newcolor:uint)
		{
			this.idleAnimColor = newcolor;
			this.recolorElement(
					(this as MovieClip).movCycleAnim, 
					this.idleAnimColor, 
					100
				);
		}

		public function get progressIdleAnimColor():uint
		{
			return this.idleAnimColor;
		}
		
		// --------------------------------------------------------
		// percentTextColor
		// --------------------------------------------------------
		// Komponentenparameter (get/set)
		// Farbe der Prozentanzeige
		[Inspectable(name="Percent Text Color", type=Color, defaultValue="#FFFFFF")]
		public function set percentTextColor(newcolor:uint)
		{
			this.pTextColor = newcolor;
			(this as MovieClip).txtPercent.textColor = pTextColor;
		}

		public function get percentTextColor():uint
		{
			return this.pTextColor;
		}
		
		// --------------------------------------------------------
		// statusTextColor
		// --------------------------------------------------------
		// Komponentenparameter (get/set)
		// Farbe der Statusmeldung
		[Inspectable(name="Status Text Color", type=Color, defaultValue="#FFFFFF")]
		public function set statusTextColor(newcolor:uint)
		{
			this.sTextColor = newcolor;
			(this as MovieClip).txtStatus.textColor = sTextColor;
		}

		public function get statusTextColor():uint
		{
			return this.sTextColor;
		}
		
		// --------------------------------------------------------
		// isStatusVisible
		// --------------------------------------------------------
		// Komponentenparameter (get/set)
		// Sichtbarkeit der Statusmeldung
		[Inspectable(name="Status is Visible", type=Boolean, defaultValue=true)]
		public function set isStatusVisible(isVisible:Boolean)
		{
			(this as MovieClip).txtStatus.visible = isVisible;
		}

		public function get isStatusVisible():Boolean
		{
			return (this as MovieClip).txtStatus.visible;
		}
	
	}
}