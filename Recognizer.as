// ActionScript file
package 	
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.charts.AreaChart;
	import mx.messaging.channels.StreamingAMFChannel;
	
	import spark.primitives.Rect;

   // Rectangle class

	public class Recognizer {
		
		public static var NumPoints:int = 64;
		public static var SquareSize:Number = 250.0;
		public static var HalfDiagonal:Number = 0.5 * Math.sqrt(250.0 * 250.0 + 250.0 * 250.0);
		public static var AngleRange:Number = 45.0;
		public static var AnglePrecision:Number = 2.0;
		public static var Phi:Number = 0.5 * (-1.0 + Math.sqrt(5.0)); // Golden Ratio
		
		public var templates:Array;
		//
		// DollarRecognizer class
		//
		public function Recognizer() // constructor
		{  
			this.templates=new Array();
			
			this.templates[0] = new Template("Courseworks",new Array(
				new Point(209,330),new Point(210,331),new Point(212,335),new Point(215,341),new Point(218,350),new Point(222,367),
				new Point(226,383),new Point(229,399),new Point(230,416),new Point(233,436),new Point(235,454),new Point(239,470),
				new Point(242,480),new Point(246,491),new Point(247,495),new Point(250,500),new Point(251,504),new Point(253,506),
				new Point(253,508),new Point(254,508),new Point(255,507),new Point(256,505),new Point(257,502),new Point(259,500),
				new Point(262,494),new Point(267,486),new Point(271,476),new Point(274,467),new Point(280,454),new Point(285,437),
				new Point(294,419),new Point(300,407),new Point(306,393),new Point(308,382),new Point(311,374),new Point(314,370),
				new Point(317,364),new Point(318,358),new Point(320,353),new Point(323,348),new Point(326,344),new Point(326,342),
				new Point(326,341),new Point(326,340),new Point(326,339),new Point(326,340),new Point(326,341),new Point(326,342),
				new Point(326,345),new Point(326,348),new Point(326,353),new Point(327,359),new Point(329,369),new Point(329,383),
				new Point(331,403),new Point(333,422),new Point(337,440),new Point(340,453),new Point(345,462),new Point(346,467),
				new Point(346,470),new Point(347,474),new Point(347,477),new Point(347,480),new Point(349,483),new Point(349,486),
				new Point(349,489),new Point(351,493),new Point(352,495),new Point(352,497),new Point(352,498),new Point(352,499),
				new Point(353,500),new Point(353,501),new Point(354,503),new Point(354,504),new Point(355,506),new Point(357,509),
				new Point(358,511),new Point(360,512),new Point(360,513),new Point(361,514),new Point(362,514),new Point(364,512),
				new Point(368,509),new Point(371,506),new Point(376,498),new Point(382,487),new Point(391,472),new Point(399,459),
				new Point(409,444),new Point(421,428),new Point(434,411),new Point(445,398),new Point(455,385),new Point(461,373),
				new Point(467,363),new Point(468,357),new Point(470,351),new Point(471,347),new Point(473,343),new Point(473,340),
				new Point(474,337),new Point(476,334)));
			
			
			this.templates[1] = new Template("CS Department Page", new Array(
				new Point(299,451),new Point(299,449),new Point(299,446),new Point(299,441),new Point(299,436),new Point(299,430),
				new Point(299,423),new Point(299,415),new Point(300,403),new Point(301,391),new Point(301,377),new Point(302,369),
				new Point(303,359),new Point(303,350),new Point(304,340),new Point(306,332),new Point(311,305),new Point(312,292),
				new Point(312,289),new Point(312,282),new Point(312,279),new Point(313,277),new Point(313,276),new Point(314,273),
				new Point(315,267),new Point(316,261),new Point(318,258),new Point(318,256),new Point(318,253),new Point(319,252),
				new Point(319,250),new Point(320,250),new Point(320,248),new Point(321,247),new Point(323,245),new Point(324,245),
				new Point(326,245),new Point(330,243),new Point(334,243),new Point(342,243),new Point(349,243),new Point(360,246),
				new Point(371,250),new Point(381,254),new Point(390,259),new Point(400,267),new Point(409,277),new Point(417,288),
				new Point(421,295),new Point(423,302),new Point(426,309),new Point(426,314),new Point(426,322),new Point(428,331),
				new Point(429,340),new Point(429,346),new Point(429,354),new Point(426,363),new Point(423,371),new Point(421,375),
				new Point(418,380),new Point(415,386),new Point(409,392),new Point(401,400),new Point(391,409),new Point(380,417),
				new Point(369,426),new Point(361,432),new Point(355,437),new Point(351,440),new Point(349,441),new Point(346,442),
				new Point(343,443),new Point(340,443),new Point(338,443),new Point(336,443),new Point(334,443),new Point(334,444),
				new Point(332,444),new Point(330,444),new Point(328,445),new Point(327,445),new Point(324,446),new Point(322,446),
				new Point(320,446),new Point(317,446),new Point(315,446),new Point(314,447),new Point(311,447),new Point(309,447),
				new Point(307,449),new Point(305,449),new Point(304,449)));
			
			this.templates[2] = new Template("SSOL", new Array(
				new Point(446,189),new Point(446,188),new Point(441,187),new Point(433,185),new Point(422,184),new Point(409,182),
				new Point(392,181),new Point(379,180),new Point(367,182),new Point(358,185),new Point(354,188),new Point(348,193),
				new Point(344,197),new Point(341,202),new Point(338,207),new Point(335,212),new Point(330,220),new Point(328,226),
				new Point(325,232),new Point(323,239),new Point(322,246),new Point(322,253),new Point(322,259),new Point(324,268),
				new Point(329,278),new Point(335,289),new Point(346,300),new Point(357,309),new Point(370,317),new Point(381,326),
				new Point(393,335),new Point(406,343),new Point(412,348),new Point(416,354),new Point(423,363),new Point(430,373),
				new Point(435,381),new Point(440,388),new Point(441,394),new Point(441,400),new Point(443,409),new Point(444,415),
				new Point(443,421),new Point(441,424),new Point(437,430),new Point(433,436),new Point(427,441),new Point(418,447),
				new Point(407,453),new Point(396,459),new Point(381,465),new Point(371,467),new Point(361,467),new Point(348,466),
				new Point(342,464),new Point(333,463),new Point(329,461),new Point(326,460),new Point(325,460),new Point(324,460),
				new Point(323,459),new Point(322,459),new Point(321,459)));
			
			this.templates[3] = new Template("CU Home Page", new Array(
				new Point(482,207),new Point(481,207),new Point(480,207),new Point(478,207),new Point(475,207),new Point(470,207),
				new Point(461,208),new Point(448,210),new Point(435,213),new Point(424,217),new Point(414,222),new Point(408,226),
				new Point(405,229),new Point(400,235),new Point(394,241),new Point(390,247),new Point(386,252),new Point(383,258),
				new Point(379,265),new Point(376,271),new Point(372,279),new Point(369,288),new Point(366,298),new Point(365,307),
				new Point(362,315),new Point(362,324),new Point(360,334),new Point(360,339),new Point(360,351),new Point(360,360),
				new Point(362,366),new Point(363,371),new Point(367,377),new Point(372,383),new Point(374,386),new Point(377,391),
				new Point(380,395),new Point(383,400),new Point(387,404),new Point(396,410),new Point(406,417),new Point(416,421),
				new Point(426,424),new Point(439,429),new Point(456,433),new Point(475,436),new Point(487,438),new Point(493,438),
				new Point(496,438),new Point(499,439),new Point(501,439),new Point(504,439),new Point(506,439)));
			
			this.templates[4] = new Template("Library Page", new Array(
				new Point(346,182),new Point(346,183),new Point(346,184),new Point(346,185),new Point(344,186),new Point(344,193),
				new Point(344,203),new Point(346,214),new Point(349,246),new Point(349,266),new Point(346,289),new Point(343,309),
				new Point(340,362),new Point(340,386),new Point(338,402),new Point(331,425),new Point(328,436),new Point(324,461),
				new Point(323,466),new Point(320,472),new Point(319,475),new Point(319,478),new Point(319,480),new Point(321,479),
				new Point(324,476),new Point(329,474),new Point(336,472),new Point(347,469),new Point(355,468),new Point(367,466),
				new Point(380,465),new Point(399,463),new Point(410,463),new Point(414,463),new Point(417,463),new Point(419,463),
				new Point(424,464),new Point(427,464),new Point(429,464),new Point(435,466),new Point(438,466),new Point(439,466)));
			
			this.templates[5] = new Template("Cubmail", new Array(
				new Point(238,430),new Point(238,428),new Point(238,422),new Point(238,415),new Point(245,391),new Point(252,368),
				new Point(257,356),new Point(261,342),new Point(265,332),new Point(278,305),new Point(284,293),new Point(290,281),
				new Point(301,264),new Point(307,257),new Point(311,252),new Point(313,249),new Point(314,247),new Point(315,247),
				new Point(315,249),new Point(315,251),new Point(315,254),new Point(315,257),new Point(315,261),new Point(315,268),
				new Point(315,279),new Point(315,291),new Point(315,313),new Point(315,340),new Point(315,361),new Point(318,373),
				new Point(319,386),new Point(321,392),new Point(321,395),new Point(321,397),new Point(321,398),new Point(321,399),
				new Point(321,401),new Point(321,402),new Point(321,405),new Point(321,406),new Point(321,407),new Point(322,405),
				new Point(325,402),new Point(329,396),new Point(334,388),new Point(345,378),new Point(356,364),new Point(371,348),
				new Point(391,330),new Point(414,312),new Point(428,299),new Point(438,288),new Point(443,283),new Point(444,282),
				new Point(445,281),new Point(445,279),new Point(446,279),new Point(447,278),new Point(447,276),new Point(447,275),
				new Point(448,275),new Point(448,273),new Point(448,276),new Point(448,280),new Point(448,288),new Point(448,296),
				new Point(448,311),new Point(448,328),new Point(450,345),new Point(453,362),new Point(456,375),new Point(457,381),
				new Point(460,387),new Point(460,390),new Point(460,393),new Point(460,399),new Point(460,403),new Point(460,409),
				new Point(461,411),new Point(461,413),new Point(462,414),new Point(462,415)));

			this.templates[6] = new Template("CS Department Page", new Array(			
				new Point(267,96),new Point(267,98),new Point(267,104),new Point(265,117),new Point(265,134),new Point(265,154),
				new Point(264,170),new Point(264,188),new Point(264,205),new Point(264,218),new Point(264,229),new Point(264,237),
				new Point(264,243),new Point(264,248),new Point(262,251),new Point(262,255),new Point(261,258),new Point(261,257),
				new Point(261,255),new Point(261,252),new Point(261,249),new Point(261,245),new Point(261,240),new Point(261,234),
				new Point(261,230),new Point(262,225),new Point(262,220),new Point(262,214),new Point(263,210),new Point(263,207),
				new Point(263,202),new Point(263,197),new Point(263,192),new Point(263,189),new Point(263,183),new Point(263,176),
				new Point(263,167),new Point(264,159),new Point(264,153),new Point(264,146),new Point(265,137),new Point(267,130),
				new Point(269,122),new Point(272,115),new Point(275,106),new Point(278,99),new Point(279,96),new Point(280,96),
				new Point(280,94),new Point(280,93),new Point(281,93),new Point(282,93),new Point(285,93),new Point(288,93),
				new Point(295,93),new Point(304,95),new Point(313,97),new Point(320,100),new Point(326,103),new Point(332,106),
				new Point(337,109),new Point(342,113),new Point(350,119),new Point(358,127),new Point(362,133),new Point(365,137),
				new Point(368,142),new Point(370,147),new Point(373,153),new Point(374,159),new Point(374,165),new Point(375,170),
				new Point(377,178),new Point(377,183),new Point(377,188),new Point(377,192),new Point(377,195),new Point(376,199),
				new Point(374,203),new Point(374,206),new Point(371,211),new Point(368,216),new Point(363,222),new Point(360,228),
				new Point(354,234),new Point(345,240),new Point(337,246),new Point(329,251),new Point(325,252),new Point(319,254),
				new Point(315,254),new Point(310,255),new Point(307,255),new Point(301,257),new Point(296,257),new Point(291,258),
				new Point(286,259),new Point(285,259),new Point(282,259),new Point(280,259),new Point(276,259),new Point(272,259),
				new Point(269,259)));

			this.templates[7] = new Template("Library Page", new Array(
				new Point(281,63),new Point(281,65),new Point(281,68),new Point(281,76),new Point(281,84),new Point(281,99),new Point(281,115),
				new Point(282,139),new Point(283,168),new Point(284,189),new Point(285,207),new Point(285,217),new Point(285,226),new Point(285,233),
				new Point(284,237),new Point(284,242),new Point(282,247),new Point(282,251),new Point(281,257),new Point(280,263),new Point(280,266),
				new Point(280,268),new Point(280,267),new Point(282,264),new Point(292,259),new Point(308,256),new Point(326,252),new Point(338,250),
				new Point(348,250),new Point(357,250),new Point(366,250),new Point(376,250),new Point(383,250),new Point(392,250),new Point(401,250),
				new Point(407,250),new Point(414,251),new Point(427,254),new Point(439,256),new Point(443,256),new Point(445,257)));

			this.templates[8] = new Template("SSOL", new Array(			
				new Point(271,125),new Point(271,124),new Point(265,123),new Point(252,122),new Point(236,122),new Point(228,122),new Point(223,122),new Point(222,123),new Point(220,123),new Point(219,124),new Point(217,126),new Point(214,128),new Point(211,132),new Point(210,133),new Point(209,135),new Point(208,138),new Point(207,144),new Point(207,148),new Point(207,152),new Point(207,155),new Point(209,161),new Point(218,169),new Point(228,179),new Point(235,187),new Point(243,194),new Point(254,201),new Point(259,208),new Point(261,211),new Point(261,213),new Point(261,216),new Point(261,219),new Point(261,224),new Point(261,230),new Point(261,233),new Point(259,237),new Point(256,241),new Point(254,244),new Point(251,246),new Point(250,247),new Point(245,249),new Point(241,252),new Point(236,253),new Point(228,255),new Point(217,258),new Point(199,261),new Point(180,263),new Point(161,263),new Point(152,264),new Point(147,264),new Point(145,264),new Point(144,264),new Point(142,264),new Point(135,262),new Point(121,259),new Point(109,256),new Point(101,255)));

		
		this.templates[9] = new Template("Courseworks",new Array(		
		new Point(158,146),new Point(160,148),new Point(160,152),new Point(160,161),new Point(160,168),new Point(160,180),new Point(160,195),new Point(161,216),new Point(163,235),new Point(164,245),new Point(168,257),new Point(171,266),new Point(174,272),new Point(177,275),new Point(182,277),new Point(185,277),new Point(191,272),new Point(196,268),new Point(205,260),new Point(215,249),new Point(222,240),new Point(223,234),new Point(226,225),new Point(227,221),new Point(227,219),new Point(227,217),new Point(228,219),new Point(228,225),new Point(231,235),new Point(236,248),new Point(241,259),new Point(248,270),new Point(257,274),new Point(264,274),new Point(273,273),new Point(280,268),new Point(285,263),new Point(291,256),new Point(299,246),new Point(313,228),new Point(326,205),new Point(338,183),new Point(344,170),new Point(347,161),new Point(348,158)));
		}
		//
		// The $1 Gesture Recognizer API begins here!
		//
		
		//public function Recognizer(){
			//this.Templates = new Array();
		//}
		
		public function recognize(points:Array):String
		{
			points = Resample(points, NumPoints);
			points = RotateToZero(points);
			points = ScaleToSquare(points, SquareSize);
			points = TranslateToOrigin(points);
			
			var b:Number = +Infinity;
			var t:uint;
			var resultstr:String="Gesture not found. Please try again.";
			for (var i:int = 0; i < this.templates.length; i++)
			{
				var d:Number = DistanceAtBestAngle(points, this.templates[i], -AngleRange, +AngleRange, AnglePrecision);
				if (d < b)
				{
					b = d;
					t = i;
				}
			}
			var score:Number = 1.0 - (b / HalfDiagonal);
			var result_template:Template=this.templates[t];
			//var testres=new Result(this.templates[t].Name, score);
			//return new Result(this.templates[t].Name, score);
			if(score<0.7){
				return resultstr;
			}
			else{return result_template.name;}
		}
		//
		// add/delete new templates
		//
		
		
		public function addTemplate(name:String, points:Array):Number
		{
			this.templates[this.templates.length] = new Template(name, points); // append new template
			var num:Number = 0;
			for (var i:int = 0; i < this.templates.length; i++)
			{
				if (this.templates[i].Name == name)
					num++;
			}
			return num;
		}
		
		
		// Helper functions
		
		public static function Resample(points:Array, n:uint):Array
		{
			var I:Number = PathLength(points) / (n - 1); // interval length
			var D:Number = 0.0;
			var newpoints:Array = new Array(points[0]);
			for (var i:int = 1; i < points.length; i++)
			{
				var d:Number = Distance(points[i - 1], points[i]);
				if ((D + d) >= I)
				{
					var qx:Number = points[i - 1].x + ((I - D) / d) * (points[i].x - points[i - 1].x);
					var qy:Number = points[i - 1].y + ((I - D) / d) * (points[i].y - points[i - 1].y);
					var q:Point = new Point(qx, qy);
					newpoints[newpoints.length] = q; // append new point 'q'
					points.splice(i, 0, q); // insert 'q' at position i in points s.t. 'q' will be the next i
					D = 0.0;
				}
				else D += d;
			}
			// somtimes we fall a rounding-error short of adding the last point, so add it if so
			if (newpoints.length == n - 1)
			{
				newpoints[newpoints.length] = points[points.length - 1];
			}
			return newpoints;
		}
		public static function RotateToZero(points:Array):Array
		{
			var c:Point = Centroid(points);
			var theta:Number = Math.atan2(c.y - points[0].y, c.x - points[0].x);
			return RotateBy(points, -theta);
		}
		
		public static function ScaleToSquare(points:Array, size:Number):Array
		{
			var B:Rectangle = BoundingBox(points);
			var newpoints:Array = new Array();
			for (var i:int = 0; i < points.length; i++)
			{
				var qx:Number = points[i].x * (size / B.width);
				var qy:Number = points[i].y * (size / B.height);
				newpoints[newpoints.length] = new Point(qx, qy);
			}
			return newpoints;
		}			
		public static function TranslateToOrigin(points:Array):Array
		{
			var c:Point = Centroid(points);
			var newpoints:Array = new Array();
			for (var i:int = 0; i < points.length; i++)
			{
				var qx:Number = points[i].x - c.x;
				var qy:Number = points[i].y - c.y;
				newpoints[newpoints.length] = new Point(qx, qy);
			}
			return newpoints;
		}
		
		public static function DistanceAtBestAngle(points:Array, T:Template, a:Number, b:Number, threshold:Number):Number
		{
			var x1:Number = Phi * a + (1.0 - Phi) * b;
			var f1:Number = DistanceAtAngle(points, T, x1);
			var x2:Number = (1.0 - Phi) * a + Phi * b;
			var f2:Number = DistanceAtAngle(points, T, x2);
			while (Math.abs(b - a) > threshold)
			{
				if (f1 < f2)
				{
					b = x2;
					x2 = x1;
					f2 = f1;
					x1 = Phi * a + (1.0 - Phi) * b;
					f1 = DistanceAtAngle(points, T, x1);
				}
				else
				{
					a = x1;
					x1 = x2;
					f1 = f2;
					x2 = (1.0 - Phi) * a + Phi * b;
					f2 = DistanceAtAngle(points, T, x2);
				}
			}
			return Math.min(f1, f2);
		}
		
		public static function PathLength(points:Array):Number
		{
			var d:Number = 0.0;
			for (var i:int = 1; i < points.length; i++)
				d += Distance(points[i - 1], points[i]);
			return d;
		}
		
		public static function Distance(p1:Point, p2:Point):Number
		{
			var dx:Number = p2.x - p1.x;
			var dy:Number = p2.y - p1.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		public static function Centroid(points:Array):Point
		{
			var x:Number = 0.0, y:Number = 0.0;
			for (var i:int = 0; i < points.length; i++)
			{
				x += points[i].x;
				y += points[i].y;
			}
			x /= points.length;
			y /= points.length;
			return new Point(x, y);
		}
		public static function RotateBy(points:Array, theta:Number):Array
		{
			var c:Point = Centroid(points);
			var cos:Number = Math.cos(theta);
			var sin:Number = Math.sin(theta);
			
			var newpoints:Array = new Array();
			for (var i:int = 0; i < points.length; i++)
			{
				var qx:Number = (points[i].x - c.x) * cos - (points[i].y - c.y) * sin + c.x
				var qy:Number = (points[i].x - c.x) * sin + (points[i].y - c.y) * cos + c.y;
				newpoints[newpoints.length] = new Point(qx, qy);
			}
			return newpoints;
		}
		public static function BoundingBox(points:Array):Rectangle
		{
			var minX:Number = +Infinity, maxX:Number = -Infinity, minY:Number = +Infinity, maxY:Number = -Infinity;
			for (var i:int = 0; i < points.length; i++)
			{
				if (points[i].x < minX)
					minX = points[i].x;
				if (points[i].x > maxX)
					maxX = points[i].x;
				if (points[i].y < minY)
					minY = points[i].y;
				if (points[i].y > maxY)
					maxY = points[i].y;
			}
			return new Rectangle(minX, minY, maxX - minX, maxY - minY);
		}
		
		public static function DistanceAtAngle(points:Array, T:Template, theta:Number):Number
		{
			var newpoints:Array = RotateBy(points, theta);
			return PathDistance(newpoints, T.points);
		}
		
		public static function PathDistance(pts1:Array, pts2:Array):Number
		{
			var d:Number = 0.0;
			for (var i:int = 0; i < pts1.length; i++) // assumes pts1.length == pts2.length
				d += Distance(pts1[i], pts2[i]);
			return d / pts1.length;
		}
		public function Deg2Rad(d:Number):Number
		{
			return (d * Math.PI / 180.0);
		}
		public function Rad2Deg(r:Number):Number
		{
			return (r * 180.0 / Math.PI);
		}
	}

}